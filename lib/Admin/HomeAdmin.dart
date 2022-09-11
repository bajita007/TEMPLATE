import 'package:comindors/Admin/RiwayatAdminPage.dart';
import 'package:flutter/material.dart';

import '../Ui/StyleText.dart';
import '../Ui/Warna.dart';
import 'WelcomePageAdmin.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    WelcomeAdmin(),
    RiwayatAdmin(),

    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
              backgroundColor: Warna.BiruPrimary),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Riwayat',
              backgroundColor: Warna.BiruPrimary),
          BottomNavigationBarItem(
              icon: Icon(Icons.comment_bank_sharp),
              label: 'Bank',
              backgroundColor: Warna.BiruPrimary),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Profile',
              backgroundColor: Warna.BiruPrimary),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
