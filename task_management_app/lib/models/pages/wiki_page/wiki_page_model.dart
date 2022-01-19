import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../providers/providers.dart';

class WikiPageModel extends ChangeNotifier {
  WikiPageModel({required this.wikiProvider});

  final WikiProvider wikiProvider;
  List<WikiData> get wikiList => wikiProvider.wikiList;

  void deleteWiki(int id) {
    wikiProvider.deleteWiki(id);
    notifyListeners();
  }
}
