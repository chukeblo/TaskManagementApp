import '../../../../utilities/utilities.dart';

class TodoItemData {
  const TodoItemData({
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

  static const int intTrue = 1;
  static const int intFalse = 0;

  TodoItemData copyWith({
    int? id,
    String? title,
    String? tag,
    int? isCompleted,
    String? createdAt,
    String? completedAt,
    String? memo,
  }) {
    return TodoItemData(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      memo: memo ?? this.memo,
    );
  }

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
  String toString() {
    return "${DatabaseConstants.tableTodo}{${DatabaseConstants.columnId}:$id,${DatabaseConstants.columnTitle}:$title,${DatabaseConstants.columnTag}:$tag,${DatabaseConstants.columnIsCompleted}:$isCompleted,${DatabaseConstants.columnCreatedAt}:$createdAt,${DatabaseConstants.columnCompletedAt}:$completedAt,${DatabaseConstants.columnMemo}:$memo}";
  }

  static int reverseCompletion(int status) {
    return status == intTrue ? intFalse : intTrue;
  }

  static bool getCompletionStatus(int status) {
    return status == intTrue;
  }
}
