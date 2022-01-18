import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/models.dart';
import '../utilities/utilities.dart';

class WikiProvider extends ChangeNotifier {
  WikiProvider({
    required this.database,
  });

  final Database database;
  List<WikiData> wikiList = [];

  Future<void> initialize() async {}

  Future<List<WikiData>> getWikiList() async {
    final List<Map<String, dynamic>> maps =
        await database.query(DatabaseConstants.tableProject);
    return List.generate(maps.length, (i) {
      String editHistoryString = maps[i][DatabaseConstants.columnEditHistory];
      String notesString = maps[i][DatabaseConstants.columnNotes];
      return WikiData(
        id: maps[i][DatabaseConstants.columnId],
        title: maps[i][DatabaseConstants.columnTitle],
        tag: maps[i][DatabaseConstants.columnTag],
        createdAt: maps[i][DatabaseConstants.columnCreatedAt],
        editHistory: editHistoryString.split("|"),
        notes: notesString.split("|"),
      );
    });
  }

  Future<void> addWiki(WikiData wiki) async {
    wikiList.add(wiki);
    await database.insert(
      DatabaseConstants.tableWiki,
      wiki.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<void> updateWiki(WikiData newWiki) async {
    final index = wikiList.indexWhere((wiki) => wiki.id == newWiki.id);
    wikiList[index] = newWiki;

    await database.update(
      DatabaseConstants.tableWiki,
      newWiki.toMap(),
      where: "${DatabaseConstants.columnId} = ?",
      whereArgs: [newWiki.id],
    );
    notifyListeners();
  }

  Future<void> deleteWiki(int id) async {
    final existingWikiIndex =
        wikiList.indexWhere((project) => project.id == id);

    if (existingWikiIndex == -1) {
      return;
    }

    await database.delete(
      DatabaseConstants.tableWiki,
      where: "${DatabaseConstants.columnId} = ?",
      whereArgs: [id],
    );

    _shrinkAndSynchronizeDatabase(existingWikiIndex + 1);
    wikiList.removeAt(existingWikiIndex);
    notifyListeners();
  }

  void _shrinkAndSynchronizeDatabase(int startIndex) async {
    for (var index = startIndex; index < wikiList.length; index++) {
      final wiki = wikiList[index].copyWith(
        id: index - 1,
      );
      wikiList[index] = wiki;
      await database.update(
        DatabaseConstants.tableWiki,
        wiki.toMap(),
        where: "${DatabaseConstants.columnId} = ?",
        whereArgs: [wiki.id],
      );
    }
  }
}
