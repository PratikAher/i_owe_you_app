import 'package:flutter/material.dart';
import 'package:iou/modles/user.dart';
import 'package:iou/screens/wrapper.dart';
import 'package:iou/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //the root
    return StreamProvider<User>.value(
      value: AuthService().userChangeListner,
      child: MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
