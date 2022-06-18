import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnayan/HomePage/HomePanel/ComplainFeedbackPanel/view/complain_feedback_panel.dart';
import 'package:unnayan/HomePage/HomePanel/controller/homepanel_controller.dart';
import 'package:unnayan/HomePage/HomePanel/model/homepanel_model.dart';
import 'package:unnayan/HomePage/NotificationPanel/view/notificationPanel_view.dart';
import 'package:unnayan/my_color.dart';

import '../../../AlWids.dart';
import '../../../my_vars.dart';
import '../../ProfilePanel/view/profilepanel_view.dart';

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
  Widget home = HomePagePanel(HomePageEnum.org,null);

  void _onItemTapped(int index) {

    // rebuildAllChildren(context);
    // print(index);
    setState(() {
      widContainer.resetHome();
      _selectedIndex = index;

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    widContainer = context.read<WidContainer>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> _widgetOptions = <Widget>[
    const HomeSTF()
    ,
      // ComplainPage(),
      const ComplainFeedbackSTL(),
      // Text(
      //   'Index 1: Messaging',
      //   style: optionStyle,
      // ),
      // ChatPanel(),
      NotificationPage(heading: "Notifications",nEnum: NotificationEnum.def,),
      Provider.of<WidContainer>(context).profilePanel,
      // Text(
      //   'Index 3: Profile',
      //   style: optionStyle,
      // ),
    ];


    return
     SafeArea(
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
  HomePageEnum enu;
  int? ID;

  HomePagePanel(this.enu, this.ID ,{Key? key}) : super(key: key);

  @override
  State<HomePagePanel> createState() => _HomePagePanelState();
}

class _HomePagePanelState extends State<HomePagePanel> {
  final _searchController = TextEditingController();
  final HomePageController homepagecontroller = HomePageController();
  late WidContainer widContainer;

  @override
  void initState() {
    // TODO: implement initState
    widContainer = context.read<WidContainer>();
    print(widget.enu);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    homepagecontroller.dispose();
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
      sliver: FutureBuilder(
          future: homePageGetData(widget.enu,widget.ID),
          builder: (context,snapshot){
            if(!snapshot.hasData) {
              //   return SliverPadding(padding: EdgeInsets.all(1));
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
                      return InkWell(
                        child: Container(

                            color: MyColor.white,
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                        ),
                        onTap: () {},
                      );
                    },
                    childCount: 20,
                  ),
                ),

              );
            }else{
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
                                  return InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: MyColor.white,
                                      ),
                                      child: Image(
                                      image: MemoryImage(Uint8List.fromList(homepagecontroller.grid![index].image!)) ,
                                  fit: BoxFit.cover,),

                                  ),
                                  onTap: (){
                                        setState(() {
                                          if(widget.enu == HomePageEnum.org)
                                            {
                                              // widget.enu = HomePageEnum.ins;
                                              // widget.ID = int.parse(homepagecontroller.grid![index].organizationTypeId!);
                                              widContainer.setToInst(int.parse(homepagecontroller.grid![index].organizationTypeId!));
                                            }else if(widget.enu == HomePageEnum.ins){
                                              widContainer.setToComplainPage(int.parse(homepagecontroller.grid![index].organizationTypeId!));

                                          }


                                        });

                                  },
                                  );
                                },
                                childCount: homepagecontroller.grid!.length,
                              ),

                          ),
                  );
            }

            },

      ),
    );
  }



  Future<List<MyMainGrid>> homePageGetData(HomePageEnum enu, [int? ID] ) async
  {

    print("Called homePageGetData");
    print("Called HomePageEnum: ");
    print(enu);
    print("Called ID: ");
    print(ID);

      if(enu == HomePageEnum.org)
        {
        await  homepagecontroller.getHomePageGrid();
          
        }else{
        await homepagecontroller.getInstitueseGrid(ID!);

      }
     return homepagecontroller.grid!;
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
    print("Container");
    print(context.read<WidContainer>().homePanel);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("Provider WidContainer:");
    print(context.watch<WidContainer>().homePanel);
    return (Provider.of<WidContainer>(context).homePanel);
  }
}
