import 'package:bunkmate/repository/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../repository/storage.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Time-Table'),
        ),
        body: ListView(),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          spacing: 8,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.upload_file),
                onTap: () {
                  getFilePath();
                }),
            SpeedDialChild(
                child: const Icon(Icons.camera),
                onTap: () {
                  Storage.getFile();
                }),
          ],
        ));
  }
}
