import 'dart:io';
import 'dart:async';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'main.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  File _image;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  Future getCameraImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = imageFile;
    });
  }

  Future getGalleryImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = imageFile;
    });
  }

  Future saveData(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var url = Uri.parse('http://localhost/swipe/data/savedata');

    var request = http.MultipartRequest("POST", url);
    request.fields['title'] = title.text;
    request.fields['description'] = description.text;

    var multipartFile = http.MultipartFile("image", stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Image Saved');
    } else {
      print('Image Failed to Upload');
    }
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
              Container(
                child: _image == null
                    ? Text('No Image Selected')
                    : Image.file(_image),
              ),
              Row(
                children: <Widget>[
                  RaisedButton(
                    onPressed: getCameraImage,
                    color: Colors.blueAccent,
                    child: Icon(Icons.camera),
                  ),
                  RaisedButton(
                    onPressed: getGalleryImage,
                    color: Colors.red,
                    child: Icon(Icons.image),
                  )
                ],
              ),
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
                  saveData(_image);
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
