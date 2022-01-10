import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/models/widgets/dialogs/todo/todo_add_dialog_model.dart';

class TodoAddDialog extends StatelessWidget {
  const TodoAddDialog._({
    Key? key,
  }) : super(key: key);

  static Widget withDependencies({required BuildContext context}) {
    return ChangeNotifierProvider(
      create: (_context) => TodoAddDialogModel(
        todoProvider: Provider.of(context),
      ),
      child: const TodoAddDialog._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TodoAddDialogModel>(context);
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
                onChanged: model.onTitleChanged,
                decoration: const InputDecoration(
                  labelText: "title",
                  contentPadding: EdgeInsets.all(10.0),
                  border: InputBorder.none,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autofocus: true,
                controller: model.memoController,
                onChanged: model.onMemoChanged,
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
                      model.addTodo();
                      Navigator.of(context).pop();
                    },
                    child: const Text("ADD"),
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
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
