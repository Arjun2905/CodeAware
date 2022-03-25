import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:code_aware/view/screens/auth_screens/login.dart';
import 'package:code_aware/view/screens/auth_screens/onBoarding.dart';
import 'package:code_aware/view/screens/auth_screens/signup.dart';
import 'package:code_aware/view/screens/in_app_screens/home.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyCodeAware());
}

class MyCodeAware extends StatefulWidget{
  const MyCodeAware({Key? key}) : super(key: key);
// This widget is the root of your application.
  @override
  CodeAware createState() => CodeAware();
}

class CodeAware extends State<MyCodeAware> {
  late StreamSubscription<User?> user;

  @override
  void initState(){
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if(user==null){
        print("user is currently signed out");
      }else{
        print('User is signed in!');
      }
    });
  }

  @override
  void dispose(){
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          duration: 5000,
          splashIconSize: 150,
          splash: Image.asset("assets/images/logo.png"),
          nextScreen: _getNextScreen(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: Colors.white
      ),
    );
  }

  Widget _getNextScreen(){
    if(FirebaseAuth.instance.currentUser==null){
      return const OnBoardingScreen();
    }
    return const OnBoardingScreen();
  }
}
