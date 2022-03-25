import 'package:code_aware/model/User/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:code_aware/model/fireStoreService.dart';

class AuthenticationServices{
  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? account = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await account
        ?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<User?> signUpUsingEmail({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      user = userCredential.user;
      await user!.sendEmailVerification();
      await FireStoreServices().createUser(Users(id: user.uid, firstName: firstName, lastName: lastName, email: email));
      user = auth.currentUser;
    } on FirebaseAuthException catch(e){
      if(e.code=='weak-password'){
        print('weak password');
      }else if(e.code=='email-already-in-use'){
        print('Account already exist from this email.');
      }
    }catch(e){
      print(e);
    }
    return user;
  }

  static Future<User?> signInUsingEmail({
    required String email,
    required String password
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if(e.code=='user-not-found'){
        print("No account exist by this email.");
      }else if(e.code=="wrong-password"){
        print("wrong password");
      }
    }
    return user;
  }
}