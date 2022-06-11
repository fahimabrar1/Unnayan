import 'package:flutter/material.dart';
import 'package:unnayan/HomePage/HomePanel/ComplainFeedbackPanel/view/complain_feedback_panel.dart';
import 'package:unnayan/HomePage/NotificationPanel/view/notificationPanel.dart';
import 'package:unnayan/my_color.dart';

import '../../ProfilePanel/view/profilepanel_view.dart';
import '../ComplainPanel/view/complainpanel_view.dart';

///
/// Home Page Statefull Class for Home Screen
///

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePagePanel(),
    // ComplainPage(),
    ComplainFeedbackSTL(),
    // Text(
    //   'Index 1: Messaging',
    //   style: optionStyle,
    // ),
    // ChatPanel(),
    NotificationPage(),
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
    return SafeArea(
      child: Scaffold(
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
    return Container(
      color: MyColor.tealBackground,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Container(
                  height: 40,
                  margin: const EdgeInsets.all(20),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: MyColor.ash,
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
              ],
            ),
          ),
          getGridView(),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 40),
          ),
        ],
      ),
    );
  }

  Widget getGridView() {
    return SliverPadding(
      padding: const EdgeInsets.all(10.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              color: Colors.teal[100],
              child: const Text("He'd have you all unravel at the"),
            );
          },
          childCount: 10,
        ),
      ),
    );
  }
}
