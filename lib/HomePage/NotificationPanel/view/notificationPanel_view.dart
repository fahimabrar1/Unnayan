import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnayan/AlWids.dart';
import 'package:unnayan/Components/cusomt_text_style.dart';
import 'package:unnayan/HomePage/NotificationPanel/controller/notificationpanel_controller.dart';
import 'package:unnayan/HomePage/NotificationPanel/model/notificationpanel_model.dart';
import 'package:unnayan/LoginPage/model/loginpage_model.dart';
import 'package:unnayan/my_color.dart';
import 'package:unnayan/my_vars.dart';

class NotificationPage extends StatefulWidget {
  String? heading;
  NotificationEnum? nEnum;
   NotificationPage({ this.heading,this.nEnum, Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _searchController = TextEditingController();
  late List<NotificationPageModel> _allUsers;

  late List<NotificationPageModel> _foundUsers;

  var conTroller = NotificationPageContoller();
  // bool fetchedData = false;

  @override
  void initState() {
    // conTroller.showList(Provider.of<LoginpageModel>(context).iduser!).then((value){
    //   _allUsers = value!;
    //   _foundUsers = _allUsers;
    // });


    // _allUsers = conTroller.showList(1);

    getIData(context.read<LoginpageModel>().iduser!);
    super.initState();
  }
  bool fetchUserData = false;



  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColor.darkBackground,
      child: CustomScrollView(slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                (widget.heading!=null)?widget.heading!:"Notifications",
                style: CustomTextStyle.textStyle(MyColor.white, 18),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 40,
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => _runFilter(val),
              decoration: const InputDecoration(
                filled: true,
                fillColor: MyColor.whiteLowOpacity,
                labelText: "Search",
                hintText: "Search",
                suffixIcon: Icon(Icons.search),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyColor.blackFont),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        (fetchUserData)?
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return NotificationTile(index, _foundUsers,widget.nEnum);
            },
            childCount: _foundUsers.length,
          ),
        ):
      SliverToBoxAdapter(child:  Center(
        child: Container(child: Center(
          child: SizedBox(width: 50,height: 50,child: CircularProgressIndicator(),),
        ),),
      ),),

      ]


          ),
    );
  }


  Future<List<NotificationPageModel>> getIData(int ID) async{

    await conTroller.showList(ID , widget.nEnum!).then((value){
       print("Bal 2");
       print(value);

      setState(() {
        fetchUserData = true;
        _allUsers = value!;
        _foundUsers = _allUsers;
      });
    });
     return _foundUsers;
  }


  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<NotificationPageModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {

      _allUsers.forEach((element) {
        if(element.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
        {
          print(element.name);
          results.add(element);
        }
      });

      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
      print("Founder LEngth: "+_foundUsers.length.toString());
    });
  }


}

class NotificationTile extends StatefulWidget {
  final int index;
  List<NotificationPageModel>? foundUsers;
  NotificationEnum? nEnum;
  NotificationTile(this.index, this.foundUsers, this.nEnum, {Key? key}) : super(key: key);

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  late WidContainer container;
  @override
  void initState() {

    container = context.read<WidContainer>();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: (widget.nEnum==NotificationEnum.def)?Card(
                color: MyColor.whiteLowOpacity,
                child: (widget.foundUsers!=null)?ListTile(
                  leading:SizedBox(
                      height: 50,
                      width: 50,
                      child: ClipOval(child: Container(
                          padding: EdgeInsets.all(5),
                          color: MyColor.white,
                          child: Image(image: MemoryImage(Uint8List.fromList(widget.foundUsers![widget.index].image!),),)))),

                  title: Text(widget.foundUsers![widget.index].name.toString()),
                  subtitle: Text("Gave a feedback, Please Check"),
                ):Padding(
                  padding: const EdgeInsets.only(top: 30.0,bottom: 30,left: 50,right: 50),
                  child: Center(child: const LinearProgressIndicator()),
                ),
                elevation: 2,
              ):Card(
                color: MyColor.whiteLowOpacity,
                child: (widget.foundUsers!=null)?ListTile(
                  leading:SizedBox(
                      height: 50,
                      width: 50,
                      child: ClipOval(child: Container(
                          padding: EdgeInsets.all(5),
                          color: MyColor.white,
                          child: Image(image: MemoryImage(Uint8List.fromList(widget.foundUsers![widget.index].image!),),)))),

                  title: Text(widget.foundUsers![widget.index].name.toString()),
                  subtitle: Text("Gave a feedback, Please Check"),
                  onTap: () {
                    container.setToProgileTONFeedbackpanel();
                  },
                ):Padding(
                  padding: const EdgeInsets.only(top: 30.0,bottom: 30,left: 50,right: 50),
                  child: Center(child: const LinearProgressIndicator()),
                ),
                elevation: 2,
              ),
            ),
          ],
        ),
        const Divider(
          indent: 10,
          endIndent: 10,
          color: MyColor.blackFont,
        ),
      ],
    );
  }
}
