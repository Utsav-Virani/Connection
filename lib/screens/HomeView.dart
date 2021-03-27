import 'package:connection/config/database.dart';
import 'package:connection/data/dataCollection.dart';
import 'package:connection/data/userData.dart';
import 'package:connection/screens/ChatRoom.dart';
import 'package:connection/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:connection/screens/SearchScreen.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

String _myUserName = "utsav";
Stream _availableChatRoomsStream;

class _HomeViewState extends State<HomeView> {
  DataBaseMethods _dataBaseMethods = new DataBaseMethods();

  @override
  void initState() {
    getUserInfo();
    // print("asd");
    print(_myUserName);
    _dataBaseMethods.getChatRooms(_myUserName).then((value) {
      setState(() {
        _availableChatRoomsStream = value;
      });
    });

    super.initState();
  }

  Widget ChatRoomList() {
    return StreamBuilder(
      stream: _availableChatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  // print(snapshot.data.docs[index]
                  //     .data()["chatRoomId"]
                  //     .toString()
                  //     .replaceAll("_", ""));
                  // print("----> " + _myUserName);
                  return ChatRoomListTile(
                      snapshot.data.docs[index]
                          .data()["chatRoomId"]
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(_myUserName, ""),
                      snapshot.data.docs[index].data()["chatRoomId"]);
                },
              )
            : Container(
                width: double.infinity,
                child: Center(child: CircularProgressIndicator()),
              );
      },
    );
  }

  getUserInfo() async {
    // _myUserName = await DataStorage.getUserNamePreference();
    _myUserName = "utsav";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Center(child: Text(_myUserName)),
      ),
      backgroundColor: Color(0xff1E90FF),
      appBar: appBar(context),
      floatingActionButton: FloatingActionButton(
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
            color: Color(0xff1E90FF),
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
    return GestureDetector(
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
              Color(0xFFE3F2FD),
              Color(0xFFccdae4),
            ]),
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                _userName[0],
                style: TextStyle(fontSize: 24),
              ),
              maxRadius: 26,
            ),
            title: Text(
              _userName,
              style: TextStyle(fontSize: 18),
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
    );
  }
}
