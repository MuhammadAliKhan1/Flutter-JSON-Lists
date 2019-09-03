import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      title: "Testing JSON",
      home: Screen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  List data;

  Future<String> getData() async {
    http.Response response = await http.get(
      Uri.encodeFull('https://jsonplaceholder.typicode.com/posts'),
      headers: {
        'Accept': 'application/json',
      },
    );
    this.setState(
      () => data = json.decode(response.body),
    );

    print(data);
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    data[index]['title'],
                    style: TextStyle(color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    data[index]['body'],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
