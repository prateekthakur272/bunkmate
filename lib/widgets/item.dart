import 'package:bunkmate/repository/database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Item extends StatefulWidget {
  final String title;
  final double percent;
  const Item({super.key, required this.title, required this.percent});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  late double _percent;
  @override
  void initState() {
    _percent = widget.percent;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          LinearPercentIndicator(
                lineHeight: 28,
                animation: true,
                percent: _percent,
                center: Text(
                  "${(_percent*100).round()}%",
                  style:
                      const TextStyle(fontWeight: FontWeight.bold),
                ),
                barRadius: const Radius.circular(8),
                progressColor: _percent>=.75?Colors.green.shade300:Colors.red.shade200,
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
                      setState(() {
                        _percent+=.01;
                      });
                      print((await Database.items)?.keys.toString());
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
                     setState(() {
                       _percent-=.01;
                     });
                     Database.addItem('Database', 2, 5);
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
    );
  }
}
