import 'package:connection/data/countryCodes.dart';
import 'package:flutter/material.dart';

class CountrySelecter extends StatefulWidget {
  @override
  _CountrySelecterState createState() => _CountrySelecterState();
}

class _CountrySelecterState extends State<CountrySelecter> {
  // ignore: top_level_function_literal_block
  final codeToCountryEmoji = (code) {
    const int flagOffset = 0x1F1E6;
    const int asciiOffset = 0x41;
    final char1 = code.codeUnitAt(0) - asciiOffset + flagOffset;
    final char2 = code.codeUnitAt(1) - asciiOffset + flagOffset;
    return String.fromCharCode(char1) + String.fromCharCode(char2);
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: country.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xFFEBF5FB),
                border: Border.all(width: 1),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF000000).withOpacity(0.2),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      4.0,
                      4.0,
                    ),
                  )
                ],
              ),
              child: ListTile(
                leading: Text(
                  codeToCountryEmoji(country[index]['code']),
                  style: TextStyle(fontSize: 20),
                ),
                title: Text(country[index]['name']),
                subtitle: Text(country[index]['code']),
                trailing: Text(country[index]['p_code']),
              ),
            );
          },
        ),
      ),
    );
  }
}
