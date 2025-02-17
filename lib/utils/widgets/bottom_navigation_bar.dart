import 'package:flutter/material.dart';

class BottomNavigationBarNew extends StatelessWidget {
  const BottomNavigationBarNew({
    super.key,
    required int currentIndex,
    required BottomNavigationBarType type,
    required List<BottomNavigationBarItem> items,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return BottomNavigationBarNew(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          label: 'Top News',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'All News', // Icon and label for the All News tab
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Authors', // Icon and label for the News by Authors tab
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.language),
          label: 'By Country', // Icon and label for the News by Country tab
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label:
              'By Publications', // Icon and label for the News by Publications tab
        ),
      ],
    );
  }
}
