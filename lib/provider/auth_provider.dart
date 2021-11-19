import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class authprovider extends ChangeNotifier {
  File? image;
  String pickererror = '';
  bool ispicAvail = false;
  String error = '';
  String email = '';

  Future<File?> getImage() async {
    final tempFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 15);
    if (tempFile != null) {
      this.image = File(tempFile.path);
    } else {
      this.pickererror = 'NO Image Selected';
      print('no image');
      notifyListeners();
    }
    return this.image;
  }

  Future<UserCredential?> register(email, password) async {
    this.email = email;
    notifyListeners();
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak password") {
        this.error = '';
        print('');
        notifyListeners();
      } else if (e.code == 'email already in use') {
        this.error = 'the account already ';
        notifyListeners();
        print('the account already');
      }
    } catch (e) {
      this.error = e.toString();
      notifyListeners();
      print(e);
    }
    return userCredential;
  }
}
