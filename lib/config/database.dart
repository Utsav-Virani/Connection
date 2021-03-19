import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  getUseByUserName(String _userName) async{
    return await FirebaseFirestore.instance
        .collection("UserData")
        .where("name", isEqualTo: _userName).get();
  }

  uploadUserInfo(userData) {
    FirebaseFirestore.instance.collection("UserData").add(userData);
  }
}
