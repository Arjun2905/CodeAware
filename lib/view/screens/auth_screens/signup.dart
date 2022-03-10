import 'package:code_aware/view/screens/auth_screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:code_aware/view/widgets/custom_button.dart';
import 'package:code_aware/view/widgets/custom_textform.dart';
import 'package:code_aware/controller/validators.dart';
import 'package:code_aware/model/authentication/signin_with_google.dart';
import 'package:code_aware/model/authentication/signup_using_email.dart';
import 'package:code_aware/view/screens/in_app_screens/home.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({Key? key}) : super(key: key);
  static String routeName = 'signup-page';

  @override
  State<SignUpScreen> createState() => MySignUpScreen();
}

class MySignUpScreen extends State<SignUpScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  String email = "";
  String password = "";
  String confirmPassword = "";
  String firstName = "";
  String lastName = "";

  Widget _signupUi(){
    return Column(
      children:  <Widget>[
        Align(
          alignment: Alignment.topRight,
          child: Image.asset('assets/images/logo.png',width: 150),
        ),
        // Image.asset('assets/images/logo.png',width: 125),
        const SizedBox(
          height: 5,
        ),

        const Align(
          alignment: Alignment.bottomLeft,
          child:Text(
            'Create Account',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 45, 28, 71),
            ),
          ),
        ),

        const SizedBox(
          height: 12,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  <Widget>[
            Flexible(
              child: CustomTextForm(prefixIcon: const Icon(Icons.account_box_rounded),
                controller: firstNameController,
                label: 'First name',
                hintText: 'Jhon',
                color: Colors.white,
                validator: (value) => Validator.validateName(name:value),
                obscuretext: false,
                textInputAction : TextInputType.emailAddress,
                onSaved: (value) {firstName=value!;},
              ),
            ),
            const SizedBox(width: 20.0,),
            Flexible(
              child: CustomTextForm(prefixIcon: const Icon(Icons.account_box_rounded),
                controller: lastNameController,
                label: 'Last name',
                hintText: 'Dacosta',
                color: Colors.white,
                obscuretext: false,
                textInputAction : TextInputType.emailAddress,
                onSaved: (value) {lastName=value!;},
            ),
            ),
          ],
        ),

        const SizedBox(
          height: 5,
        ),

        CustomTextForm(prefixIcon: const Icon(Icons.email),
          controller: emailController,
          label: 'Email',
          hintText: 'example@gmail.com',
          color: Colors.white,
          validator: (value) => Validator.validateEmail(email:value),
          obscuretext: false,
          textInputAction : TextInputType.emailAddress,
          onSaved: (value) {email=value!;},
        ),

        const SizedBox(
          height: 5,
        ),

        CustomTextForm(prefixIcon: const Icon(Icons.password),
          controller: passwordController,
          label: 'Password',
          hintText: '***',
          color: Colors.white,
          validator: (value) => Validator.validatePassword(password: value),
          obscuretext: true,
          textInputAction: TextInputType.text,
          onSaved: (value) {password = value!;},),

        const SizedBox(
          height: 5,
        ),

        CustomTextForm(prefixIcon: const Icon(Icons.password),
          controller: confirmPasswordController,
          label: 'Confirm Password',
          hintText: '***',
          color: Colors.white,
          validator: (value) => Validator.validateConfirmPassword(password: passwordController.text, confirmPassword: value),
          obscuretext: true,
          textInputAction: TextInputType.text,
          onSaved: (value) {confirmPassword = value!;},),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            style: TextButton.styleFrom(
              primary: const Color.fromARGB(255, 45, 28, 71)
            ),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const LogInScreen()));
            },
            child: const Text("Already have?"),
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        CustomButton(
            label: "Create Account",
            onPressed: () async {
              if(_key.currentState!.validate()){
                User? user = await SignupUsingEmail.signUpUsingEmail(
                    firstName: firstNameController.text,
                    lastname: lastNameController.text,
                    email: emailController.text,
                    password: passwordController.text);
                if(user!=null){
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context)=>const HomeScreen())
                  );
                }
              }
            },
            color: const Color.fromARGB(255, 45, 28, 71)),

        const SizedBox(
          height: 10,
        ),

        Column(children: <Widget>[
          Row(
            children: const <Widget>[Text(" ")],
          ),
          Row(children: <Widget>[
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                  child: const Divider(
                    color: Colors.black,
                    height: 36,
                  )),
            ),
            const Text("OR"),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: const Divider(
                    color: Colors.black,
                    height: 36,
                  )
              ),
            ),
          ]),
          Row(
            children: const <Widget>[Text(" ")],
          ),
        ]),

        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () async {
            await SignInWithGoogle.signInWithGoogle();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context)=>const HomeScreen())
            );
          },
          child: Ink(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Image.asset('assets/icons/googleicon.png'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
          children:  <Widget>[
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20.0),
                child: Form(
                    key: _key,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: _signupUi()),
              ),
            ),
          ]
      ),
    );
  }
}