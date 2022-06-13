import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnayan/Components/cusomt_text_style.dart';
import 'package:unnayan/LoginPage/model/loginpage_model.dart';
import 'package:unnayan/my_color.dart';

///
/// Profile Page Stateless Class for Profile Screen
///

class ProfileSTL extends StatelessWidget {
  const ProfileSTL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/profile_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: const SingleChildScrollView(child: ProfilePage()),
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


  @override
  Widget build(BuildContext context) {
    user = Provider.of<LoginpageModel>(context,listen: false);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
           Container(
             margin: EdgeInsets.only(left: 80,right: 80),
             child: ClipOval(
                 child: (Provider.of<LoginpageModel>(context, listen: false).image!.isNotEmpty)?Image(
                  image: MemoryImage(Uint8List.fromList(Provider.of<LoginpageModel>(context, listen: false).image!)) ,
          fit: BoxFit.cover,):Image(
                  image: AssetImage('assets/images/unnayan_logo.png') ,
          fit: BoxFit.cover,),

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
          Text(
            Provider.of<LoginpageModel>(context, listen: false).universityName.toString(),
            style: CustomTextStyle.textStyle(MyColor.blackFont, 18),
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
          ProfileInfoRow('History', 12),
          const Divider(
            indent: 90,
            endIndent: 90,
            height: 1,
            color: MyColor.blackFont,
          ),
          ProfileInfoRow('Pending Complains', 12),
          const Divider(
            indent: 90,
            endIndent: 90,
            height: 1,
            color: MyColor.blackFont,
          ),
          ProfileInfoRow('Total Complains', 12),
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
}

class ProfileInfoRow extends StatelessWidget {
  final String title;
  final int number;
  const ProfileInfoRow(
    this.title,
    this.number, {
    Key? key,
  }) : super(key: key);

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
                title,
                style: CustomTextStyle.textStyle(MyColor.blackFont, 14),
              ),
            ),
          ),
        ),
        Flexible(
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
                  number.toString(),
                  style: CustomTextStyle.textStyle(MyColor.white, 10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
