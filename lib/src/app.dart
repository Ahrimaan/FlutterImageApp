import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'models/image_model.dart';
import 'widgets/imageList.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 1;
  List<ImageModel> images = [];

  void fetchImage() async {
    try {
      var url = 'https://jsonplaceholder.typicode.com/photos/$counter';
      var response = await get(url);
      var imageModel = ImageModel.fromJson(json.decode(response.body));
      setState(() {
              images.add(imageModel);
              counter++;
            });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text('WHIB'),
    );

    var floatingActionButton = FloatingActionButton(
      onPressed: actionButtonPressed,
      child: Icon(Icons.add),
    );

    var body = new ImageList(images);

    var scaffold = Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
    );

    var app = MaterialApp(home: scaffold);
    return app;
  }

  void actionButtonPressed() {
    fetchImage();
  }
}
