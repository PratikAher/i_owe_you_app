import 'package:firebase_auth/firebase_auth.dart';
import 'package:iou/modles/user.dart';
import 'package:iou/services/database.dart';

class AuthService {
  //
  //before using firebase auth we have to create it's instance
  //    <dataType> <instanceVariable> = <getingTheInstance>
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //FU-->OU Function
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //stream to listen auth change
  Stream<User> get userChangeListner {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in anous
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      //FU-->OU call
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //creating doc for current user with the Uid
      await DatabaseService(uid: user.uid)
          .createUserData("App owner", "1243", 'null');
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //logout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
