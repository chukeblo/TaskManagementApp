import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/models.dart';

abstract class ManagementDataProvider extends ChangeNotifier {
  ManagementDataProvider({
    required this.database,
  });

  final Database database;
  List<ManagementItemData> managementDataList = [];

  @protected
  Future<void> initialize() async {
    managementDataList = await getManagementDataList(database);
  }

  Future<List<ManagementItemData>> getManagementDataList(Database database);

  Future<void> addManagementItemData(ManagementItemData data);

  Future<void> updateManagementItemData(ManagementItemData data);

  Future<void> deleteManagementItemData(int id);
}
