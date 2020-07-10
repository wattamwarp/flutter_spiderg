import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(new MaterialApp(
      title: "Todo App",
      home: MyApp(),
    ));

final FirebaseAuth mauth = FirebaseAuth.instance;

final GoogleSignIn _googleSignIn = GoogleSignIn();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('spiderg task'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: emailcontroller,
              ),
              TextField(
                controller: passcontroller,
              ),
              RaisedButton(
                child: Text('SignIn'),
                color: Colors.blue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                onPressed: () {
                  signinmethod();
                },
              ),
              RaisedButton(
                child: Text('Google SignIn'),
                color: Colors.blue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                onPressed: () {
                  google_signinmethod();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  signinmethod() async {
    var user;

    try {
      user = await mauth.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: passcontroller.text);
      FirebaseUser fbuser;

//      //await fbuser.sendEmailVerification();
//      try {
//        //await fbuser.sendEmailVerification();
//        //return fbuser.uid;
//      } catch (e) {
//        print("An error occured while trying to send email  verification");
//        print(e.message);
//        print(e.toString());
//      }

      toast("signup sucessfull");
    } catch (error) {
      //toast(error.toString());

      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          toast("Your email address appears to be malformed.");
          break;
        case "ERROR_WRONG_PASSWORD":
          toast("Your password is wrong.");
          break;
        case "ERROR_USER_NOT_FOUND":
          toast("User with this email doesn't exist.");
          break;
        case "ERROR_USER_DISABLED":
          toast("User with this email has been disabled.");
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          toast("Too many requests. Try again later.");
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          toast("Signing in with Email and Password is not enabled.");
          break;
        default:
          toast("An undefined Error happened.");
      }
    }
    // return user.uid;
  } //end of signup method

  final GoogleSignIn googelsignin = new GoogleSignIn();

  google_signinmethod() async {
    var user;
    final GoogleSignInAccount googlesigninacc = await googelsignin.signIn();
    final GoogleSignInAuthentication googleauth =
        await googlesigninacc.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(accessToken: googleauth.accessToken, idToken: googleauth.idToken, );
    //final FirebaseUser

    try {
//      user = (await mauth.signInWithGoogle(
//          email: googleauth.idToken, password: googleauth.accessToken));
      user = await mauth.signInWithCredential(credential);
      toast("user is signed in");
      print("signed in ");
    } catch (e) {
      print(e.toString());
    }

    if (user != null) {
      toast("user is signed in");
    } else {
      toast("signin failed");
    }
  }

  String toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
