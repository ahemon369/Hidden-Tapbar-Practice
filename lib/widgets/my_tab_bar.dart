import 'package:flutter/material.dart';

import '../screens/home_page.dart';
import '../screens/favourite_page.dart';
import '../screens/search_page.dart';
import '../screens/profile_page.dart';

class MyTabBar extends StatefulWidget {
  final TabController controller;

  const MyTabBar({super.key, required this.controller});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  bool isExpanded = false;

  final List<IconData> icons = [
    Icons.home,
    Icons.favorite,
    Icons.search,
    Icons.person,
  ];

  final List<String> titles = ['Home', 'Favourite', 'Search', 'Profile'];

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(updateSelection);
  }

  void updateSelection() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant MyTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(updateSelection);
      widget.controller.addListener(updateSelection);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(updateSelection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,

      // Double tap to show or hide navigation
      onDoubleTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },

      child: Stack(
        children: [
          // Main Pages
          TabBarView(
            controller: widget.controller,
            children: const [
              HomePage(),
              FavouritePage(),
              SearchPage(),
              ProfilePage(),
            ],
          ),

          // Floating Navigation Menu
          Positioned(
            left: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,

                width: isExpanded ? 80 : 0,
                height: 220,

                child: isExpanded ? buildNavigationMenu() : const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Navigation Menu Design
  Widget buildNavigationMenu() {
    return Container(
      width: 80,
      height: 220,

      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            blurRadius: 8,
            offset: const Offset(2, 3),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(titles.length, (index) {
          final bool isSelected = widget.controller.index == index;

          return GestureDetector(
            behavior: HitTestBehavior.opaque,

            // Single tap to change page
            onTap: () {
              widget.controller.animateTo(index);
            },

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),

              width: double.infinity,
              height: 43,

              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.blue.withOpacity(0.12)
                    : Colors.transparent,

                border: isSelected
                    ? Border.all(color: Colors.blue, width: 1.2)
                    : null,

                borderRadius: BorderRadius.circular(10),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,

                children: [
                  Icon(
                    icons[index],
                    size: 18,
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),

                  const SizedBox(height: 2),

                  Text(
                    titles[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      fontSize: 9,
                      color: isSelected ? Colors.blue : Colors.grey,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
