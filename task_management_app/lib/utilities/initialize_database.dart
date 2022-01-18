import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../utilities/utilities.dart';

Future<Database> initializeDatabase() async {
  final database = openDatabase(
    join(await getDatabasesPath(), DatabaseConstants.databaseFileName),
    onCreate: _onCreate,
    onUpgrade: _onUpgrade,
    version: 4,
  );
  return database;
}

void _onCreate(
  Database database,
  int version,
) async {
  await _migrate(database, 0, version);
}

void _onUpgrade(
  Database database,
  int oldVersion,
  int newVersion,
) async {
  await _migrate(database, oldVersion, newVersion);
}

Future<void> _migrate(Database database, int oldVersion, int newVersion) async {
  for (var i = oldVersion + 1; i <= newVersion; i++) {
    final queries = migrationScripts[i.toString()]!;
    for (final query in queries) {
      await database.execute(query);
    }
  }
}

const migrationScripts = {
  '1': [
    'CREATE TABLE ${DatabaseConstants.tableTodo}(${DatabaseConstants.columnId} INTEGER PRIMARY KEY, ${DatabaseConstants.columnTitle} TEXT, ${DatabaseConstants.columnIsCompleted} INTEGER, ${DatabaseConstants.columnTag} TEXT, ${DatabaseConstants.columnCreatedAt} TEXT, ${DatabaseConstants.columnCompletedAt} TEXT, ${DatabaseConstants.columnMemo} TEXT)'
  ],
  '2': [
    'CREATE TABLE ${DatabaseConstants.tableTask}(${DatabaseConstants.columnId} INTEGER PRIMARY KEY, ${DatabaseConstants.columnTitle} TEXT, ${DatabaseConstants.columnIsCompleted} INTEGER, ${DatabaseConstants.columnTag} TEXT, ${DatabaseConstants.columnCreatedAt} TEXT, ${DatabaseConstants.columnCompletedAt} TEXT, ${DatabaseConstants.columnMemo} TEXT)'
  ],
  '3': [
    'CREATE TABLE ${DatabaseConstants.tableProject}(${DatabaseConstants.columnId} INTEGER PRIMARY KEY, ${DatabaseConstants.columnTitle} TEXT, ${DatabaseConstants.columnIsCompleted} INTEGER, ${DatabaseConstants.columnTag} TEXT, ${DatabaseConstants.columnCreatedAt} TEXT, ${DatabaseConstants.columnCompletedAt} TEXT, ${DatabaseConstants.columnMemo} TEXT)'
  ],
  '4': [
    'CREATE TABLE ${DatabaseConstants.tableWiki}(${DatabaseConstants.columnId} INTEGER PRIMARY KEY, ${DatabaseConstants.columnTitle} TEXT, ${DatabaseConstants.columnTag} TEXT, ${DatabaseConstants.columnCreatedAt} TEXT, ${DatabaseConstants.columnEditHistory} TEXT, ${DatabaseConstants.columnNotes} TEXT)'
  ]
};
