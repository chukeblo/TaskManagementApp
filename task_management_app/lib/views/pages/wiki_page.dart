import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../utilities/utilities.dart';

class WikiPage extends StatelessWidget {
  WikiPage._({Key? key}) : super(key: key);

  List<WikiData> wikis = [];

  static Widget withDependencies({required BuildContext context}) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => WikiPageModel(
        wikiProvider: Provider.of<WikiProvider>(context),
      ),
      child: WikiPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WikiPageModel>(context);
    wikis = model.wikiList;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("WIKI"),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: wikis.length,
        itemBuilder: (context, index) {
          final wiki = wikis[index];
          return Card(
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wiki.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "created at ${trimIso8601String(wiki.createdAt)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  if (wiki.editHistory.isNotEmpty)
                    Text(
                      "last edited at ${trimIso8601String(wiki.editHistory[wiki.editHistory.length - 1])}",
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  if (wiki.notes.isNotEmpty)
                    Text(
                      "last edited at ${trimIso8601String(wiki.editHistory[wiki.editHistory.length - 1])}",
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                ],
              ),
              onTap: () {},
              trailing: Wrap(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      model.deleteWiki(index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
