import '../../models/models.dart';
import '../../utilities/utilities.dart';

class TaskItemData extends ManagementItemData {
  const TaskItemData({
    required int id,
    required String title,
    String tag = "",
    int isCompleted = intFalse,
    required String createdAt,
    String completedAt = "",
    String memo = "",
  }) : super(
          id: id,
          title: title,
          tag: tag,
          isCompleted: isCompleted,
          createdAt: createdAt,
          completedAt: completedAt,
          memo: memo,
        );

  @override
  ManagementItemData copyWith({
    int? id,
    String? title,
    String? tag,
    int? isCompleted,
    String? createdAt,
    String? completedAt,
    String? memo,
  }) {
    return TaskItemData(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      memo: memo ?? this.memo,
    );
  }

  @override
  String toString() {
    return "${DatabaseConstants.tableTask}{${DatabaseConstants.columnId}:$id,${DatabaseConstants.columnTitle}:$title,${DatabaseConstants.columnTag}:$tag,${DatabaseConstants.columnIsCompleted}:$isCompleted,${DatabaseConstants.columnCreatedAt}:$createdAt,${DatabaseConstants.columnCompletedAt}:$completedAt,${DatabaseConstants.columnMemo}:$memo}";
  }
}
