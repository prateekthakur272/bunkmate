import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../constants_methods.dart';
import '../repository/database.dart';

class OverallAttendance extends StatelessWidget {
  const OverallAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Database.items,
        builder: (context, snapshot) {
          if (snapshot.hasData || snapshot.data!.isNotEmpty) {
            int total = 0;
            int attended = 0;
            var items = snapshot.data!.entries.toList();
            for (var item in items) {
              total = total + (item.value['total']) as int;
              attended = attended + (item.value['attended']) as int;
            }
            double percentage =
                (attended / total).isNaN ? 0.0 : (attended / total);
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Overall Attendance',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text('Attended'),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4)),
                              Text(
                                '$attended',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const Text('Total'),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4)),
                              Text(
                                '$total',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CircularPercentIndicator(
                      radius: 72,
                      lineWidth: 12,
                      circularStrokeCap: CircularStrokeCap.round,
                      percent: percentage,
                      header: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8)),
                      center: Text(
                        '${(percentage * 100).round()}%',
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      progressColor: percentage >= .75
                          ? Colors.green.shade300
                          : Colors.red.shade300,
                      animation: true,
                      footer: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            getMessage(percentage),
                            style: const TextStyle(color: Colors.grey),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                ),
              ),
            );
          }
          return loader;
        });
  }
}
