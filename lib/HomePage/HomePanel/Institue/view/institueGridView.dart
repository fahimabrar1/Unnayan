import 'dart:typed_data';

import 'package:flutter/material.dart';

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
  bool InstituesVisible = false;
  Widget getGridView() {
    return SliverPadding(
      padding: const EdgeInsets.all(10.0),
      sliver: FutureBuilder(
        future: InstituteGetData(),
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
                        if(!InstituesVisible)
                        {
                          setState(() {
                            InstituesVisible = true;
                            homepagecontroller.getInstitueseGrid(int.parse(homepagecontroller.grid![index].organizationTypeId!));

                          });
                        }

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



  Future<List<MyMainGrid>> InstituteGetData() async
  {
    await homepagecontroller.initDatabase().whenComplete(() =>
        homepagecontroller.getInstitueseGrid(widget.ID!));
    return homepagecontroller.grid!;
  }
}
