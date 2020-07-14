import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterspiderg/landing_page.dart';
import 'main.dart';
import 'package:flutterspiderg/model/globle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  TextEditingController usernameText = new TextEditingController();
  TextEditingController passwordText = new TextEditingController();
  TextEditingController cpasswordText = new TextEditingController();

  var a;
  var lst = new List();

  //double h = 300, n = 100;
  var userid;
  final FirebaseAuth mauth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Container(
          color: darkGreyColor,
          child: Container(
            color: darkGreyColor,
            margin: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 10),
            child: Material(
              color: darkGreyColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Welcome!", style: bigLightBlueTitle),
                  Container(
                    padding: EdgeInsets.only(top: 0),
                    height: 300,
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextField(
                              controller: usernameText,
                              autofocus: false,
                              style:
                              TextStyle(fontSize: 22.0, color: darkGreyColor),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Username',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                              ),
                            ),
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextField(
                              controller: passwordText,
                              autofocus: false,
                              style:
                              TextStyle(fontSize: 22.0, color: darkGreyColor),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Password',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                              ),
                            ),
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextField(
                              controller: cpasswordText,
                              autofocus: false,
                              style:
                              TextStyle(fontSize: 22.0, color: darkGreyColor),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Confirm Password',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                              ),
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              "Sign Up",
                              style: redTodoTitle,
                            ),
                            onPressed: () {
                              signupmethod();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Already have an account? Sign in Here !",
                          style: redText,
                          textAlign: TextAlign.center,
                        ),
                        FlatButton(
                          child: Text("Sign In", style: redBoldText),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  signupmethod() async {
    if (passwordText.text == cpasswordText.text)
    {
      var user;
      try {
        user = await mauth.createUserWithEmailAndPassword(
            email: usernameText.text, password: cpasswordText.text);

        upload_rawdata();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => landing_page()));
        Fluttertoast.showToast(
          msg: "Logged In sucessfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } catch (error) {
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
    }
  }//end of signup method

  String toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  upload_rawdata(){

    getCurrentUser();
    Map<String, String> map = <String, String>{"name": "null", "notes": "null"};
    Firestore.instance
        .collection('testing')
        .document('user_data')
        .collection(userid)
        .document(a.toString())
        .setData(map).whenComplete((){
      print("uploded raw data");
    }).catchError((e) => print(e));
  }

  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    userid = uid;
    print("the uid is $uid");
    return uid;
  }



}
