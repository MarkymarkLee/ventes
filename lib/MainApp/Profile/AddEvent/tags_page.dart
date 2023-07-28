import 'package:flutter/material.dart';
import 'package:ventes/MainApp/Profile/AddEvent/globals.dart';

// This is the third page for the add event process
// should add tags to the event
class TagsPage extends StatefulWidget {
  const TagsPage({super.key});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  List<String> recommendedTags = ["Club", "Sports", "Music", "Food", "Games"];
  var tagController = TextEditingController();
  var tagError = "";

  void refresh() {
    setState(() {});
  }

  void addTag(tag) {
    if (createdEvent.tags.length >= 15) {
      tagError = "There can only be 15 tags!";
      setState(() {});
      return;
    }
    if (!createdEvent.tags.contains(tag)) {
      createdEvent.tags.add(tag);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var myTagsWidget = [
      for (var tag in createdEvent.tags)
        Tag(
          name: tag,
          isAdded: true,
          refresh: refresh,
          addTag: addTag,
        )
    ];
    return SingleChildScrollView(
      child: Center(
          child: Column(
        children: [
          Text("Tags"),
          // Recommended tags
          Text("Recommended Tags"),
          Wrap(
            children: [
              for (var tag in recommendedTags)
                if (!createdEvent.tags.contains(tag))
                  Tag(
                    name: tag,
                    isAdded: false,
                    refresh: refresh,
                    addTag: addTag,
                  )
            ],
          ),

          // My tags
          Text("My Tags"),
          (myTagsWidget.length == 0)
              ? Text("No tags added yet")
              : Wrap(
                  children: myTagsWidget,
                ),

          // Add new tags
          Row(
            children: [
              Text("Add new tag: "),
              Flexible(
                child: TextField(
                  controller: tagController,
                ),
              ),
              IconButton(
                  onPressed: () {
                    // Add tag to event
                    var tag = tagController.text.trim();
                    if (tag == "") {
                      setState(() {
                        tagError = "tag cannot be empty";
                      });
                      return;
                    } else if (tag.length > 20) {
                      setState(() {
                        tagError = "tag cannot be longer than 30 characters";
                      });
                      return;
                    }
                    tagError = "";
                    tagController.clear();
                    addTag(tag);

                    setState(() {});
                  },
                  icon: Icon(Icons.add)),
            ],
          ),
          if (tagError != "") Text(tagError),
        ],
      )),
    );
  }
}

class Tag extends StatelessWidget {
  final String name;
  final bool isAdded;
  final refresh;
  final addTag;
  const Tag({
    super.key,
    required this.name,
    required this.isAdded,
    required this.refresh,
    required this.addTag,
  });

  @override
  Widget build(BuildContext context) {
    if (isAdded) {
      return Padding(
        padding: EdgeInsets.all(2),
        child: FilledButton(
            onPressed: () {
              createdEvent.tags.remove(name);
              refresh();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(name),
                Icon(Icons.remove_circle_outline),
              ],
            )),
      );
    }
    return Padding(
      padding: EdgeInsets.all(2),
      child: FilledButton(
          onPressed: () {
            addTag(name);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(name),
              Icon(Icons.add_circle_outline),
            ],
          )),
    );
  }
}
