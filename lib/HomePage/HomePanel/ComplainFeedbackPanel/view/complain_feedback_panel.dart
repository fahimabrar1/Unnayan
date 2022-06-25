import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnayan/AlWids.dart';
import 'package:unnayan/Components/cusomt_text_style.dart';
import 'package:unnayan/HomePage/HomePanel/ComplainFeedbackPanel/controller/complain_feedback_controller.dart';
import 'package:unnayan/HomePage/HomePanel/ComplainFeedbackPanel/model/complain_feedback_model.dart';
import 'package:unnayan/HomePage/NotificationPanel/model/notificationpanel_model.dart';
import 'package:unnayan/LoginPage/model/loginpage_model.dart';
import 'package:unnayan/my_color.dart';

class ComplainFeedbackSTL extends StatelessWidget {
  NotificationPageModel notificationPageModel;
  ComplainFeedbackSTL(this.notificationPageModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComplainFeedbackPage(notificationPageModel);
  }
}

class ComplainFeedbackPage extends StatefulWidget {
  NotificationPageModel? notificationPageModel;
  ComplainFeedbackPage(this.notificationPageModel, {Key? key})
      : super(key: key);

  @override
  State<ComplainFeedbackPage> createState() => _ComplainFeedbackPageState();
}

class _ComplainFeedbackPageState extends State<ComplainFeedbackPage> {
  late bool isSolved;
  ComplainFeedbackPanelController controller =
      ComplainFeedbackPanelController();
  late ComplainFeedBackPanelModel user;
  final detailsByOrg = TextEditingController();
  bool clickedSubmit = false;
  final submitFeedbackByOrg = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    if (widget.notificationPageModel!.status == 'solved') {
      isSolved = true;
    } else {
      isSolved = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: MyColor.darkBlue,
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          FutureBuilder<ComplainFeedBackPanelModel>(
            future: getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                        height: 60,
                        width: 60,
                        child: ClipOval(
                            child: Image(
                          image: MemoryImage(
                            Uint8List.fromList(user.image!),
                          ),
                        ))),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.username.toString(),
                          style: CustomTextStyle.textStyle(MyColor.white, 16),
                        ),
                        Text(
                          user.location.toString(),
                          style: CustomTextStyle.textStyle(MyColor.white, 10),
                        ),
                      ],
                    )
                  ],
                );
              } else {
                return Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    ClipOval(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        color: MyColor.white,
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                            height: 2,
                            width: 100,
                            child: LinearProgressIndicator()),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            height: 2,
                            width: 100,
                            child: LinearProgressIndicator()),
                      ],
                    )
                  ],
                );
              }
            },
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Text(
              widget.notificationPageModel!.detailsByUser.toString(),
              style: CustomTextStyle.textStyle(MyColor.white, 14),
              textAlign: TextAlign.justify,
            ),
          ),
          (widget.notificationPageModel!.image != null)
              ? Image(
                  image: MemoryImage(
                    Uint8List.fromList(widget.notificationPageModel!.image!),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Feed Back:',
                  style:
                      CustomTextStyle.textStyle(MyColor.bottomNavItemColor, 14),
                ),
                (isSolved)
                    ? Text(
                        'Solved',
                        style:
                            CustomTextStyle.textStyle(MyColor.greenButton, 14),
                      )
                    : Text(
                        'Pending',
                        style: CustomTextStyle.textStyle(MyColor.red, 14),
                      ),
              ],
            ),
          ),
          (isSolved && context.read<LoginpageModel>().userType == 'user')
              ? Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Text(
                    widget.notificationPageModel!.detaiilsByOrg!,
                    style: CustomTextStyle.textStyle(MyColor.white, 14),
                    textAlign: TextAlign.justify,
                  ),
                )
              : (!isSolved &&
                      context.read<LoginpageModel>().userType == 'organization')
                  ? getInfoPanel()
                  : Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Text(
                        widget.notificationPageModel!.detaiilsByOrg!,
                        style: CustomTextStyle.textStyle(MyColor.white, 14),
                        textAlign: TextAlign.justify,
                      ),
                    ),
        ],
      )),
    );
  }

  Widget getInfoPanel() {
    return Form(
        key: submitFeedbackByOrg,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: MyColor.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextField(
                  controller: detailsByOrg,
                  decoration: InputDecoration(
                    errorText: clickedSubmit ? errorDetailsByOrgText : null,
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 5,
                  style: CustomTextStyle.textStyle(MyColor.blackFont, 14),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                child: ElevatedButton(
                  onPressed: insertFeedbackByOrg,
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: MyColor.blackFont),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      MyColor.greenButton,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> insertFeedbackByOrg() async {
    setState(() {
      clickedSubmit = true;
    });
    if (detailsByOrg.value.text.isNotEmpty) {
      await controller
          .insertFeedbackByOrg(widget.notificationPageModel!.complainId!,
              detailsByOrg.value.text)
          .whenComplete(() {
        Future.delayed(const Duration(seconds: 1)).whenComplete(() {
          context.read<WidContainer>().resetHome();
        });
      });
    }
  }

  String? get errorDetailsByOrgText {
    final text = detailsByOrg.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    return null;
  }

  Future<ComplainFeedBackPanelModel> getUser() async {
    user =
        (await controller.getUserData(widget.notificationPageModel!.iduser!))!;

    return user;
  }
}
