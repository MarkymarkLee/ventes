import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.amber,
      ),
    );
  }
}

class AlertLoading extends StatelessWidget {
  const AlertLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text("Loading")),
        ],
      ),
    );
  }
}