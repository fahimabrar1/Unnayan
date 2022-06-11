import 'package:flutter/material.dart';
import 'package:unnayan/Components/cusomt_text_style.dart';
import 'package:unnayan/my_color.dart';

class ComplainFeedbackSTL extends StatelessWidget {
  const ComplainFeedbackSTL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComplainFeedbackPage();
  }
}

class ComplainFeedbackPage extends StatefulWidget {
  const ComplainFeedbackPage({Key? key}) : super(key: key);

  @override
  State<ComplainFeedbackPage> createState() => _ComplainFeedbackPageState();
}

class _ComplainFeedbackPageState extends State<ComplainFeedbackPage> {
  bool isSolved = true;
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
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const ClipOval(child: const FlutterLogo()),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: CustomTextStyle.textStyle(MyColor.white, 16),
                  ),
                  Text(
                    "Location",
                    style: CustomTextStyle.textStyle(MyColor.white, 10),
                  ),
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style: CustomTextStyle.textStyle(MyColor.white, 10),
              textAlign: TextAlign.justify,
            ),
          ),
          Placeholder(),
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
          (isSolved)
              ? Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                    style: CustomTextStyle.textStyle(MyColor.white, 10),
                    textAlign: TextAlign.justify,
                  ),
                )
              : getInfoPanel(),
        ],
      )),
    );
  }

  Widget getInfoPanel() {
    return Form(
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
              decoration: const InputDecoration(
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
            margin: EdgeInsets.only(right: 20),
            child: ElevatedButton(
              onPressed: () {},
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
}
