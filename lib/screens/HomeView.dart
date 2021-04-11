import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connection/config/database.dart';
import 'package:connection/data/Colors/colorpanel.dart';
import 'package:connection/data/dataCollection.dart';
import 'package:connection/data/userData.dart';
import 'package:connection/screens/ChatRoom.dart';
import 'package:connection/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connection/screens/SearchScreen.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

String _myUserName = "";
Stream _availableChatRoomsStream;

class _HomeViewState extends State<HomeView> {
  DataBaseMethods _dataBaseMethods = new DataBaseMethods();

  String _userName;

  @override
  void initState() {
    getUserInfo();
    // print("asd");
    // print(_myUserName);
    FirebaseAuth _auth = FirebaseAuth.instance;
    _dataBaseMethods.getChatRooms(_auth.currentUser.uid).then((value) {
      print("---");
      print(value);
      setState(() {
        _availableChatRoomsStream = value;
      });
    });

    super.initState();
  }

  _getUserName(userId) async {
    FirebaseFirestore.instance
        .collection("UserData")
        .doc(userId)
        .get()
        .then((value) {
      _userName = value.data()['name'];
      setState(() {});
    });
  }

  Widget ChatRoomList() {
    return StreamBuilder(
      stream: _availableChatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? snapshot != null
                ? ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      // print(snapshot.data.docs[index]
                      //     .data()["chatRoomId"]
                      //     .toString()
                      //     .replaceAll("_", ""));
                      // print("----> " + _myUserName);
                      // print(snapshot.data.docs[index]
                      //     .data()["chatRoomId"]
                      //     .toString()
                      //     .replaceAll("_", "")
                      //     .replaceAll(FirebaseAuth.instance.currentUser.uid, ""));
                      _getUserName(snapshot.data.docs[index]
                          .data()["chatRoomId"]
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(
                              FirebaseAuth.instance.currentUser.uid, ""));
                      // print(_userName);
                      return _userName != null
                          ? ChatRoomListTile(
                              _userName,
                              // snapshot.data.docs[index]
                              //     .data()["chatRoomId"]
                              //     .toString()
                              //     .replaceAll("_", "")
                              //     .replaceAll(
                              //         FirebaseAuth.instance.currentUser.uid, ""),
                              snapshot.data.docs[index].data()["chatRoomId"])
                          : Container();
                    },
                  )
                : Container(
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator()),
                  )
            : Container(
                width: double.infinity,
                child: Center(child: CircularProgressIndicator()),
              );
      },
    );
  }

  getUserInfo() async {
    _myUserName = await DataStorage.getUserNamePreference();
    // _myUserName = "utsav";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Center(child: Text(_myUserName)),
      ),
      backgroundColor: ColorPalette['swatch_20'],
      appBar: appBar(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPalette['swatch_20'],
        child: Icon(
          Icons.add_rounded,
          size: 28,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
      ),
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.04,
          // height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            color: ColorPalette['swatch_20'],
          ),
        ),
        Expanded(
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.08,
            // height: 500,
            padding: EdgeInsets.only(top: 8),
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              color: Colors.white,
            ),
            child: Container(
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ChatRoomList(),
            ),
          ),
        ),
      ]),
    );
  }
}

class ChatRoomListTile extends StatelessWidget {
  final String _userName;
  final String _chatRoomId;
  ChatRoomListTile(this._userName, this._chatRoomId);
  @override
  Widget build(BuildContext context) {
    // print(_chatRoomId);
    // print(_userName);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatRoomScreen(
                        chatRoomId: _chatRoomId,
                      )));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF000000).withOpacity(0.1),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: Offset(
                    4.0,
                    4.0,
                  ),
                ),
              ],
              gradient: LinearGradient(colors: [
                // Color(0xFFE3F2FD),
                // Color(0xFFccdae4),
                ColorPalette['swatch_7'],
                ColorPalette['swatch_7'],
              ]),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: ColorPalette['swatch_25'],
                child: Text(
                  _userName[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                maxRadius: 26,
              ),
              title: Text(
                _userName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // alignment: _isSendBAlignment.centerRight : Alignment.centerLeft,
          // child: Container(
          //   alignment: Alignment.centerLeft,
          //   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
          //   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.all(Radius.circular(40)),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Color(0xFF000000).withOpacity(0.1),
          //         blurRadius: 5.0,
          //         spreadRadius: 1.0,
          //         offset: Offset(
          //           4.0,
          //           4.0,
          //         ),
          //       ),
          //     ],
          //     gradient: LinearGradient(colors: [
          //       Color(0xFFE3F2FD),
          //       Color(0xFFccdae4),
          //     ]),
          //   ),
          //   child: Container(
          //     child: Text(
          //       _userName,
          //       style: TextStyle(fontSize: 16),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
