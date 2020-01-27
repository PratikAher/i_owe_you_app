import 'package:flutter/material.dart';
import 'package:iou/services/auth.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:iou/shared/constants.dart';
import 'package:iou/shared/loading.dart';

// const List<Key> keys = [
//   Key("Network"),
//   Key("NetworkDialog"),
//   Key("Flare"),
//   Key("FlareDialog"),
//   Key("Asset"),
//   Key("AssetDialog")
// ];

const key = Key("NetworkDialog");

class Register extends StatefulWidget {
  //
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  // text field state
  String email = '';
  String password = '';
  bool loading = false;
  //
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('SignUp to IOY'),
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
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
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
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
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
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600),
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
                          }),
                      SizedBox(height: 10.0),
                      Text("Registered User"),
                      SizedBox(height: 10.0),
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Sign In',
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
