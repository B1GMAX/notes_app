import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();

  final _isSignUpController = BehaviorSubject<bool>();

  Stream<bool> get isSignUpStream => _isSignUpController.stream;

  Sink<bool> get isSignUpSink => _isSignUpController.sink;

  Future<bool> logIn() async {
    try {
      final newUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (newUser.user != null) {
        FirebaseFirestore.instance.collection('users').doc(newUser.user!.uid);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      e.code == 'email-already-in-use'
          ? Fluttertoast.showToast(
              msg: "This email is already in use",
            )
          : Fluttertoast.showToast(
              msg: "Something went wrong",
            );
    }
    return false;
  }

  Future<bool> signUp() async {
    try {
      final signedUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (signedUser.user != null) {
        return true;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Registration error",
      );
    }
    return false;
  }

  void dispose() {
    emailTextController.dispose();
    passwordController.dispose();
    _isSignUpController.close();
  }
}
