import 'package:flutter/material.dart';
import 'package:ventes/Components/components.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final _tagController = TextEditingController();
  final _eventNameController = TextEditingController();
  static const List<String> minLikes = ["0", "10", "50", "100", "500", "1000"];
  String selectedMinLikes = "0";

  void onResetAll() {
    setState(() {
      _tagController.clear();
      _eventNameController.clear();
      selectedMinLikes = "0";
    });
  }

  void onApplyAll() {
    String tag = _tagController.text;
    String eventName = _eventNameController.text;

    Map finalFilter = {
      "tag": tag,
      "eventName": eventName,
      "minLikes": int.parse(selectedMinLikes)
    };

    Navigator.pop(context, finalFilter);
  }

  void onSelectedMinLikeChanged(String? newValue) {
    setState(() {
      selectedMinLikes = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Filter Events"),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            const SizedBox(height: 20),
            MyTextField(
                controller: _eventNameController,
                hintText: "",
                errorText: "",
                fieldName: "Event name",
                fieldNameColor: Colors.amber.shade100),
            const SizedBox(height: 20),
            MyTextField(
                controller: _tagController,
                hintText: "",
                errorText: "",
                fieldName: "Tags",
                fieldNameColor: Colors.amber.shade100),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 10.0),
                child: InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      labelText: 'Minimum likes : ',
                      labelStyle: TextStyle(color: Colors.amber.shade100),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      dropdownColor: Colors.brown,
                      style: const TextStyle(color: Colors.white),
                      onChanged: onSelectedMinLikeChanged,
                      value: selectedMinLikes,
                      items: minLikes.map((minLike) {
                        return DropdownMenuItem(
                          value: minLike,
                          child: Text(minLike),
                        );
                      }).toList(),
                    )))),
            const SizedBox(height: 20),
            MyButton(onTap: onResetAll, buttonText: "Reset all filters"),
            const SizedBox(height: 20),
            MyButton(onTap: onApplyAll, buttonText: "Apply all filters"),
          ],
        ))));
  }
}
