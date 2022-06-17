import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnayan/Components/cusomt_text_style.dart';
import 'package:unnayan/Components/utility_file.dart';
import 'package:unnayan/HomePage/HomePanel/ComplainPanel/controller/complainpanel_controller.dart';
import 'package:unnayan/HomePage/HomePanel/ComplainPanel/model/complainpanel_model.dart';
import 'package:unnayan/my_color.dart';
import 'package:unnayan/my_vars.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../LoginPage/model/loginpage_model.dart';

class ComplainPage extends StatefulWidget {
  int? organizationID;
  ComplainPage(this.organizationID,{Key? key}) : super(key: key);

  @override
  State<ComplainPage> createState() => _ComplainPageState();
}

class _ComplainPageState extends State<ComplainPage> {
  String? filename = "";
  bool fileAttached = false;
  final nameContorller = TextEditingController();
  final emailContorller = TextEditingController();
  final phoneContorller = TextEditingController();
  final detailContorller = TextEditingController();
  Uint8List? fileBytes;
  String? name,email,phone,detail;
  final conTroller = ComplainPanelContorller();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Image(
                          image: AssetImage('assets/images/unnayan_logo.png'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        padding: const EdgeInsets.all(10),
                        height: 120,
                        decoration: BoxDecoration(
                          color: MyColor.greenButton,
                          borderRadius: BorderRadius.all(
                            Radius.circular(borderRadius),
                          ),
                        ),
                        child: const Center(
                          child: FittedBox(
                            child: Text(
                              "Please give your authenticcomplain\ngiven the box bellow.If you have \nto need upload any type of photos \nor pdf you can share.Give us some\ninformation about you for contact\nafter solution ",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Align(
                    child: Text(
                      "Please give some Information.",
                      style: CustomTextStyle.textStyle(MyColor.blackFont, 14),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Divider(
                    color: MyColor.blackFont,
                    endIndent: 150,
                  ),
                ),
                getInfoPanel(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget getInfoPanel() {
    return Form(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 80,
            right: 80,
          ),
          child: TextField(
            controller: nameContorller,
            onChanged: (val)
            {
              name = val;
            },
            decoration: new InputDecoration(
              hintText: 'Name',
            ),
            keyboardType: TextInputType.text,
            style: CustomTextStyle.textStyle(MyColor.blackFont, 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 80,
            right: 80,
          ),
          child: TextField(
            controller: emailContorller,
            onChanged: (val)
            {
              email = val;
            },
            decoration: new InputDecoration(
              hintText: 'Email Address',
            ),
            keyboardType: TextInputType.emailAddress,
            style: CustomTextStyle.textStyle(MyColor.blackFont, 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 80,
            right: 80,
          ),
          child: TextField(
            controller: phoneContorller,
            onChanged: (val)
            {
              phone = val;
            },
            decoration: new InputDecoration(
              hintText: 'Phone',
            ),
            keyboardType: TextInputType.phone,
            style: CustomTextStyle.textStyle(MyColor.blackFont, 14),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Align(
            child: Text(
              "Please give your complaint here.",
              style: CustomTextStyle.textStyle(MyColor.blackFont, 14),
            ),
            alignment: Alignment.centerLeft,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: MyColor.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextField(
              controller: detailContorller,
              onChanged: (val)
              {
                detail = val;
              },
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
        ElevatedButton(
          onPressed: uploadAttachment,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Upload attachment'), // <-- Text
              const SizedBox(
                width: 5,
              ),
              const Icon(
                // <-- Icon
                Icons.upload,
                size: 24.0,
              ),
            ],
          ),
        ),
        (fileAttached)
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  filename!,
                  style: CustomTextStyle.textStyle(MyColor.blackFont, 8),
                ),
              )
            : Container(),
        ElevatedButton(
          onPressed: onSubmit,
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
      ],
    ));
  }

  Future uploadAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("File Attachment"),
      ));

      setState(() {
        fileBytes = result.files.first.bytes;
        print(file);
        filename = file.name;
        fileAttached = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed To Upload Attachment"),
      ));
      filename = null;
      fileAttached = false;
    }
  }





  void onSubmit(){
    ComplainPanelModel model = ComplainPanelModel(
        name: this.name,
        email: this.email,
        phone: this.phone,
        details: this.detail,
        status: "Pending",
        showNotiftoOrg: "ture",
        showNotiftoUser: "false",
        // iduser: Provider.of<LoginpageModel>(context,listen: false).iduser,
        iduser: 1,
        organizationTypeId: widget.organizationID,
        image: fileBytes
    );
    conTroller.submitComplain(model,context);


  }
}
