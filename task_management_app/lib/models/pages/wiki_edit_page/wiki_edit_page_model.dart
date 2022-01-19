import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../providers/providers.dart';

class WikiEditPageModel extends ChangeNotifier {
  WikiEditPageModel({
    required this.wikiProvider,
    required this.creating,
    required this.id,
    this.title = "",
    this.tag = "",
    required this.createdAt,
    this.editHistory = const [],
    this.notes = const [],
  });

  final WikiProvider wikiProvider;
  final bool creating;
  final int id;
  final String title;
  final String tag;
  final String createdAt;
  final List<String> editHistory;
  final List<String> notes;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  void addWiki() {
    if (!creating) {
      return;
    }

    final wiki = WikiData(
      id: id,
      title: titleController.text,
      tag: tagController.text,
      createdAt: createdAt,
      editHistory: editHistory,
      notes: notes,
    );

    wikiProvider.addWiki(wiki);
    notifyListeners();
  }
}
