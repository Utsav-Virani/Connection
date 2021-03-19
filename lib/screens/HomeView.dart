import 'package:connection/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:connection/screens/SearchScreen.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Color(0xff1E90FF),
      appBar: appBar(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded,size: 28,),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }
}
