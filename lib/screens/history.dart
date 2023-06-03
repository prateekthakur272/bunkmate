import 'package:bunkmate/constants_methods.dart';
import 'package:bunkmate/repository/database.dart';
import 'package:bunkmate/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('History', [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      title: const Text('Delete history'),
                      content: const Text(
                          'This will delete complete history, once deleted this action could not be undone'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Database.deleteAllHistory();
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            },
                            child: const Text('Delete')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.delete),
            tooltip: 'Delete history',
          )
        ]),
        body: Center(
          child: FutureBuilder(
              future: Database.getHistory(),
              builder: ((context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  if (snapshot.data?.data() == null ||
                      snapshot.data!.data()!.isEmpty) {
                    return const Text('No history');
                  }
                  var items = snapshot.data!.data()!.keys.toList();
                  items.sort((s1, s2) {
                    return s2.compareTo(s1);
                  });
                  return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: ((context, index) {
                        var item = snapshot.data!.data()![items[index]];
                        return Container(
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 16),
                          child: ListTile(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                side: BorderSide(
                                    color: Colors.black, width: 0.5)),
                            leading: Icon(
                                item['attended'] ? Icons.done : Icons.clear),
                            title: Text(item['title']),
                            subtitle: Text(
                                '${items[index].substring(0, 19)} ${item['attended'] ? 'attended' : 'not attended'}'),
                          ),
                        );
                      }));
                }
                return loader;
              })),
        ));
  }
}
