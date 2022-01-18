import '../../utilities/utilities.dart';

class WikiData {
  const WikiData({
    required this.id,
    required this.title,
    this.tag = "",
    required this.createdAt,
    this.editHistory = const [],
    this.notes = const [],
  });

  final int id;
  final String title;
  final String tag;
  final String createdAt;
  final List<String> editHistory;
  final List<String> notes;

  WikiData copyWith({
    int? id,
    String? title,
    String? tag,
    String? createdAt,
    List<String>? editHistory,
    List<String>? notes,
  }) {
    return WikiData(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      createdAt: createdAt ?? this.createdAt,
      editHistory: editHistory ?? this.editHistory,
      notes: notes ?? this.notes,
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
      DatabaseConstants.columnCreatedAt: createdAt,
      DatabaseConstants.columnEditHistory: editHistory,
      DatabaseConstants.columnNotes: notes,
    };
  }

  @override
  String toString() {
    return "${DatabaseConstants.tableTodo}{${DatabaseConstants.columnId}:$id,${DatabaseConstants.columnTitle}:$title,${DatabaseConstants.columnTag}:$tag,${DatabaseConstants.columnCreatedAt}:$createdAt,${DatabaseConstants.columnEditHistory}:$editHistory,${DatabaseConstants.columnNotes}:$notes}";
  }
}
