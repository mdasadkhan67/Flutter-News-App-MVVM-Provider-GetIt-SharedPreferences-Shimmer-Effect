import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CategoryCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.blueAccent.withOpacity(0.1),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  size: 40,
                  color: Colors.blueAccent,
                ),
                SizedBox(height: 10),
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
