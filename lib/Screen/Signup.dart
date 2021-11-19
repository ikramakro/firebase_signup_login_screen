import 'package:flutter/material.dart';
import 'package:untitled/widget/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool showspiner = false;
  TextEditingController emailcontroler = TextEditingController();

  TextEditingController passwordcontroler = TextEditingController();

  String email = '', password = '';
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspiner,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sign up',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailcontroler,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your Email ',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      email = value;
                    },
                    validator: (value) {
                      return value!.isEmpty ? 'Enter valid email' : null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordcontroler,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      password = value;
                    },
                    validator: (value) {
                      return value!.isEmpty ? 'enter your password' : null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Mybutton(
                title: 'Register',
                width: double.infinity,
                height: 50,
                onpress: () async {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      showspiner = true;
                    });
                    try {
                      final user = await _auth.createUserWithEmailAndPassword(
                          email: email.toString().trim(),
                          password: password.toString().trim());
                      if (user != null) {
                        print('sucess');
                        toastMasseges('user sucessfully created');
                        setState(() {
                          showspiner = false;
                        });
                      }
                    } catch (e) {
                      print(e.toString());
                      toastMasseges(e.toString());
                      setState(() {
                        showspiner = true;
                      });
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void toastMasseges(String masseg) {
    Fluttertoast.showToast(
        msg: masseg.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
