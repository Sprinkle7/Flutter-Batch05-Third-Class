import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {
  int index;
  List list;

  EditData({this.index, this.list});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  Future modifyData() async {
    http.post('http://divergense.com/swipe/data/editdata', body: {
      "id": widget.list[widget.index]["id"],
      "title": title.text,
      "description": description.text
    });
  }

  @override
  void initState() {
    title = TextEditingController(text: widget.list[widget.index]['title']);
    description =
        TextEditingController(text: widget.list[widget.index]['description']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit data'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text('${widget.list[widget.index]["title"]}'),
            Text('${widget.list[widget.index]["description"]}'),
            TextField(
              controller: title,
              decoration:
                  InputDecoration(hintText: 'Enter Title', labelText: 'Title'),
            ),
            TextField(
              controller: description,
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: 'Enter Description', labelText: 'Description'),
            ),
            RaisedButton(
              onPressed: () {
                modifyData();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MyHomePage()));
              },
              color: Colors.red,
              child: Text(
                'Update Data',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
