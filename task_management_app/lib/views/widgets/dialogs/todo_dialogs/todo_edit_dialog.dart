import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';

class TodoEditDialog extends StatelessWidget {
  const TodoEditDialog._({
    Key? key,
    required this.editingTodo,
  }) : super(key: key);

  final TodoItemData editingTodo;

  static Widget withDependencies({
    required BuildContext context,
    required TodoItemData editingTodo,
    required String title,
    String tag = "",
    String memo = "",
  }) {
    return ChangeNotifierProvider(
      create: (_context) => TodoEditDialogModel(
        todoProvider: Provider.of<TodoProvider>(context, listen: false),
        title: title,
        tag: tag,
        memo: memo,
      ),
      child: TodoEditDialog._(editingTodo: editingTodo),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TodoEditDialogModel>(context);
    return SimpleDialog(
      children: <Widget>[
        SimpleDialogOption(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autofocus: true,
                controller: model.titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  contentPadding: EdgeInsets.all(10.0),
                  border: InputBorder.none,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autofocus: true,
                controller: model.tagController,
                decoration: const InputDecoration(
                  labelText: "Tag",
                  contentPadding: EdgeInsets.all(10.0),
                  border: InputBorder.none,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autofocus: true,
                controller: model.memoController,
                decoration: const InputDecoration(
                  labelText: "Memo",
                  contentPadding: EdgeInsets.all(10.0),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      onPrimary: Colors.blue,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      model.editTodo(editingTodo);
                    },
                    child: const Text("EDIT"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      onPrimary: Colors.blue,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("CANCEL"),
                  ),
                ],
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }
}
