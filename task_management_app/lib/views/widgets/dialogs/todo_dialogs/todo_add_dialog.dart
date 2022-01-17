import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/models.dart';
import '../../../../providers/providers.dart';

class TodoAddDialog extends StatelessWidget {
  const TodoAddDialog._({
    Key? key,
  }) : super(key: key);

  static Widget withDependencies({required BuildContext context}) {
    return ChangeNotifierProvider(
      create: (_context) => TodoAddDialogModel(
        todoProvider: Provider.of<TodoProvider>(context),
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
