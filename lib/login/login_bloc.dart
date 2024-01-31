import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();

  final  _isSignUpController = BehaviorSubject<bool>();

  Stream<bool> get isSignUpStream => _isSignUpController.stream;

  void changeRegisterType(bool type){
    _isSignUpController.add(type);
  }

  void logIn() async {
     try{
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: emailTextController.text.trim(),
         password: passwordController.text.trim(),
       );
     } catch (e, s){
       print('logIn error - $s');
     }
  }

  void signIn() async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e, s){
      print('signIn error - $s');
    }
  }

  void dispose() {}
}
