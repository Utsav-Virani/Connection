import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connection/config/database.dart';
import 'package:connection/data/Colors/colorpanel.dart';
import 'package:connection/data/userData.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  final String chatRoomId;

  ChatRoomScreen({this.chatRoomId});

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  TextEditingController _messageController = new TextEditingController();
  Stream chatMessageStream;

  DataBaseMethods _dataBaseMethods = new DataBaseMethods();

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          reverse: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            // print(snapshot.data.docs[index].data()["sentBy"]);
            return MessageTile(
                snapshot.data.docs[index].data()["message"],
                snapshot.data.docs[index].data()["sentBy"] ==
                    UserData.myUserName);
          },
        );
      },
    );
  }

  sendMessage() {
    // print("--------");
    // print(_messageController.text);
    // print(UserData.myUserName);
    if (_messageController.text.isNotEmpty) {
      Map<String, dynamic> _messageMap = {
        "message": _messageController.text,
        "sentBy": UserData.myUserName,
        "time": DateTime.now().microsecondsSinceEpoch,
      };

      _dataBaseMethods.setConversionMessages(widget.chatRoomId, _messageMap);
      _messageController.text = "";
    }
  }

  @override
  void initState() {
    // print(widget.chatRoomId);
    _dataBaseMethods.getConversionMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette['swatch_20'],
        elevation: 0,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 80),
              child: ChatMessageList(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(horizontal: 5),
              margin: EdgeInsets.only(bottom: 5),
              child: Container(
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: ColorPalette['swatch_20'].withOpacity(.3),
                          // color: Color(0xFFEBF5FB),
                          border: Border(
                              // top: BorderSide(width: 2, color: Colors.grey),
                              )),
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: "Send message...",
                          border: InputBorder.none,
                        ),
                        controller: _messageController,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // initSearch();
                        sendMessage();
                      },
                      child: Container(
                        // padding:
                        //     EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                        // decoration: BoxDecoration(
                        //   // color: Color(0xFFEBF5FB),
                        //   // color: Color(0xFFE0F7FA),
                        //   // boxShadow: [
                        //   //   BoxShadow(
                        //   //     color: Color(0xFF000000).withOpacity(0.1),
                        //   //     blurRadius: 2.0,
                        //   //     spreadRadius: 0.5,
                        //   //     offset: Offset(
                        //   //       2.0,
                        //   //       2.0,
                        //   //     ),
                        //   //   ),
                        //   // ],
                        //   border:
                        //       Border.all(width: 1, color: Color(0xFFcadee1)),
                        //   borderRadius: BorderRadius.all(Radius.circular(50)),
                        // ),
                        // alignment: Alignment.center,

                        // width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: ColorPalette['swatch_20'].withOpacity(.3),
                            // color: Color(0xFFEBF5FB),
                            border: Border(
                                // top: BorderSide(width: 2, color: Colors.grey),
                                )),
                        padding: EdgeInsets.all(12),
                        // margin: EdgeInsets.only(5),
                        child: Image.asset(
                          "lib/assets/msgSentLogo.png",
                          height: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String _message;
  final bool _isSendByMe;

  MessageTile(this._message, this._isSendByMe);

  @override
  Widget build(BuildContext context) {
    // print(_isSendByMe);.
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: _isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
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
          gradient: LinearGradient(
            colors: _isSendByMe
                ? [
                    Color(0xFFE3F2FD),
                    Color(0xFFccdae4),
                  ]
                : [
                    Color(0xFFe6e4d0),
                    Color(0xFFEEEEEE),
                  ],
          ),
        ),
        child: Text(
          _message,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
