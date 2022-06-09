import 'package:flutter/material.dart';
import 'package:unnayan/my_color.dart';

import '../../ProfilePanel/view/profilepanel_view.dart';
import '../ComplaintPanel/view/complainpanel_view.dart';

///
/// Home Page Statefull Class for Home Screen
///

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePagePanel(),
    ComplainPage(),
    // Text(
    //   'Index 1: Messaging',
    //   style: optionStyle,
    // ),
    // ChatPanel(),
    Text(
      'Index 2: SnapChat',
      style: optionStyle,
    ),
    ProfileSTL(),
    // Text(
    //   'Index 3: Profile',
    //   style: optionStyle,
    // ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'SnapChat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyColor.bottomNavItemColor,
        unselectedItemColor: MyColor.blackFont,
        onTap: _onItemTapped,
      ),
    );
  }
}

///
/// HomePage Panel
///

class HomePagePanel extends StatefulWidget {
  const HomePagePanel({Key? key}) : super(key: key);

  @override
  State<HomePagePanel> createState() => _HomePagePanelState();
}

class _HomePagePanelState extends State<HomePagePanel> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80),
        Container(
          margin: const EdgeInsets.all(20),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: "Search",
              hintText: "Search",
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
        Expanded(child: getGridView()),
      ],
    );
  }

  Widget getGridView() {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
          child: const Text("He'd have you all unravel at the"),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[200],
          child: const Text('Heed not the rabble'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[300],
          child: const Text('Sound of screams but the'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[400],
          child: const Text('Who scream'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[500],
          child: const Text('Revolution is coming...'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[600],
          child: const Text('Revolution, they...'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[300],
          child: const Text('Sound of screams but the'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[400],
          child: const Text('Who scream'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[500],
          child: const Text('Revolution is coming...'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[600],
          child: const Text('Revolution, they...'),
        ),
      ],
    );
  }
}
