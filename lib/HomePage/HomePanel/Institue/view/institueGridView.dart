import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnayan/AlWids.dart';

import '../../../../my_color.dart';
import '../../controller/homepanel_controller.dart';
import '../../model/homepanel_model.dart';

class InstituteGridPanel extends StatefulWidget {
  int? ID;
  InstituteGridPanel(this.ID, {Key? key}) : super(key: key);

  @override
  State<InstituteGridPanel> createState() => _InstituteGridPanelState();
}

class _InstituteGridPanelState extends State<InstituteGridPanel> {
  final _searchController = TextEditingController();
  final HomePageController homepagecontroller = HomePageController();
  late WidContainer widContainer;
  late List<MyMainGrid>? _allUsers;
  late List<MyMainGrid>? _foundUsers;
  late bool fetchGridData;
  bool InstituesVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    fetchGridData = false;
    widContainer = context.read<WidContainer>();
    InstituteGetData();
    super.initState();
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
        sliver: (!fetchGridData)
            ? SliverPadding(
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
                            )),
                        onTap: () {},
                      );
                    },
                    childCount: 20,
                  ),
                ),
              )
            : (_foundUsers == null || _foundUsers?.length == 0)
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text("No Organizations Found"),
                    ),
                  )
                : SliverPadding(
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
                                image: MemoryImage(Uint8List.fromList(
                                    _foundUsers![index].image!)),
                                fit: BoxFit.cover,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                widContainer.setToComplainPage(int.parse(
                                    _foundUsers![index].organizationTypeId!));
                              });
                            },
                          );
                        },
                        childCount: _foundUsers!.length,
                      ),
                    ),
                  ));
  }

  Future<void> InstituteGetData() async {
    await homepagecontroller
        .initDatabase()
        .whenComplete(() => homepagecontroller.getInstitutesGrid(widget.ID!))
        .whenComplete(() {
      setState(() {
        fetchGridData = true;
        _allUsers = homepagecontroller.grid;
        _foundUsers = _allUsers;
      });
    });
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

    log("Founder LEngth: " + _foundUsers!.length.toString());
  }
}
