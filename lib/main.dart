import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:theta/theta.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THETA API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'THETA API Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String response = '';
  bool textResponse = true;
  String image64 = '';

  void _info() async {
    _displayResponse(await Camera.info);
  }

  void _model() async {
    _displayResponse(await Camera.model);
  }

  void _firmware() async {
    _displayResponse(await Camera.firmware);
  }

  void _takePicture() async {
    _displayResponse(await takePicture());
  }

  void _state() async {
    _displayResponse(await Camera.state);
  }

  void _displayResponse(mapData) {
    setState(() {
      textResponse = true;
      response = JsonEncoder.withIndent('  ').convert(mapData);
    });
  }

  void _displayThumb() async {
    var imageData = await ThetaFile.getLastThumb64();
    setState(() {
      textResponse = false;
      image64 = imageData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: _info,
                  child: Text('info'),
                  color: Colors.lightGreen,
                ),
                MaterialButton(
                  onPressed: _model,
                  child: Text('model'),
                  color: Colors.lightGreen,
                ),
                MaterialButton(
                  onPressed: _firmware,
                  child: Text('firmware'),
                  color: Colors.lightGreen,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: _state,
                  child: Text('state'),
                  color: Colors.lightGreen,
                ),
                MaterialButton(
                  onPressed: _takePicture,
                  child: Text('take picture'),
                  color: Colors.lightGreen,
                ),
                MaterialButton(
                  onPressed: _displayThumb,
                  child: Text('thumb'),
                  color: Colors.lightGreen,
                ),
              ],
            ),
            textResponse
                ? Text(response)
                : Container(child: Image.memory(base64Decode(image64))),
          ],
        ),
      ),
    );
  }
}
