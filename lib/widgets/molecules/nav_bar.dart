import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:n8n_monitor/provider/nav_index_provider.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final indexProvider = Provider.of<NavIndexProvider>(context);



    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: GNav(
          rippleColor: Theme.of(context).scaffoldBackgroundColor,
          hoverColor: Color(0xFF1c2b22),
          gap: 8,
          activeColor: Theme.of(context).colorScheme.primary,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: Color(0xFF1c2b22),
          color: Colors.grey[100]!  ,
          tabs: [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.headset_mic_sharp, text: 'Mics'),
            GButton(icon: Icons.search, text: 'Search'),
            GButton(icon: Icons.supervised_user_circle_outlined, text: 'Profile'),
          ],
          selectedIndex: indexProvider.selectedIndex,
          onTabChange: (index) {
            indexProvider.selectedIndex = index;
          },
        ),
      ),
    );
  }
}
