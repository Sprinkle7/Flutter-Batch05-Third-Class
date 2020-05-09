import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'details.dart';
import 'addpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List> getData() async {
    final response = await http.get('http://localhost/swipe/data/getdata');
    final result = json.decode(response.body);
    return result;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crud Operation'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => AddPage()));
        },
      ),
      drawer: Drawer(
        child: ListView(children: <Widget>[
          ListTile(
            title: Text('Dashboard'),
            leading: Icon(Icons.dashboard),
          ),
          ListTile(
            title: Text('Second Page'),
            leading: Icon(Icons.battery_unknown),
          )
        ]),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(list: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.black12, width: 1))),
          height: 60,
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Details(
                        index: i,
                        list: list,
                      )));
            },
            title: Text(list[i]['title']),
            leading: list[i]['image'] != ''
                ? Container(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(list[i]['image']),
                    ),
                  )
                : Icon(Icons.verified_user),
            subtitle: Text(list[i]['description']),
          ),
        );
      },
    );
  }
}
