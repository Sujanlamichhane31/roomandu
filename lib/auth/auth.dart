//import 'package:firebase_auth/firebase_auth.dart';
//
//import 'package:roomandu/model/userModel.dart';
//class Auth {
//  FirebaseAuth _auth = FirebaseAuth.instance;
//
////  Stream<AuthModel> get user {
////    // ignore: deprecated_member_use
////    return _auth.onAuthStateChanged.map(
////            (FirebaseUser firebaseUser) =>
////        (firebaseUser != null)
////            ? AuthModel.fromFirebaseUser(user: firebaseUser)
////            : null,);
////  }
//
//Future<String> signupUser(
//    String email, String password, String fullName) async{
//  String retVal = "error";
//  try{
//    UserCredential _authResult= await _auth.createUserWithEmailAndPassword(
//        email: email.trim(), password: password);
//    UserModel _user= UserModel(
//    uid: _authResult.user.uid,
//      email: _authResult.user.email,
//      fullName: fullName.trim(),
//
//    );
//  }
//}
//}
