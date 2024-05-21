import 'package:flutter/material.dart';
import '../pages/contents_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/second_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../pages/settings_page.dart';

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true, primarySwatch: Colors.green),
        home: const NavigationExample(),
        routes: <String, WidgetBuilder>{
          '/second': (BuildContext context) => const SecondPage(),
          '/home': (BuildContext context) =>
              const MyHomePage(title: 'HomePage'),
        });
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentPageIndex,
        onTap: (i) => setState(() => currentPageIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.green,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.list_alt_outlined),
            activeIcon: const Icon(Icons.list_alt),
            title: const Text("Contents"),
            selectedColor: Colors.pink,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: Colors.teal,
          ),

           SalomonBottomBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            title: const Text("Settings"),
            selectedColor: Colors.orange,
          ),
        ],
      ),
      body: <Widget>[

        const MyHomePage(title: "HomePage"),
        const ContentsPage(),
        const ProfilePage(),
        const SettingsPage(),

      ][currentPageIndex],
    );
  }
}
