import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnayan/Components/cusomt_text_style.dart';
import 'package:unnayan/HomePage/NotificationPanel/controller/notificationpanel_controller.dart';
import 'package:unnayan/HomePage/NotificationPanel/model/notificationpanel_model.dart';
import 'package:unnayan/LoginPage/model/loginpage_model.dart';
import 'package:unnayan/my_color.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _searchController = TextEditingController();
  late List<NotificationPageModel> _allUsers;
  // late List<Map<String, dynamic>> _allUsers;
  // [
  //   {"id": 1, "name": "Andy", "subtitle": "This is my subtitle"},
  //   {"id": 2, "name": "Aragon", "subtitle": "This is my subtitle"},
  //   {"id": 3, "name": "Bob", "subtitle": "This is my subtitle"},
  //   {"id": 4, "name": "Barbara", "subtitle": "This is my subtitle"},
  //   {"id": 5, "name": "Candy", "subtitle": "This is my subtitle"},
  //   {"id": 6, "name": "Colin", "subtitle": "This is my subtitle"},
  //   {"id": 7, "name": "Audra", "subtitle": "This is my subtitle"},
  //   {"id": 8, "name": "Banana", "subtitle": "This is my subtitle"},
  //   {"id": 9, "name": "Caversky", "subtitle": "This is my subtitle"},
  //   {"id": 10, "name": "Becky", "subtitle": "This is my subtitle"},
  // ];
  late List<NotificationPageModel> _foundUsers;

  var conTroller = NotificationPageContoller();


  @override
  void initState() {
    // conTroller.showList(Provider.of<LoginpageModel>(context).iduser!).then((value){
    //   _allUsers = value!;
    //   _foundUsers = _allUsers;
    // });


    // _allUsers = conTroller.showList(1);


    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<NotificationPageModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user)=>
            user.name!.toLowerCase().contains(enteredKeyword.toLowerCase())
          )
          .toList() as List<NotificationPageModel>;
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

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
                'Heading',
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
        FutureBuilder(
          future: getIData(),
          builder: (context, snap){
            if(snap.hasData)
              {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return NotificationTile(index, _foundUsers);
                    },
                    childCount: (_foundUsers.length>0)?_foundUsers.length:50,
                  ),
                );
              }else{

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return NotificationTile(index, null);
                  },
                  childCount: 50,
                ),
              );
            }

          },

        ),
      ]


          ),
    );
  }


  Future<List<NotificationPageModel>> getIData() async{

    await conTroller.showList(1).then((value){
       print("Bal 2");
       print(value);
      _allUsers = value!;
      _foundUsers = _allUsers;
    });
     return _foundUsers;
  }
}

class NotificationTile extends StatefulWidget {
  final int index;
  List<NotificationPageModel>? foundUsers;
  NotificationTile(this.index, this.foundUsers, {Key? key}) : super(key: key);

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: Card(
                color: MyColor.whiteLowOpacity,
                child: (widget.foundUsers!=null)?ListTile(
                  leading:Image(image: MemoryImage(Uint8List.fromList(widget.foundUsers![widget.index].image!),),),
                  // const FlutterLogo(
                  //   size: 30,
                  // ),
                  title: Text(widget.foundUsers![widget.index].name.toString()),
                  subtitle: Text("Gave a feedback, Please Check"),
                  onTap: () {},
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
