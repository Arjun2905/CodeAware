import 'package:code_aware/view/screens/auth_screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:code_aware/view/widgets/custom_button.dart';
import 'package:code_aware/view/widgets/custom_textform.dart';
import 'package:code_aware/controller/validators.dart';
import 'package:code_aware/model/authentication/authentication_services.dart';
import 'package:code_aware/view/screens/in_app_screens/home.dart';
import 'package:code_aware/controller/theme_model.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);
  static String routeName = 'login-page';

  @override
  State<LogInScreen> createState() => MyLogInScreen();
}

class MyLogInScreen extends State<LogInScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  String email = "";
  String password = "";

  Widget _loginUi() {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
          builder: (context, ThemeModel themeNotifier, child) {
        return Column(
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 200,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'CodeAware',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: themeNotifier.isDark
                      ? Color.fromARGB(255, 11, 135, 147)
                      : Color.fromARGB(255, 45, 28, 71),
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Login To Your Account',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeNotifier.isDark
                      ? Color.fromARGB(255, 11, 135, 147)
                      : Color.fromARGB(255, 45, 28, 71),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextForm(
              prefixIcon: const Icon(Icons.email),
              controller: emailController,
              label: 'Email',
              hintText: 'example@gmail.com',
              color: Colors.white,
              validator: (value) => Validator.validateEmail(email: value),
              obscuretext: false,
              textInputAction: TextInputType.emailAddress,
              onSaved: (value) {
                email = value!;
              },
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextForm(
              prefixIcon: const Icon(Icons.password),
              controller: passwordController,
              label: 'Password',
              hintText: '***',
              color: Colors.white,
              validator: (value) => Validator.validatePassword(password: value),
              obscuretext: true,
              textInputAction: TextInputType.text,
              onSaved: (value) {
                password = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
                label: "Sign in",
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    User? user = await AuthenticationServices.signInUsingEmail(
                        email: emailController.text,
                        password: passwordController.text);
                    if (user != null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    }
                  }
                },
                color: const Color.fromARGB(255, 45, 28, 71)),
            Row(
              children: <Widget>[
                TextButton(
                  child: Text(
                    'Sign up',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        color: themeNotifier.isDark
                            ? Color.fromARGB(255, 11, 135, 147)
                            : Color.fromARGB(255, 45, 28, 71)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SignUpScreen()));
                  },
                ),
                const Spacer(),
                TextButton(
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 16,
                      color: themeNotifier.isDark
                          ? Color.fromARGB(255, 11, 135, 147)
                          : Color.fromARGB(255, 45, 28, 71),
                    ),
                  ),
                  onPressed: () {
                    //signup screen
                    forgotSection();
                    print("Text : " + textEditingController.text);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Column(children: <Widget>[
              Row(
                children: const <Widget>[Text(" ")],
              ),
              Row(children: <Widget>[
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Divider(
                        color:
                            themeNotifier.isDark ? Colors.white : Colors.black,
                        height: 36,
                      )),
                ),
                const Text("OR"),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Divider(
                        color:
                            themeNotifier.isDark ? Colors.white : Colors.black,
                        height: 36,
                      )),
                ),
              ]),
              Row(
                children: const <Widget>[Text(" ")],
              ),
            ]),
            const SizedBox(
              height: 3,
            ),
            InkWell(
              onTap: () async {
                await AuthenticationServices.signInWithGoogle();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
              child: Ink(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset('assets/icons/googleIcon.png'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Future forgotSection() {
    return showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Email"),
            actionsAlignment: MainAxisAlignment.end,
            content: CustomTextForm(
                prefixIcon: const Icon(Icons.alternate_email_outlined),
                color: Colors.black,
                label: "Email",
                hintText: "abc@gmail.com",
                obscuretext: false,
                controller: textEditingController,
                textInputAction: TextInputType.text),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Email sent..."),
                      ));
                      AuthenticationServices.resetPassword(
                          textEditingController.text);
                    });
                  },
                  child: const Text("Send Email"))
            ],
          );
        },
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: const Color.fromARGB(179, 235, 228, 248),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Form(
              key: _key,
              autovalidateMode: AutovalidateMode.disabled,
              child: _loginUi()),
        ),
      ),
    );
  }
}
