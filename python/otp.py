"""

This code is for email OTP for ventes

API: 

https://ventes.pythonanywhere.com/send-otp/<email>
- This will send an email to the user with the OTP
returns "success" if email is sent successfully

https://ventes.pythonanywhere.com/verify-otp/<email>/<otp>
- This will verify the OTP
returns "success" if OTP is correct and "fail" if OTP is wrong

Note that both the email and otp should be preprocessed and make sure that they're viable

"""
from email.message import EmailMessage
import smtplib
import ssl
import random

from flask import Flask
from flask_cors import CORS
import threading
import time
import json

password = "bpcbjfdpvxrougsm"

lock = threading.Lock()
TIME_LIMIT = 300

app = Flask(__name__)
CORS(app)

with open("otp.json", "w") as f:
    json.dump([], f)

def manage_otp(email,otp,action):

    with lock:
        with open("otp.json", "r") as f:
            data = json.load(f)
        current_time = int(time.time())
        while len(data)>0 and current_time-data[0]["time"] > 300:
            data.pop(0)
        
        verified = False
        if action == "add":
            data.append({"email":email,"otp":otp,"time":current_time})
        elif action == "verify":
            for i in range(len(data)):
                if data[i]["email"] == email and data[i]["otp"] == otp:
                    data.pop(i)
                    verified = True
                    break

        with open("otp.json", "w") as f:
            json.dump(data, f)

    return verified


@app.route('/')
def hello():
    return 'This is the backend for Ventes!'

@app.route('/send-otp/<email>')
def send_email(email):
    try:
        email_sender = "ventes.ntu@gmail.com"
        email_password = password
        email_receiver = email

        otp = str(random.randint(100000, 999999))

        manage_otp(email,otp,"add")

        subject = "Email Verification for Ventes"
        body = f"Hi, your verification code is {otp}.\nThis code will expire in 5 minutes.\n\nThank you for using Ventes!\n"
        em = EmailMessage()
        em["Subject"] = subject
        em["From"] = email_sender
        em["To"] = email_receiver
        em.set_content(body)

        with smtplib.SMTP(host="smtp.gmail.com", port=587) as smtp:
            smtp.starttls(context=ssl.create_default_context())
            smtp.login(email_sender, email_password)
            smtp.send_message(em)

        return "success"
    except:
        return "error"


@app.route('/verify-otp/<email>/<otp>')
def verify_otp(email,otp):
    try:
        verified = manage_otp(email,otp,"verify")
        
        if verified:
            return "success"
        else:
            return "fail"
    except:
        return "error"
