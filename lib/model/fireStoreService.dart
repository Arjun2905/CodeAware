import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_aware/model/User/user.dart';

class FireStoreServices{
  final CollectionReference _usersCollectionReference =
        FirebaseFirestore.instance.collection("users");

  Future createUser(Users user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    }catch(e){
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return Users.fromData(userData.data() as Map<String,dynamic>);
    }catch (e){
      return e.toString();
    }
  }
}