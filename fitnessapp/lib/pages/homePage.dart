import 'package:fitnessapp/widgets/databaseDisplay.dart';
import 'package:flutter/material.dart';
import 'package:fitnessapp/pages/queryPage.dart';
import 'package:fitnessapp/widgets/homePageDisplay.dart';

class HomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;
  final List _pages = [
    HomePageDisplay(),
    const DatabaseDisplay(),
    QueryWorkout()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Options',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
