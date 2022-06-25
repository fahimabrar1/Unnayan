import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnayan/AlWids.dart';
import 'package:unnayan/Components/badge_model.dart';
import 'package:unnayan/Components/cusomt_text_style.dart';
import 'package:unnayan/HomePage/NotificationPanel/controller/notificationpanel_controller.dart';
import 'package:unnayan/HomePage/NotificationPanel/model/notificationpanel_model.dart';
import 'package:unnayan/LoginPage/model/loginpage_model.dart';
import 'package:unnayan/my_color.dart';
import 'package:unnayan/my_vars.dart';

class NotificationPage extends StatefulWidget {
  final String? heading;
  final NotificationEnum? nEnum;

  const NotificationPage({this.heading, this.nEnum, Key? key})
      : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _searchController = TextEditingController();
  late List<NotificationPageModel> _allUsers;
  late List<NotificationPageModel> _foundUsers;
  bool fetchUserData = false;

  var conTroller = NotificationPageController();
  late BadgeCounter badgeCounter;
  @override
  void initState() {
    log("Initializing Notification.");
    getIData(context.read<LoginpageModel>().iduser!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
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
                  (widget.heading != null) ? widget.heading! : "Notifications",
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
          (fetchUserData)
              ? (_foundUsers.isEmpty)
                  ? const SliverToBoxAdapter(
                      child: Center(
                        child: Text("No Notifications Found"),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return NotificationTile(
                              index, _foundUsers, widget.nEnum);
                        },
                        childCount: _foundUsers.length,
                      ),
                    )
              : const SliverToBoxAdapter(
                  child: Center(
                    child: Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
        ]),
      ),
    );
  }

  Future<List<NotificationPageModel>> getIData(int ID) async {
    await conTroller
        .showList(ID, widget.nEnum!, "true",
            context.read<LoginpageModel>().userType.toString())
        .then((value) {
      log("Bal 2");
      log(value.toString());

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
      for (var element in _allUsers) {
        if (element.name!
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase())) {
          log(element.name.toString());
          results.add(element);
        }
      }

      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
      log("Founder LEngth: " + _foundUsers.length.toString());
    });
  }

  Future<bool> popOut() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}

class NotificationTile extends StatefulWidget {
  final int index;
  final List<NotificationPageModel>? foundUsers;
  final NotificationEnum? nEnum;

  const NotificationTile(this.index, this.foundUsers, this.nEnum, {Key? key})
      : super(key: key);

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  late WidContainer container;
  NotificationPageController controller = NotificationPageController();
  late bool gotImage;
  late List<int> displayImage;

  @override
  void initState() {
    container = context.read<WidContainer>();
    gotImage = false;
    getTileLogo();
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
              child: (widget.nEnum == NotificationEnum.def)
                  ? (context.read<LoginpageModel>().userType == 'user')
                      ? Card(
                          color: MyColor.whiteLowOpacity,
                          child: (widget.foundUsers != null)
                              ? ListTile(
                                  leading: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: ClipOval(
                                      child: Container(
                                        color: MyColor.white,
                                        child: (gotImage)
                                            ? Image(
                                                image: MemoryImage(
                                                  Uint8List.fromList(
                                                      displayImage),
                                                ),
                                                fit: BoxFit.cover,
                                              )
                                            : const CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                  title: Text(widget
                                      .foundUsers![widget.index].name
                                      .toString()),
                                  subtitle: const Text(
                                      "Gave a feedback, Please Check"),
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(
                                      top: 30.0,
                                      bottom: 30,
                                      left: 50,
                                      right: 50),
                                  child:
                                      Center(child: LinearProgressIndicator()),
                                ),
                          elevation: 2,
                        )
                      : Card(
                          color: MyColor.whiteLowOpacity,
                          child: (widget.foundUsers != null)
                              ? ListTile(
                                  leading: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: ClipOval(
                                      child: Container(
                                        color: MyColor.white,
                                        child: (gotImage)
                                            ? Image(
                                                image: MemoryImage(
                                                  Uint8List.fromList(
                                                      displayImage),
                                                ),
                                                fit: BoxFit.cover,
                                              )
                                            : const CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                  title: Text(widget
                                      .foundUsers![widget.index].name
                                      .toString()),
                                  subtitle: Text((widget
                                              .foundUsers![widget.index]
                                              .detailsByUser!
                                              .length >
                                          30)
                                      ? widget.foundUsers![widget.index]
                                              .detailsByUser!
                                              .substring(0, 30)
                                              .replaceAll('\n', ' ') +
                                          '...'
                                      : widget.foundUsers![widget.index]
                                          .detailsByUser!),
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(
                                      top: 30.0,
                                      bottom: 30,
                                      left: 50,
                                      right: 50),
                                  child:
                                      Center(child: LinearProgressIndicator()),
                                ),
                          elevation: 2,
                        )
                  : Card(
                      color: MyColor.whiteLowOpacity,
                      child: (widget.foundUsers != null)
                          ? ListTile(
                              leading: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: ClipOval(
                                      child: Container(
                                    color: MyColor.white,
                                    child: (gotImage)
                                        ? Image(
                                            image: MemoryImage(
                                              Uint8List.fromList(displayImage),
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : const CircularProgressIndicator(),
                                  ))),
                              title: Text(widget.foundUsers![widget.index].name
                                  .toString()),
                              subtitle: Text((widget.foundUsers![widget.index]
                                          .detailsByUser!.length >
                                      30)
                                  ? widget.foundUsers![widget.index]
                                          .detailsByUser!
                                          .substring(0, 30)
                                          .replaceAll('\n', ' ') +
                                      '...'
                                  : widget.foundUsers![widget.index]
                                      .detailsByUser!),
                              onTap: () {
                                container.setToProgileTONFeedbackpanel(
                                    widget.foundUsers![widget.index]);
                              },
                            )
                          : const Padding(
                              padding: EdgeInsets.only(
                                  top: 30.0, bottom: 30, left: 50, right: 50),
                              child: Center(child: LinearProgressIndicator()),
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

  Future getTileLogo() async {
    return await controller
        .getTileLogo(
            (context.read<LoginpageModel>().userType != 'user')
                ? widget.foundUsers![widget.index].iduser!
                : widget.foundUsers![widget.index].organizationsId!,
            context)
        .then((value) {
      setState(() {
        displayImage = value!;
        gotImage = true;
      });
    });
  }
}
