import 'package:bunkmate/widgets/item.dart';
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
            leading: IconButton(icon: const Icon(FontAwesomeIcons.userTie),onPressed: (){}),
            pinned: true,
            expandedHeight: 200,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Attandance'),
              background: Image.asset('assets/banner.jpg',fit: BoxFit.cover,),
              centerTitle: false,
            ),
          ),
          SliverToBoxAdapter(
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                  itemBuilder: (context, index) => const Item(), itemCount: 10))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
