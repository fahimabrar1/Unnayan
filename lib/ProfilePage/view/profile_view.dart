import 'package:flutter/material.dart';
import 'package:unnayan/Components/cusomt_text_style.dart';
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
      child: const ProfilePage(),
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/images/unnayan_logo.png'),
          ),
          const SizedBox(height: 30),
          Text(
            'Md.Saiful Islam',
            style: CustomTextStyle.textStyle(MyColor.blackFont, 24),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'United International University',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'History',
                style: CustomTextStyle.textStyle(MyColor.blackFont, 14),
              ),
              const SizedBox(
                width: 50,
              ),
              Container(
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
                      '12',
                      style: CustomTextStyle.textStyle(MyColor.white, 10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            indent: 90,
            endIndent: 90,
            height: 1,
            color: MyColor.blackFont,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Pending Complains',
                style: CustomTextStyle.textStyle(MyColor.blackFont, 14),
              ),
              const SizedBox(
                width: 50,
              ),
              Container(
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
                      '12',
                      style: CustomTextStyle.textStyle(MyColor.white, 10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            indent: 90,
            endIndent: 90,
            height: 1,
            color: MyColor.blackFont,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Total Complains',
                style: CustomTextStyle.textStyle(MyColor.blackFont, 14),
              ),
              const SizedBox(
                width: 50,
              ),
              Container(
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
                      '12',
                      style: CustomTextStyle.textStyle(MyColor.white, 10),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
