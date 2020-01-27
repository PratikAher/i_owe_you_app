import 'package:flutter/material.dart';
import 'package:iou/services/auth.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:iou/shared/constants.dart';
import 'package:iou/shared/loading.dart';

const key = Key("NetworkDialog");

class SignIn extends StatefulWidget {
  //
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  // text field state
  String email = '';
  String password = '';
  bool loading = false;
  //
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('SignIn to IOU'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration,
                  validator: (val) => val.length < 6
                      ? 'Enter an Password at least of 6 char'
                      : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        showDialog(
                          context: context,
                          builder: (_) => NetworkGiffyDialog(
                            key: key,
                            image: Image.network(
                              "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
                              fit: BoxFit.cover,
                            ),
                            entryAnimation: EntryAnimation.BOTTOM,
                            title: Text(
                              'Error',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.w600),
                            ),
                            description: Text(
                              'Please Supply Valid Details.',
                              textAlign: TextAlign.center,
                            ),
                            onlyCancelButton: true,
                            buttonCancelColor: Colors.green,
                          ),
                        );
                      }
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                ),
                SizedBox(height: 10.0),
                Text("Don't have an account"),
                SizedBox(height: 10.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
