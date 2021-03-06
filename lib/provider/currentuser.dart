import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CurrentUser extends ChangeNotifier{
  String _uid;
  String _email;

    String get getUid => _uid;
    
    String get getEmail => _email;
    
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUpUser(String email, String password) async{
    bool retval= false;

    try{
      UserCredential authresult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    
      if(authresult.user != null){
        retval=true;
      }
    }catch(e){
    print(e);
    }
    return retval;

  }

  Future<bool> loginUser(String email, String password) async{
    bool retval= false;
  
    try{
      UserCredential authresult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    
      if(authresult.user != null){
        _uid =  authresult.user.uid;
        _email = authresult.user.email;
        retval=true;
      }
    }catch(e){
      print(e);
    }
    return retval;

  }
}