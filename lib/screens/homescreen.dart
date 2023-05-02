import 'package:bunkmate/constants_methods.dart';
import 'package:bunkmate/repository/database.dart';
import 'package:bunkmate/screens/profile.dart';
import 'package:bunkmate/widgets/add_item.dart';
import 'package:bunkmate/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool addEnabled = false;
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
              expandedTitleScale: 2,
              title: const Text('Attendance'),
              background: Container(
                width: double.maxFinite,
                height: 200,
                color: Theme.of(context).canvasColor,
                // child: Image.asset(
                //   'assets/banner.jpg',
                //   fit: BoxFit.cover,
                // ),
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
              child: StreamBuilder(
            stream: Database.itemsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final entries = snapshot.data!.data()?.entries.toList();
                if (entries==null || entries.isEmpty) {
                  return Center(
                    child: Column(
                      children: const [
                        Text(
                          'Nothing to track',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: aquamarine),
                        ),
                        Text('Click on + button to add item')
                      ],
                    ),
                  );
                }
                entries.sort((a, b) =>
                    (a.key.toLowerCase().compareTo(b.key.toLowerCase())));
                return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Item(
                          entry: entries[index],
                        ),
                    itemCount: entries.length);
              }
              return Center(child: loader);
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddItem();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
