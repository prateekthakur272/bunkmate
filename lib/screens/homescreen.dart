import 'package:bunkmate/screens/profile.dart';
import 'package:bunkmate/widgets/item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                icon: const Icon(FontAwesomeIcons.userTie), onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Profile()));
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
            itemBuilder: (context, index) => const Item(),
            itemCount: 10,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
