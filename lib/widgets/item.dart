import 'package:bunkmate/repository/database.dart';
import 'package:bunkmate/screens/selected_item.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Item extends StatelessWidget {
  final MapEntry entry;
  const Item({super.key,required this.entry});

  @override
  Widget build(BuildContext context) {
    final double percentage = Database.percentage(entry.value['total'],entry.value['attended']);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedItem(title: entry.key, record: entry.value)));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.key,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            LinearPercentIndicator(
                  lineHeight: 28,
                  animation: true,
                  percent: percentage,
                  center: Text(
                    "${(percentage*100).round()}%",
                    style:
                        const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  barRadius: const Radius.circular(8),
                  progressColor: percentage>=.75?Colors.green.shade300:Colors.red.shade200,
                ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: () async {
    
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green.shade300,
                        side: BorderSide(color: Colors.green.shade300)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.done),
                          Text('Attanded')
                        ],
                      ),
                  ),
                ),
                const SizedBox(width:16,),
                Expanded(
                  child: OutlinedButton(
                      onPressed: () {
    
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red.shade300,
                        side: BorderSide(color: Colors.red.shade300)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.close),
                          Text('Missed')
                        ],
                      ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
