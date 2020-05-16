import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'editdata.dart';

class Details extends StatefulWidget {
  int index;
  List list;

  Details({this.index, this.list});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void delete() {
    http.post('http://divergense.com/swipe/data/deletedata',
        body: {'id': widget.list[widget.index]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      title: Text('Delete'),
      content:
          Text('Are you sure to delete ${widget.list[widget.index]["title"]}'),
      actions: <Widget>[
        RaisedButton(
          color: Colors.red,
          child: Text('Delete'),
          onPressed: () {
            delete();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MyHomePage()));
          },
        ),
        RaisedButton(
          color: Colors.green,
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            widget.list[widget.index]['title'],
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(widget.list[widget.index]['description']),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => EditData(
                            index: widget.index,
                            list: widget.list,
                          )));
                },
                color: Colors.greenAccent,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  confirm();
                },
                color: Colors.redAccent,
              )
            ],
          )
        ],
      ),
    );
  }
}
