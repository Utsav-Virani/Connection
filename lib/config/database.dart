import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  getUseByUserName(String _userName) async {
    return await FirebaseFirestore.instance
        .collection("UserData")
        .where("name", isEqualTo: _userName)
        .get();
  }

  getUserNameByUserEmail(String _userEmail) async {
    return await FirebaseFirestore.instance
        .collection("UserData")
        .where("email", isEqualTo: _userEmail)
        .get();
  }

  uploadUserInfo(userData, userId) {
    FirebaseFirestore.instance.collection("UserData").doc(userId).set(userData);
  }

  addChatRoom(_chatRoomId, _chatRoom) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(_chatRoomId)
        .set(_chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  setConversionMessages(String _chatRoomId, _messageMap) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(_chatRoomId)
        .collection("Chats")
        .add(_messageMap)
        .catchError((onError) {
      print(onError.toString());
    });
  }

  getConversionMessages(String _chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(_chatRoomId)
        .collection("Chats")
        .orderBy("time", descending: true)
        .snapshots();
  }

  getChatRooms(String _userName) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .where("users", arrayContains: _userName)
        .snapshots();
  }
}
