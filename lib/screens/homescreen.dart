import 'package:bunkmate/screens/profile.dart';
import 'package:bunkmate/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/text_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 4,
            leading: IconButton(
                icon: const Icon(FontAwesomeIcons.userTie),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                }),
            pinned: true,
            expandedHeight: 200,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Attandance'),
              background: Image.asset(
                'assets/banner.jpg',
                fit: BoxFit.cover,
              ),
              centerTitle: false,
            ),
          ),
          SliverToBoxAdapter(
              child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) => const Item(
              title: 'Object oriented design and analysis',
              percent: .75,
            ),
            itemCount: 0,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const TextInput(
                          hint: 'Title',
                          inputType: TextInputType.text,
                          icon: FontAwesomeIcons.book),
                      const SizedBox(
                        height: 16,
                      ),
                      const TextInput(
                          hint: 'Total lectures',
                          inputType: TextInputType.number,
                          icon: Icons.numbers),
                      const SizedBox(
                        height: 16,
                      ),
                      const TextInput(
                          hint: 'Attended lectures',
                          inputType: TextInputType.number,
                          icon: Icons.numbers),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Add item to track'))),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade300),
                            child: const Text('Cancel'),
                          )),
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
