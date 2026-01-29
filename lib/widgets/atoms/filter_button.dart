import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onPressed;
  final Widget icon ;
  final String label;
  const FilterButton({super.key, required this.isActive, required this.onPressed, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          gradient: isActive ? LinearGradient(
            colors: [
              Color(0xFF1c2b22),
              Color(0xFF243a2c),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ) : null,
          color: isActive ? null : Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: isActive ? Theme.of(context).colorScheme.primary : Color(0xFF27352d),
            width: isActive ? 1.0 : 0.0,
          ),
        ),
        child: Row(
          spacing: 10.0,
          children: [
            icon,
            Text(
              label,
              style: TextStyle(
                color: isActive ? Theme.of(context).colorScheme.primary : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}