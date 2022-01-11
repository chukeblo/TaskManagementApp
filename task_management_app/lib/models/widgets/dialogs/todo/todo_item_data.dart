class TodoItemData {
  const TodoItemData({
    required this.id,
    required this.title,
    this.tag = "",
    this.isCompleted = false,
    required this.createdAt,
    this.completedAt = "",
    this.memo = "",
  });

  final int id;
  final String title;
  final String tag;
  final bool isCompleted;
  final String createdAt;
  final String completedAt;
  final String memo;

  TodoItemData copyWith({
    int? id,
    String? title,
    String? tag,
    bool? isCompleted,
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
      "id": id,
      "title": title,
      "tag": tag,
      "isCompleted": isCompleted,
      "createdAt": createdAt,
      "completedAt": completedAt,
      "memo": memo,
    };
  }

  @override
  String toString() {
    return "Todo{id:$id,title:$title,tag:$tag,isCompleted:$isCompleted,createdAt:$createdAt,completedAt:$completedAt,memo:$memo}";
  }
}
