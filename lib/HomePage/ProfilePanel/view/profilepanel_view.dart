import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnayan/AlWids.dart';
import 'package:unnayan/Components/cusomt_text_style.dart';
import 'package:unnayan/HomePage/ProfilePanel/controller/profilepanel_contorller.dart';
import 'package:unnayan/LoginPage/model/loginpage_model.dart';
import 'package:unnayan/my_color.dart';
import 'package:unnayan/my_vars.dart';

///
/// Profile Page Stateless Class for Profile Screen
///

class ProfileSTL extends StatelessWidget {
  const ProfileSTL({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/profile_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const SingleChildScrollView(child: ProfilePage()),
      ),
    );
  }
}

///
/// Profile Page Statefull Class for Profile Screen
///
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late LoginpageModel user;
  late String username, university;
  int totalNum = 0, historyNum = 0, pendingNum = 0;
  ProfileController con = ProfileController();
  @override
  void initState() {
    // TODO: implement initState

    user = context.read<LoginpageModel>();

    getComplainData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          Container(
            margin: EdgeInsets.only(left: 80, right: 80),
            child: ClipOval(
              child: (user.image!.isNotEmpty)
                  ? Image(
                      image: MemoryImage(Uint8List.fromList(user.image!)),
                      fit: BoxFit.cover,
                    )
                  : Image(
                      image: AssetImage('assets/images/unnayan_logo.png'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            Provider.of<LoginpageModel>(context, listen: false).name.toString(),
            style: CustomTextStyle.textStyle(MyColor.blackFont, 24),
          ),
          const SizedBox(
            height: 10,
          ),
          (context.read<LoginpageModel>().userType == 'user')
              ? Text(
                  Provider.of<LoginpageModel>(context, listen: false)
                      .universityName
                      .toString(),
                  style: CustomTextStyle.textStyle(MyColor.blackFont, 18),
                )
              : const SizedBox(
                  height: 30,
                ),
          const SizedBox(
            height: 30,
          ),
          const Divider(
            indent: 90,
            endIndent: 90,
            height: 1,
            color: MyColor.blackFont,
          ),
          ProfileInfoRow(
              (context.read<LoginpageModel>().userType == 'user')
                  ? 'History'
                  : 'Recent',
              historyNum,
              "History Of Complains",
              (context.read<LoginpageModel>().userType == 'user')
                  ? NotificationEnum.userHistory
                  : NotificationEnum.orgRecent),
          const Divider(
            indent: 90,
            endIndent: 90,
            height: 1,
            color: MyColor.blackFont,
          ),
          ProfileInfoRow(
              'Pending Complains',
              pendingNum,
              "Pending Complains",
              (context.read<LoginpageModel>().userType == 'user')
                  ? NotificationEnum.userPending
                  : NotificationEnum.orgPending),
          const Divider(
            indent: 90,
            endIndent: 90,
            height: 1,
            color: MyColor.blackFont,
          ),
          ProfileInfoRow(
              'Total Complains',
              totalNum,
              "Total Complains",
              (context.read<LoginpageModel>().userType == 'user')
                  ? NotificationEnum.userTotal
                  : NotificationEnum.orgTotal),
          const Divider(
            indent: 90,
            endIndent: 90,
            height: 1,
            color: MyColor.blackFont,
          ),
        ],
      ),
    );
  }

  Future getComplainData() async {
    print("User: " + user.iduser!.toString());
    int i = 0;
    int j = 0;
    int k = 0;
    if (context.read<LoginpageModel>().userType == 'user') {
      i = await con.getTotalUserData(user.iduser!);
      j = await con.getPendingUserData(user.iduser!);
      k = await con.getHistoryUserData(user.iduser!);
      setState(() {
        totalNum = i;
        pendingNum = j;
        historyNum = k;
      });
    } else {
      i = await con.getTotalOrgData(user.iduser!);
      j = await con.getPendingOrgData(user.iduser!);
      k = await con.getHistoryOrgData(user.iduser!);
      setState(() {
        totalNum = i;
        pendingNum = j;
        historyNum = k;
      });
    }
  }
}

class ProfileInfoRow extends StatefulWidget {
  final String title;
  final int number;
  final String notificationTitle;
  final NotificationEnum nEnum;

  const ProfileInfoRow(
      this.title, this.number, this.notificationTitle, this.nEnum,
      {Key? key})
      : super(key: key);

  @override
  State<ProfileInfoRow> createState() => _ProfileInfoRowState();
}

class _ProfileInfoRowState extends State<ProfileInfoRow> {
  late WidContainer widContainer;
  @override
  void initState() {
    // TODO: implement initState
    widContainer = context.read<WidContainer>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // const SizedBox(width: 50),
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 80),
              child: Text(
                widget.title,
                style: CustomTextStyle.textStyle(MyColor.blackFont, 14),
              ),
            ),
          ),
        ),
        Flexible(
          child: InkWell(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: ClipOval(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  decoration: const BoxDecoration(
                    // shape: BoxShape.circle,
                    color: MyColor.blueButton,
                  ),
                  child: Text(
                    widget.number.toString(),
                    style: CustomTextStyle.textStyle(MyColor.white, 10),
                  ),
                ),
              ),
            ),
            onTap: () {
              widContainer.setToProgileTONotificationPanel(
                  widget.notificationTitle, widget.nEnum);
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
