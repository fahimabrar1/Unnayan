import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:unnayan/LoginPage/CreateAccount/controller/create_account_controller.dart';
import 'package:unnayan/LoginPage/view/loginpage_view.dart';
import 'package:unnayan/my_color.dart';

class CreateAcountSTF extends StatefulWidget {
  const CreateAcountSTF({Key? key}) : super(key: key);

  @override
  State<CreateAcountSTF> createState() => _CreateAcountSTFState();
}

class _CreateAcountSTFState extends State<CreateAcountSTF> {
  final createAccountKey = GlobalKey<FormState>();
  late String userDropdownValue;
  late String orgDropdownValue;

  final List<String> orgItems = [
    'Hospital',
    'Shopping Center',
    'Education',
    'Cinema',
    'Industry',
    'Dhaka Metro Poline'
  ];
  bool ifOrg = false;
  List<int>? fileBytes;

  late bool fileAttached;
  String? FullName,
      Email,
      Password,
      Location,
      Username,
      CellNumber,
      UserType,
      InstituteName;
  int? orgType;
  final CreateAccountController createAccountController =
      CreateAccountController();
  final usernameTextController = TextEditingController();
  bool validUserName = false;
  @override
  void initState() {
    // TODO: implement initState
    userDropdownValue = 'User';
    orgDropdownValue = orgItems.first;
    UserType = userDropdownValue.toLowerCase();
    orgType = orgItems.indexOf(orgItems.first) + 1;
    fileAttached = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyColor.tealBackground,
        body: SingleChildScrollView(
          child: Form(
            key: createAccountKey,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: AddPhoto,
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipOval(
                              child: Container(
                                color: MyColor.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: (fileAttached == true)
                                      ? ClipOval(
                                          child: Image(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(
                                            Uint8List.fromList(fileBytes!),
                                          ),
                                        ))
                                      : ClipOval(
                                          child: Container(
                                            color: MyColor.ash,
                                            child: const Icon(Icons.camera_alt),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(left: 75),
                                child: Icon(
                                  Icons.add,
                                  size: 32,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(child: Text("Select User Type: ")),
                            Flexible(
                              child: DropdownButton<String>(
                                value: userDropdownValue,
                                icon: const Icon(
                                  Icons.arrow_downward,
                                  color: MyColor.white,
                                ),
                                elevation: 16,
                                style: const TextStyle(color: MyColor.darkBlue),
                                underline: Container(
                                  height: 2,
                                  color: MyColor.darkBlue,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    userDropdownValue = newValue!;
                                    UserType = newValue.toLowerCase();
                                    log(newValue.toString());
                                    if (newValue == "User") {
                                      ifOrg = false;
                                    } else {
                                      ifOrg = true;
                                      InstituteName = null;
                                    }
                                  });
                                },
                                items: <String>[
                                  'User',
                                  'Organization'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        (ifOrg == true)
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Expanded(
                                      child:
                                          Text("Select Organization Type: ")),
                                  Flexible(
                                    child: DropdownButton<String>(
                                      value: orgDropdownValue,
                                      icon: const Icon(
                                        Icons.arrow_downward,
                                        color: MyColor.white,
                                      ),
                                      elevation: 16,
                                      style: const TextStyle(
                                          color: MyColor.darkBlue),
                                      underline: Container(
                                        height: 2,
                                        color: MyColor.darkBlue,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          orgDropdownValue = newValue!;
                                          orgType =
                                              orgItems.indexOf(newValue) + 1;
                                          log(orgType.toString());
                                        });
                                      },
                                      items: orgItems
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              )
                            : Container(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Full Name',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Name';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          FullName = val;
                        });
                      },
                    ),
                    TextFormField(
                      controller: usernameTextController,
                      decoration: InputDecoration(
                        suffixIcon: (usernameTextController.value.text.isEmpty)
                            ? null
                            : (validUserName)
                                ? const Icon(
                                    Icons.check_circle_outline,
                                    color: MyColor.greenButton,
                                  )
                                : RotationTransition(
                                    turns: new AlwaysStoppedAnimation(45 / 360),
                                    child: const Icon(
                                      Icons.add_circle_outline,
                                      color: MyColor.red,
                                    ),
                                  ),
                        hintText: 'Username',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Username';
                        } else if (!validUserName) {
                          return 'User Already Exists,Use a valid username';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          Username = val.trim();
                          checkUserNameFromDB(Username);
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Enailc';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return "Please enter a valid email address";
                        }

                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          Email = val;
                        });
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          Password = val;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Cell No.',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Cell No.';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          CellNumber = val;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Location',
                      ),
                      keyboardType: TextInputType.streetAddress,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Location';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          Location = val;
                        });
                      },
                    ),
                    (ifOrg == false)
                        ? TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Institution Name',
                            ),
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Institution Name';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                InstituteName = val;
                              });
                            },
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (createAccountKey.currentState!.validate()) {
                            // Process data.

                            onSubmit();
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSubmit() async {
    if (UserType == 'user') {
      await createAccountController
          .createAccountForUser(FullName, Email, Password, Location, fileBytes,
              Username, CellNumber, UserType, InstituteName)
          .whenComplete(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const LoginPage()));
      });
    } else {
      await createAccountController
          .createAccountForOrg(FullName, Email, Password, Location, fileBytes,
              Username, CellNumber, UserType, orgType)
          .whenComplete(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const LoginPage()));
      });
    }
  }

  Future<void> AddPhoto() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);

    if (result != null) {
      PlatformFile file = result.files.first;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("File Attachment"),
      ));

      setState(() {
        fileBytes = file.bytes;

        log(fileBytes.toString());

        fileAttached = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed To Upload Attachment"),
      ));
      fileAttached = false;
    }
  }

  Future<void> checkUserNameFromDB(String? username) async {
    createAccountController.checkUserNameFromDB(username!).then((value) {
      setState(() {
        validUserName = !value;
      });
    });
  }
}
