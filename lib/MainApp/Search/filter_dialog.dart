import 'package:flutter/material.dart';
import 'package:ventes/Components/components.dart';
import 'package:collection/collection.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  List<TextEditingController> _tagControllers =
      List<TextEditingController>.generate(
          0, (index) => TextEditingController());

  final _eventNameController = TextEditingController();
  static const List<String> minLikes = [
    "0",
    "1",
    "5",
    "10",
    "50",
    "100",
    "500",
    "1000"
  ];
  String selectedMinLikes = "0";

  void onRemoveTag(int index) {
    setState(() {
      _tagControllers.removeAt(index);
    });
  }

  void onResetAll() {
    setState(() {
      _tagControllers = List<TextEditingController>.generate(
          0, (index) => TextEditingController());
      _eventNameController.clear();
      selectedMinLikes = "0";
    });
  }

  void onApplyAll() {
    List<String> tags = _tagControllers
        .map((tagController) => tagController.text.toLowerCase())
        .toList();
    String eventName = _eventNameController.text;

    Map finalFilter = {
      "tags": tags,
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

            // event name
            MyTextField(
                controller: _eventNameController,
                hintText: "",
                errorText: "",
                fieldName: "Event name",
                fieldNameColor: Colors.amber.shade100),
            const SizedBox(height: 20),

            // tags
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Expanded(child: MyFieldnameBox(fieldName: "Tags")),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _tagControllers.add(TextEditingController());
                      });
                    },
                    icon: Icon(Icons.add_circle_outline,
                        color: Colors.amber.shade200)),
              ]),
            ),
            const SizedBox(height: 20),
            _tagControllers.isNotEmpty
                ? Column(
                    children: _tagControllers.mapIndexed((idx, tagController) {
                    return Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  onRemoveTag(idx);
                                },
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.amber.shade200,
                                ),
                              ),
                              Expanded(
                                child: MyTextField(
                                  controller: tagController,
                                  hintText: "",
                                  errorText: "",
                                  fieldNameColor: Colors.amber.shade100,
                                ),
                              )
                            ],
                          )),
                      const SizedBox(height: 20),
                    ]);
                  }).toList())
                : Container(),
            
            // time
            

            // min likes
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
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
                  ))),
            ),

            // apply and reset buttons
            const SizedBox(height: 20),
            MyButton(onTap: onApplyAll, buttonText: "Apply all filters"),
            const SizedBox(height: 20),
            MyButton(onTap: onResetAll, buttonText: "Reset all filters"),
          ],
        ))));
  }
}
