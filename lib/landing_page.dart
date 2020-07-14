import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'main.dart';
import 'package:flutterspiderg/model/globle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterspiderg/main.dart';

class landing_page extends StatefulWidget {
  @override
  _landing_pageState createState() => _landing_pageState();
}

class _landing_pageState extends State<landing_page> {
  @override
  final GoogleSignIn googelsignin = GoogleSignIn();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('spider g'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('hey man youre on landing page'),
              RaisedButton(
                child: Text('sign oout'),
                onPressed: () {
                  googlesignout();

                },
              )
            ],
          ),
        ),
      ),
    );
  }

  googlesignout() async {
    try {
      await googelsignin.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
      toast('sign out sucessfuly');
    } catch (e) {
      toast(e.toString());
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
