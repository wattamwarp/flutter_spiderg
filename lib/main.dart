import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterspiderg/landing_page.dart';
import 'package:flutterspiderg/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutterspiderg/model/globle.dart';



//social media mini buttons
import 'package:flutter_signin_button/flutter_signin_button.dart';

//facebook signin package
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

void main() => runApp(new MaterialApp(
      title: "Todo App",
      home: MyApp(),
    ));

final FirebaseAuth mauth = FirebaseAuth.instance;

final GoogleSignIn googelsignin = GoogleSignIn();

final FacebookLogin facebookSignIn = new FacebookLogin();

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
      backgroundColor: darkGreyColor,
      body: SafeArea(
        child: Container(
          color: darkGreyColor,
          margin: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 100),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Welcome!", style: bigLightBlueTitle),
                Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Theme(
                        data: Theme.of(context)
                            .copyWith(splashColor: Colors.transparent),
                        child: TextField(
                          controller: emailcontroller,
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
                          controller: passcontroller,
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
                      FlatButton(
                        child: Text(
                          "Sign in",
                          style: redTodoTitle,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () {
                          signinmethod();
                        },
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.10),
                      child: ClipOval(
                        child: SignInButton(
                          Buttons.GoogleDark,
                          mini: true,
                          onPressed: () {
                            google_signinmethod();
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      child: ClipOval(
                        child: SignInButton(
                          Buttons.Facebook,
                          mini: true,
                          onPressed: () {
                            facebooksignin();
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.10),
                      child: ClipOval(
                        child: SignInButton(
                          Buttons.Twitter,
                          mini: true,
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Don't you even have an account yet?!",
                        style: redText,
                        textAlign: TextAlign.center,
                      ),
                      FlatButton(
                        child: Text("create one", style: redBoldText),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signup()));
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  googlesignout() async {
    try {
      await googelsignin.signOut();
      toast('sign out sucessfuly');
    } catch (e) {
      toast(e.toString());
    }
  }

  signinmethod() async {
    var user;

    try {
      user = await mauth.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: passcontroller.text);
      FirebaseUser fbuser;

      //await fbuser.sendEmailVerification();
//      try {
//        await fbuser.sendEmailVerification();
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

  //final GoogleSignIn googelsignin = new GoogleSignIn();

  google_signinmethod() async {
    var user;
    final GoogleSignInAccount googlesigninacc = await googelsignin.signIn();
    final GoogleSignInAuthentication googleauth =
        await googlesigninacc.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleauth.accessToken,
      idToken: googleauth.idToken,
    );
    //final FirebaseUser

    try {
      user = await mauth.signInWithCredential(credential);
      // toast("user is signed in");
      print("signed in ");
    } catch (e) {
      print(e.toString());
    }

    if (user != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => landing_page()));
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

  facebooksignin() async {

//    final FacebookLoginResult result =
//        await facebookSignIn.logIn(['email']);
//
//    switch (result.status) {
//      case FacebookLoginStatus.loggedIn:
//        final FacebookAccessToken accessToken = result.accessToken;
//        toast('signin sucessfully');
//        break;
//      case FacebookLoginStatus.cancelledByUser:
//        toast('Login cancelled by the user.');
//        break;
//      case FacebookLoginStatus.error:
//        toast('Something went wrong with the login process.\n'
//            'Here\'s the error Facebook gave us: ${result.errorMessage}');
//        break;
//    }

    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);

      if(result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,

        );
        final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print('signed in ' + user.displayName);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => landing_page()));
        return user;
      }
    }catch (e) {
      print(e.message);
    }

  }//end of fb signin method
}
