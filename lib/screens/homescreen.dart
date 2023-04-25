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
            expandedHeight: 240,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 2,
              title: const Text('Attandance'),
              background: Container(
                width: double.maxFinite,
                height: 200,
                color: Theme.of(context).canvasColor,
                child:Image.asset(
                  'assets/banner.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              centerTitle: true,
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
            itemCount: 6,
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
                return const AddItem();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
