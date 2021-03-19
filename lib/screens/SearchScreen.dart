import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connection/config/database.dart';
import 'package:connection/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

class SearchResultCard extends StatelessWidget {
  final String name;
  final String email;

  SearchResultCard({this.name, this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(name),
          Text(email),
        ],
      ),
    );
  }
}
