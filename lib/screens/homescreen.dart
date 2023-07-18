import 'package:bunkmate/constants_methods.dart';
import 'package:bunkmate/repository/database.dart';
import 'package:bunkmate/screens/history.dart';
import 'package:bunkmate/screens/profile.dart';
import 'package:bunkmate/widgets/add_item.dart';
import 'package:bunkmate/widgets/item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool addEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            setState(() {
              addEnabled = true;
            });
          } else if (notification.direction == ScrollDirection.reverse) {
            setState(() {
              addEnabled = false;
            });
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const History()));
                    },
                    icon: const Icon(Icons.history))
              ],
              elevation: 4,
              leading: IconButton(
                  icon: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.transparent,
                    backgroundImage: const AssetImage('assets/profile.png'),
                    foregroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser?.photoURL ?? ''),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile()));
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
                  if (entries == null || entries.isEmpty) {
                    return const Center(
                      child: Column(
                        children: [
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
      ),
      floatingActionButton: addEnabled
          ? FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16))),
                    builder: (context) {
                      return const SingleChildScrollView(child: AddItem());
                    });
              },
              icon: const Icon(Icons.add),
              label: const Text('Add item'),
            )
          : null,
    );
  }
}
