import 'package:bunkmate/constants_methods.dart';
import 'package:bunkmate/repository/database.dart';
import 'package:bunkmate/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SelectedItem extends StatefulWidget {
  final String title;
  const SelectedItem({super.key, required this.title});

  @override
  State<SelectedItem> createState() => _SelectedItemState();
}

class _SelectedItemState extends State<SelectedItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.title, [
        IconButton(
            onPressed: () {
              showHistory(context, widget.title);
            },
            icon: const Icon(Icons.history))
      ]),
      body: Center(
          child: StreamBuilder(
        stream: Database.itemsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data?.data()?[widget.title];
            final total = data['total'];
            final attended = data['attended'];
            final percentage = Database.percentage(total, attended);
            return Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    CircularPercentIndicator(
                      radius: 72,
                      lineWidth: 12,
                      circularStrokeCap: CircularStrokeCap.round,
                      percent: percentage,
                      center: Text(
                        '${(percentage * 100).round()}%',
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      progressColor: percentage >= .75
                          ? Colors.green.shade300
                          : Colors.red.shade300,
                      animation: true,
                      header: const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Text(
                          'Total attandance',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      footer: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Column(
                          children: [
                            Text(
                              'Overall attandance is $attended out of $total',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              getMessage(percentage),
                              style: const TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                    // const Divider(
                    //   color: Colors.grey,
                    // ),
                  ],
                ),
                // Positioned(
                //   bottom: 24,
                //   left: 0,
                //   right: 0,
                //   child: Container(
                //     padding: const EdgeInsets.all(24),
                //     child: Row(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Expanded(
                //           child: StartIconButton(
                //               icon: Icons.close,
                //               label: 'Missed',
                //               onClick: () {}),
                //         ),
                //         const SizedBox(
                //           width: 16,
                //         ),
                //         Expanded(
                //           child: StartIconButton(
                //               icon: Icons.done,
                //               label: 'Attended',
                //               onClick: () {}),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            );
          }
          return loader;
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        isExtended: true,
        child: const Icon(Icons.edit),
      ),
    );
  }
}

void showHistory(BuildContext context, String title) {
  showModalBottomSheet(
      useSafeArea: true,
      enableDrag: true,
      showDragHandle: true,
      isScrollControlled: true,
      isDismissible: true,
      elevation: 8,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      context: context,
      builder: (context) => FutureBuilder(
          future: Database.getHistoryByTitle(title),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              var history = snapshot.data?.entries.toList();
              history?.sort((a, b) => b.key.compareTo(a.key));
              return Scrollbar(
                child: ListView.builder(
                  itemCount: history?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(history?[index].key ?? ''),
                      subtitle: Text(history?[index].value['attended']
                          ? 'Attended'
                          : 'Not attended'),
                    );
                  },
                ),
              );
            } else if (!snapshot.hasData) {
              return const Text('No History');
            }
            return loader;
          }));
}
