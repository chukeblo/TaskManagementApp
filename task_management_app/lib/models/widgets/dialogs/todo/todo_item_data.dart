class TodoItemData {
  const TodoItemData({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
    this.memo = "",
  });

  final int id;
  final String title;
  final bool isCompleted;
  final String createdAt;
  final String memo;

  TodoItemData copyWith({
    int? id,
    String? title,
    bool? isCompleted,
    String? createdAt,
    String? memo,
  }) {
    return TodoItemData(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      memo: memo ?? this.memo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "isCompleted": isCompleted,
      "createdAt": createdAt,
      "memo": memo,
    };
  }

  @override
  String toString() {
    return "Todo{id:$id,title:$title,isCompleted:$isCompleted,createdAt:$createdAt,memo:$memo}";
  }
}
