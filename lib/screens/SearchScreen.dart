import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connection/config/database.dart';
import 'package:connection/data/dataCollection.dart';
import 'package:connection/data/userData.dart';
import 'package:connection/screens/ChatRoom.dart';
import 'package:connection/widgets/widget.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

String _myUserName;

class _SearchState extends State<Search> {
  TextEditingController searchTextController = new TextEditingController();
  DataBaseMethods _dataBaseMethods = new DataBaseMethods();
  QuerySnapshot searchResult;

  initSearch() {
    _dataBaseMethods.getUseByUserName(searchTextController.text).then((value) {
      setState(() {
        searchResult = value;
      });
    });
  }

  Widget SearchResultList() {
    return searchResult != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResult.docs.length,
            itemBuilder: (context, index) {
              return SearchResultCard(
                name: searchResult.docs[index].data()["name"],
                email: searchResult.docs[index].data()["email"],
              );
            })
        : Container();
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatRoomForUser({String userName}) {
    // print("-----");
    // print(userName);
    // print(_myUserName);

    if (userName != _myUserName) {
      String _charRoomId = getChatRoomId(userName, _myUserName);
      List<String> users = [userName, _myUserName];
      Map<String, dynamic> _chatRoomMap = {
        "users": users,
        "chatRoomId": _charRoomId
      };
      DataBaseMethods().addChatRoom(_charRoomId, _chatRoomMap);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChatRoomScreen(chatRoomId: _charRoomId),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You can not send message to your self.")));
    }
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    _myUserName = await DataStorage.getUserNamePreference();
    UserData.myUserName = await DataStorage.getUserNamePreference();
    setState(() {});
  }

  Widget SearchResultCard({String name, final String email}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        height: 80,
        // color: Color(0xFFD6EAF8),
        decoration: BoxDecoration(
          color: Color(0xFFEBF5FB),
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
          borderRadius: BorderRadius.all(
            // topLeft:
            Radius.circular(40),
            // topRight: Radius.circular(50),
            // bottomLeft: Radius.circular(50),
            // bottomRight: Radius.circular(50),
          ),
        ),
        child: ListTile(
          title: Text(name),
          leading: CircleAvatar(
            child: Text(name[0]),
            maxRadius: 24,
          ),
          subtitle: Text(email),
          trailing: Padding(
            padding: EdgeInsets.only(top: 0),
            child: GestureDetector(
              onTap: () {
                // print(name);
                createChatRoomForUser(userName: name);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFCCBC),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF000000).withOpacity(0.1),
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        4.0,
                        4.0,
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text("Message"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchScreenAppBar(context),
      backgroundColor: Color(0xff1E90FF),
      body: Container(
        // color: Colors.white,
        child: Column(
          children: [
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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search User...",
                          border: InputBorder.none,
                        ),
                        controller: searchTextController,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        initSearch();
                      },
                      child: Container(
                        child: Image.asset(
                          "lib/assets/searchIcon.png",
                          height: 40,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: SearchResultList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class SearchResultCard extends StatelessWidget {
//   final ;

//   SearchResultCard({this.name, this.email});

//   @override
//   Widget build(BuildContext context) {}
// }
