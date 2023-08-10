import 'package:flutter/material.dart';
import 'package:ventes/Components/components.dart';
import 'package:ventes/Functions/users_data.dart';
import 'package:ventes/MainApp/Profile/AddEvent/globals.dart';
import 'package:ventes/Styles/text_style.dart';
import 'package:ventes/data.dart';

// This is the third page for the add event process
// should add tags to the event
class TagsPage extends StatefulWidget {
  const TagsPage({super.key});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> with TickerProviderStateMixin {
  TabController? myTabsController;
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Recommended tags', icon: Icon(Icons.thumb_up)),
    Tab(
      text: 'My tags',
      icon: Icon(Icons.favorite_border),
    ),
  ];
  List<String> recommendedTags = ["Club", "Sports", "Music", "Food", "Games"];

  var tagController = TextEditingController();
  var tagError = "";

  void checkTag() {
    if (tagController.text.trim() == "") {
      setState(() {
        tagError = "tag cannot be empty";
      });
      return;
    } else if (tagController.text.trim().length > 20) {
      setState(() {
        tagError = "tag cannot be longer than 30 characters";
      });
      return;
    }
    tagError = "";
    currentUser.tags.add(tagController.text.trim());
    UsersData.updateUser(currentUser.email, {"tags": currentUser.tags});
    setState(() {
      tagController.clear();
    });
  }

  void addTag(tag) {
    if (createdEvent.tags.length >= 15) {
      tagError = "There can only be 15 tags!";
      return;
    }
    if (!createdEvent.tags.contains(tag)) {
      createdEvent.tags.add(tag);
    }
    setState(() {});
  }

  void removeTag(tag) {
    if (createdEvent.tags.contains(tag)) {
      createdEvent.tags.remove(tag);
    } else {
      return;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    myTabsController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    tagController.dispose();
    myTabsController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Advanced Settings
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Container()),
                    const Icon(
                      Icons.label,
                      size: 30,
                    ),
                    const SizedBox(width: 5),
                    Text("Tag this event",
                        style: MyTextStyle.bodyLarge(context)),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(height: 10),

                // Recommended tags & my tags
                TabBar(controller: myTabsController, tabs: myTabs),
                const SizedBox(height: 10),
                SizedBox(
                    width: double.maxFinite,
                    height: 300,
                    child: TabBarView(controller: myTabsController, children: [
                      Wrap(
                        children: [
                          for (var tag in recommendedTags)
                            if (!createdEvent.tags.contains(tag))
                              Tag(
                                name: tag,
                                controlTag: addTag,
                              )
                        ],
                      ),
                      currentUser.tags.isEmpty
                          ? const Text(
                              "Sorry, you don't have your own tags yet!")
                          : Wrap(children: [
                              for (var tag in currentUser.tags)
                                if (!createdEvent.tags.contains(tag))
                                  Tag(
                                    name: tag,
                                    controlTag: addTag,
                                  )
                            ]),
                    ])),

                // Add new tags
                Row(
                  children: [
                    const Text("Add a new tag: "),
                    Flexible(
                      child: TextField(
                        controller: tagController,
                        decoration: InputDecoration(
                          errorText: tagError == "" ? null : tagError,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: checkTag, icon: const Icon(Icons.add)),
                  ],
                ),
                const SizedBox(height: 15),
                const Row(
                  children: [
                    Icon(Icons.check_circle),
                    SizedBox(width: 5),
                    MyOverFlowText(
                      text: "Selected tag(s) :",
                      maxLines: 1,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  children: [
                    for (var tag in createdEvent.tags)
                      Tag(
                        name: tag,
                        controlTag: removeTag,
                        selected: true,
                      )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Tag extends StatelessWidget {
  final String name;
  final Function controlTag;
  final bool selected;
  const Tag({
    super.key,
    required this.name,
    required this.controlTag,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: FilledButton(
          onPressed: () {
            controlTag(name);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(name),
              selected
                  ? const Icon(Icons.remove_circle_outline)
                  : const Icon(Icons.add_circle_outline),
            ],
          )),
    );
  }
}
