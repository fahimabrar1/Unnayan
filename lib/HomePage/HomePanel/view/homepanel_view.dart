import 'dart:developer';
import 'dart:typed_data';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnayan/Components/badge_model.dart';
import 'package:unnayan/HomePage/HomePanel/controller/homepanel_controller.dart';
import 'package:unnayan/HomePage/HomePanel/model/homepanel_model.dart';
import 'package:unnayan/HomePage/NotificationPanel/controller/notificationpanel_controller.dart';
import 'package:unnayan/HomePage/NotificationPanel/model/notificationpanel_model.dart';
import 'package:unnayan/HomePage/NotificationPanel/view/notificationPanel_view.dart';
import 'package:unnayan/LoginPage/model/loginpage_model.dart';
import 'package:unnayan/Services/notification_service.dart';
import 'package:unnayan/my_color.dart';

import '../../../AlWids.dart';
import '../../../my_vars.dart';

///
/// Home Page Statefull Class for Home Screen
///

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  late WidContainer widContainer;
  Widget home = HomePagePanel(HomePageEnum.org, null);
  late BadgeCounter badgeCounter;
  void _onItemTapped(int index) {
    if (index == 2) {
      badgeCounter.resetCounter();
    }
    setState(() {
      widContainer.resetHome();
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    badgeCounter = context.read<BadgeCounter>();
    widContainer = context.read<WidContainer>();
    if (context.read<LoginpageModel>().userType == 'user') {
      getNotificationsFromOrg();
    } else {
      getNotificationsFromUser();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      const HomeSTF(),
      // ComplainPage(),
      Container(),
      // Text(
      //   'Index 1: Messaging',
      //   style: optionStyle,
      // ),
      // ChatPanel(),
      const NotificationPage(
        heading: "Notifications",
        nEnum: NotificationEnum.def,
      ),
      Provider.of<WidContainer>(context).profilePanel,
      // Text(
      //   'Index 3: Profile',
      //   style: optionStyle,
      // ),
    ];
    final badgeText = context.watch<BadgeCounter>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: (badgeCounter.counter > 0)
                  ? Badge(
                      badgeContent: Text(badgeText.counter.toString()),
                      child: const Icon(Icons.notifications))
                  : const Icon(Icons.notifications),
              label: 'Notification',
            ),
            const BottomNavigationBarItem(
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

  NotificationPageController controller = NotificationPageController();

  Future<void> getNotificationsFromOrg() async {
    List<NotificationPageModel> ls = [];
    await controller
        .showList(context.read<LoginpageModel>().iduser!, NotificationEnum.def,
            "true", 'user')
        .then((value) {
      ls = value!;
      for (var element in ls) {
        if (element.showNotiftoUser == 'true' &&
            context.read<LoginpageModel>().userType! == 'user') {
          setState(() {
            badgeCounter.increment();
          });

          NotificationService().showNotificaiton(element.organizationsId!,
              element.name!, "Gave a feedback, Please Check", 1);
        }
      }
      for (var element in ls) {
        if (element.showNotiftoUser == 'true' &&
            context.read<LoginpageModel>().userType! == 'user') {
          controller.updateComplainNotificationToUserToFalse(
              element.complainId!, "false");
        }
      }
    });
  }

  void getNotificationsFromUser() {}
}

///
/// HomePage Panel
///

class HomePagePanel extends StatefulWidget {
  HomePageEnum enu;
  int? id;

  HomePagePanel(this.enu, this.id, {Key? key}) : super(key: key);

  @override
  State<HomePagePanel> createState() => _HomePagePanelState();
}

class _HomePagePanelState extends State<HomePagePanel> {
  final _searchController = TextEditingController();
  final HomePageController homePageController = HomePageController();
  late WidContainer widContainer;
  late List<MyMainGrid>? _allUsers;
  late List<MyMainGrid>? _foundUsers;

  late bool fetchGridData;
  @override
  void initState() {
    // TODO: implement initState
    fetchGridData = false;
    widContainer = context.read<WidContainer>();
    log(widget.enu.toString());
    homePageGetData(widget.enu, widget.id);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    homePageController.dispose();
    super.dispose();
  }

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
                    onChanged: _runFilter,
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
          (context.read<LoginpageModel>().userType == 'user')
              ? getGridView()
              : const SliverToBoxAdapter(
                  child: null,
                ),
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 40),
          ),
        ],
      ),
    );
  }

  Widget getGridView() {
    return SliverPadding(
      padding: const EdgeInsets.all(10.0),
      sliver: (!fetchGridData)
          ? SliverPadding(
              padding: const EdgeInsets.all(10.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return InkWell(
                      child: Container(
                          color: MyColor.white,
                          child: const SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )),
                      onTap: () {},
                    );
                  },
                  childCount: 20,
                ),
              ),
            )
          : (_foundUsers == null || _foundUsers?.length == 0)
              ? const SliverToBoxAdapter(
                  child: Center(
                    child: Text("No Organizations Found"),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.all(10.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return InkWell(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: MyColor.white,
                            ),
                            child: Image(
                              image: MemoryImage(Uint8List.fromList(
                                  _foundUsers![index].image!)),
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (widget.enu == HomePageEnum.org) {
                                widContainer.setToInst(int.parse(
                                    _foundUsers![index].organizationTypeId!));
                              } else if (widget.enu == HomePageEnum.ins) {
                                widContainer.setToComplainPage(int.parse(
                                    _foundUsers![index].organizationTypeId!));
                              }
                            });
                          },
                        );
                      },
                      childCount: _foundUsers!.length,
                    ),
                  ),
                ),
    );
  }

  Future<void> homePageGetData(HomePageEnum enu, [int? id]) async {
    log("Called homePageGetData");
    log("Called HomePageEnum: ");
    log(enu.toString());
    log("Called ID: ");
    log(id.toString());

    if (enu == HomePageEnum.org) {
      await homePageController.getHomePageGrid().then((value) {
        setState(() {
          fetchGridData = true;
          _allUsers = homePageController.grid;
          _foundUsers = _allUsers;
        });
      });
    } else {
      await homePageController.getInstitutesGrid(id!).then((value) {
        setState(() {
          fetchGridData = true;
          _allUsers = homePageController.grid;
          _foundUsers = _allUsers;
        });
      });
    }
  }

  void _runFilter(String enteredKeyword) {
    List<MyMainGrid>? results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      for (var element in _allUsers!) {
        if (element.name!
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase())) {
          log(element.name.toString());
          results.add(element);
        }
      }
    }
    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });

    log("Founder Length: " + _foundUsers!.length.toString());
  }
}

class HomeSTF extends StatefulWidget {
  const HomeSTF({Key? key}) : super(key: key);

  @override
  State<HomeSTF> createState() => _HomeSTFState();
}

class _HomeSTFState extends State<HomeSTF> {
  @override
  void initState() {
    log("Container");
    log(context.read<WidContainer>().homePanel.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("Provider WidContainer:");
    log(context.watch<WidContainer>().homePanel.toString());
    return (Provider.of<WidContainer>(context).homePanel);
  }
}
