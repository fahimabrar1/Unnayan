import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:unnayan/my_color.dart';

///
/// Login Page Stateless Class for Login Screen
///
class LoginPageSTL extends StatelessWidget {
  const LoginPageSTL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}

///
/// Login Page Statefull Class for Login Screen
///
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 100, maxHeight: 300),
                    ),
                    SizedBox(
                      child: Image.asset('assets/images/unnayan_logo.png'),
                      height: 150,
                      width: 150,
                    ),
                    const LoginPageForm(),
                    const SizedBox(
                      height: 30,
                    ),
                    const SelectableText(
                      "Forgot Password?",
                      onTap: null,
                    ),
                    const Divider(
                      height: 20,
                      endIndent: 100,
                      indent: 100,
                      color: MyColor.blackFont,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return MyColor.greenButton;
                            }

                            return null; // Defer to the widget's default.
                          },
                        ),
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: MyColor.blackFont,
                        ),
                      ),
                      onPressed: null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///
/// Login Page Form Statefull Class for Login Screen
///
class LoginPageForm extends StatefulWidget {
  const LoginPageForm({Key? key}) : super(key: key);

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _loginFormKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _user, _password;
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _userController,
              onChanged: (val) {
                _user = val;
              },
              decoration: const InputDecoration(
                hintText: 'User name or Email or Phone',
                labelText: 'User name or Email or Phone',
              ),
            ),
            TextFormField(
              controller: _passwordController,
              onChanged: (val) {
                _password = val;
              },
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return MyColor.blueButton;
                    }

                    return null; // Defer to the widget's default.
                  },
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: MyColor.blackFont,
                ),
              ),
              onPressed: onLogin,
            ),
          ],
        ),
      ),
    );
  }

  void onLogin() {}
}
