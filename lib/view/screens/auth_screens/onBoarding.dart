import 'package:code_aware/view/screens/auth_screens/login.dart';
import 'package:code_aware/view/screens/auth_screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget{
  const OnBoardingScreen({Key? key}) : super(key: key);

  PageDecoration decoratePages() => PageDecoration(
    titleTextStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    bodyTextStyle: const TextStyle(fontSize: 20),
    bodyPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
    imagePadding: const EdgeInsets.only(bottom: 0),
    imageFlex: 2,
    pageColor: const Color.fromARGB(255, 255, 255, 255),
  );

  DotsDecorator decorateDots() => DotsDecorator(
    color: const Color(0xFFBDBDBD),
    activeColor: Colors.blue,
    size: const Size(10, 10),
    activeSize: const Size(22, 10),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );

  @override
  Widget build(BuildContext context) => SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Welcome to CodeAware",
            body: "Click on next to take a tour",
            image: Center(
              child :Container(
                width: MediaQuery.of(context).size.width*0.95,
                height: MediaQuery.of(context).size.height*0.42,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [BoxShadow(
                    color: Colors.indigo,
                    blurRadius: 25,
                    blurStyle: BlurStyle.outer
                  )]
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Image.asset("assets/Onboarding_Screens/welcome.png",
                  width:MediaQuery.of(context).size.width,fit: BoxFit.cover,),
              )
            ),
            decoration: decoratePages(),
          ),
          PageViewModel(
            title: "Welcome to CodeAware",
            body: "Click on next to take a tour",
            image: Center(
              child :Container(
                width: MediaQuery.of(context).size.width*0.95,
                height: MediaQuery.of(context).size.height*0.42,
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [BoxShadow(
                        color: Colors.indigo,
                        blurRadius: 25,
                        blurStyle: BlurStyle.outer
                    )]
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Image.asset("assets/Onboarding_Screens/access_data.png",
                width:MediaQuery.of(context).size.width,fit: BoxFit.cover,),
              ),
            ),
            decoration: decoratePages(),
          ),
          PageViewModel(
            title: "Welcome to CodeAware",
            body: "Click on next to take a tour",
            image: Center(
              child :Container(
                width: MediaQuery.of(context).size.width*0.95,
                height: MediaQuery.of(context).size.height*0.42,
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [BoxShadow(
                        color: Colors.indigo,
                        blurRadius: 25,
                        blurStyle: BlurStyle.outer
                    )]
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Image.asset("assets/Onboarding_Screens/ratings.png",
                  width:MediaQuery.of(context).size.width,fit: BoxFit.cover,),
              ),
            ),
            decoration: decoratePages(),
          ),
          PageViewModel(
            title: "Welcome to CodeAware",
            body: "Click on next to take a tour",
            image: Center(
              child :Container(
                width: MediaQuery.of(context).size.width*0.95,
                height: MediaQuery.of(context).size.height*0.42,
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [BoxShadow(
                        color: Colors.indigo,
                        blurRadius: 25,
                        blurStyle: BlurStyle.outer
                    )]
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Image.asset("assets/Onboarding_Screens/switches.png",
                  width:MediaQuery.of(context).size.width,fit: BoxFit.cover,),
              ),
            ),
            decoration: decoratePages(),
          ),
          PageViewModel(
            title: "Welcome to CodeAware",
            body: "Click on next to take a tour",
            image: Center(
              child :Container(
                  width: MediaQuery.of(context).size.width*0.95,
                  height: MediaQuery.of(context).size.height*0.42,
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [BoxShadow(
                          color: Colors.indigo,
                          blurRadius: 25,
                          blurStyle: BlurStyle.outer
                      )]
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Image.asset("assets/Onboarding_Screens/use_smartphones.png",
                  width:MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,)
              ),
            ),
            decoration: decoratePages(),
          )
        ],
        done: const Text("Signup"),
        onDone: (){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context)=>const SignUpScreen())
          );
        },
        showBackButton: true,
        back: const Icon(Icons.arrow_back),
        next: const Icon(Icons.arrow_forward),
        dotsDecorator: decorateDots(),
        controlsPadding: const EdgeInsets.all(2),
        freeze: true,
        dotsFlex: 2,
      )
  );
}