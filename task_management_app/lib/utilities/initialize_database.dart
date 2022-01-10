import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initializeDatabase() async {
  final database = openDatabase(
    join(await getDatabasesPath(), "dummy_database.db"),
    onCreate: _onCreate,
    onUpgrade: _onUpgrade,
    version: 1,
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
    'CREATE TABLE todo(id INTEGER PRIMARY KEY, title TEXT, isCompleted TEXT, createdAt TEXT, memo TEXT)'
  ],
  '2': ['ALTER TABLE todo ADD COLUMN videoPath TEXT;'],
};
