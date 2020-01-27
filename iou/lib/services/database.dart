import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('user');

  Future createUserData(String name, String phone, String photoUrl) async {
    return await userCollection.document(uid).setData({
      "name": name,
      "phone": phone,
      "photoUrl": photoUrl,
    });
  }
}

// final String uid;
// DatabaseService({this.uid});

// //collection refe
// final CollectionReference userCollection =
//     Firestore.instance.collection("users");

// Future createUserData(String name, String phone, String photoUrl) async {
//   return await userCollection.document(uid).setData({
//     "name": name,
//     "phone": phone,
//     "photoUrl": photoUrl,
//   });
// }

// Future addPpl() async {
//   print(uid);
//   return await userCollection.document(uid).collection("ppls").add({
//     'name': "ppl name",
//     'phone': "ppl phoneNo",
//   });
// }

// //get ppl stream
// Stream<QuerySnapshot> ppl(String uid) {
//   return userCollection.document(uid).collection("ppls").snapshots();
// }

// Future addTransactions() async {
//   List borrow = [];
//   List lend = [];
//   return await userCollection
//       .document(uid)
//       .collection("ppls")
//       .document()
//       .collection("transactions")
//       .add({
//     "borrow": borrow,
//     "lend": lend,
//   });
// }

// //
// final String uid;
// DatabaseService({this.uid});

// //collection refe
// final CollectionReference userCollection =
//     Firestore.instance.collection("users");

// Future createUserData(String name, String phone, String photoUrl) async {
//   return await userCollection.document(uid).setData({
//     "name": name,
//     "phone": phone,
//     "photoUrl": photoUrl,
//   });
// }

// Future addPpl() async {
//   print(uid);
//   String n = "pratrik";
//   String p = "1234";
//   return await userCollection
//       .document(uid)
//       .collection("ppls")
//       .document()
//       .setData({
//     "name": n,
//     "phone": p,
//   });
// }

// Future addTransactions() async {
//   List borrow = [];
//   List lend = [];
//   return await userCollection
//       .document(uid)
//       .collection("ppls")
//       .document()
//       .collection("transactions")
//       .document()
//       .setData({
//     "borrow": borrow,
//     "lend": lend,
//   });
// }
