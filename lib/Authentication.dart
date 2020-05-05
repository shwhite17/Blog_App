import 'package:flutter/material.dart';
import 'package:flutter_blog_app/Authentication.dart';

abstract class AuthImplementation
{

Future<String> SignIn(String email, String password);
Future<String> SignUp(String email, String password);
  Future<String> getCurrentUser();

  Future<void> signOut()
}

class Auth implements AuthImplementation {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> SignIn(String email , String password) async
  {
    FirebaseUser user = await _firebaseAuth.signInwithEmailAndPassword(email: email, password: password);
    return user.uid;
  }
  Future<String> SignUp(String email , String password) async
  {
    FirebaseUser user = await _firebaseAuth.signUpwithEmailAndPassword(email: email, password: password);
    return user.uid;
  }
  Future<String> getCurrentUser() async
  {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
}

Future<void> signOut() async
{
  _firebaseAuth.signOut();
}

}

