import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  int index;
  List list;

  Details({this.index, this.list});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Column(
        children: <Widget>[
          Container(
            child: Image(
              image: NetworkImage(widget.list[widget.index]['image']),
            ),
          ),
          SizedBox(height: 20),
          Text(
            widget.list[widget.index]['title'],
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(widget.list[widget.index]['description'])
        ],
      ),
    );
  }
}
