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
      appBar: appBar(widget.title),
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
                            Text(getMessage(percentage),style: const TextStyle(color: Colors.grey),textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: Colors.grey,)
                  ],
                ),
                // Positioned(
                //   bottom: 24,
                //   left: 0,
                //   right: 0,
                //   child: Padding(
                //     padding: const EdgeInsets.all(24),
                //     child: Row(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Expanded(child: StartIconButton(icon: Icons.close, label: 'Missed', onClick: (){}),),
                //         const SizedBox(width: 16,),
                //         Expanded(child: StartIconButton(icon: Icons.done, label: 'Attended', onClick: (){}),),
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
    );
  }
}
