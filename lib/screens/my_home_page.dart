import 'package:flutter/material.dart';

import '../widgets/my_tab_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final List<String> pageTitles = ['Home', 'Favourite', 'Search', 'Profile'];

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);

    tabController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(pageTitles[tabController.index]),

        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),

        actions: [
          IconButton(icon: const Icon(Icons.grid_view), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),

      body: MyTabBar(controller: tabController),
    );
  }
}
