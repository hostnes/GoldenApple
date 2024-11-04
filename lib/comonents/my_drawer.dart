import 'package:flutter/material.dart';

import '../services/auth/auth_gate.dart';
import 'my_drawer_tile.dart';
import 'settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // Pass BuildContext to the logOut method
  void logOut(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, q, w) => AuthGate(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Icon(Icons.local_florist,
                size: 80, color: Theme.of(context).colorScheme.inversePrimary),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          MyDrawerTile(
            text: "Home",
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),
          MyDrawerTile(
            text: "Settings",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          Spacer(),
          MyDrawerTile(
            text: "Logout",
            icon: Icons.logout,
            onTap: () => logOut(context), // Pass context here
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
