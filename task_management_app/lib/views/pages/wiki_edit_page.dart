import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../providers/providers.dart';

class WikiEditPage extends StatelessWidget {
  const WikiEditPage._({Key? key}) : super(key: key);

  static Widget withDependencies({
    required BuildContext context,
    required bool creating,
    required int id,
    String title = "",
    String tag = "",
    required String createdAt,
    List<String> editHistory = const [],
    List<String> notes = const [],
  }) {
    return ChangeNotifierProvider(
      create: (context) => WikiEditPageModel(
        wikiProvider: Provider.of<WikiProvider>(context),
        creating: creating,
        id: id,
        title: title,
        tag: tag,
        createdAt: createdAt,
        editHistory: editHistory,
        notes: notes,
      ),
      child: const WikiEditPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WikiEditPageModel>(context);
    return Container();
  }
}
