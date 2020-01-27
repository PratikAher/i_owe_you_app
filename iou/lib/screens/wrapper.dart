import 'package:flutter/material.dart';
import 'package:iou/screens/authenticate/authenticate.dart';
import 'package:iou/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:iou/modles/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //accessing userdata from provider
    final user = Provider.of<User>(context);
    print(user);
    //return either Home or Auth
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
