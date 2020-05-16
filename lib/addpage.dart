import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  Future savedata() async {
    String url = 'http://divergense.com/swipe/data/savedata';
    http.post(url,
        body: {'title': title.text, 'description': description.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Data')),
        body: Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: title,
                decoration: InputDecoration(
                    hintText: 'Enter Title', labelText: 'Title'),
              ),
              TextField(
                controller: description,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: 'Enter Description', labelText: 'Description'),
              ),
              RaisedButton(
                onPressed: () {
                  savedata();
                  Navigator.of(context).pop(MaterialPageRoute(
                      builder: (BuildContext context) => MyHomePage()));
                },
                color: Colors.red,
                child: Text(
                  'Save Data',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }
}
