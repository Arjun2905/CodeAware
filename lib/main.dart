import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:code_aware/view/screens/auth_screens/onBoarding.dart';
import 'package:code_aware/view/screens/in_app_screens/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:code_aware/controller/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:code_aware/model/notification/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyCodeAware());
}

class MyCodeAware extends StatefulWidget {
  const MyCodeAware({Key? key}) : super(key: key);
  @override
  CodeAware createState() => CodeAware();
}

class CodeAware extends State<MyCodeAware> {
  late StreamSubscription<User?> user;

  @override
  void initState() {
    NotificationService().initialize();
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print("user is currently signed out");
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
          builder: (context, ThemeModel themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
          home: AnimatedSplashScreen(
            duration: 5000,
            splashIconSize: 150,
            splash: Image.asset("assets/images/logo.png"),
            nextScreen: _getNextScreen(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
          ),
        );
      }),
    );
  }
}

Widget _getNextScreen() {
  if (FirebaseAuth.instance.currentUser == null) {
    return const OnBoardingScreen();
  }
  return const HomeScreen();
}
