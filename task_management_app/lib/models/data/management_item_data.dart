import '../../utilities/utilities.dart';

abstract class ManagementItemData {
  const ManagementItemData({
    required this.id,
    required this.title,
    this.tag = "",
    this.isCompleted = intFalse,
    required this.createdAt,
    this.completedAt = "",
    this.memo = "",
  });

  final int id;
  final String title;
  final String tag;
  final int isCompleted;
  final String createdAt;
  final String completedAt;
  final String memo;

  ManagementItemData copyWith({
    int? id,
    String? title,
    String? tag,
    int? isCompleted,
    String? createdAt,
    String? completedAt,
    String? memo,
  });

  String format(String iso8601String) {
    if (iso8601String == "") {
      return iso8601String;
    }
    return iso8601String.substring(0, 10);
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.columnId: id,
      DatabaseConstants.columnTitle: title,
      DatabaseConstants.columnTag: tag,
      DatabaseConstants.columnIsCompleted: isCompleted,
      DatabaseConstants.columnCreatedAt: createdAt,
      DatabaseConstants.columnCompletedAt: completedAt,
      DatabaseConstants.columnMemo: memo,
    };
  }

  @override
  String toString();
}
