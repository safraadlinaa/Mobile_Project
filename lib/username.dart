import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_project/main.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  runApp(MyUsername());
}

class MyUsername extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Project',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: InUsername(),
    );
  }
}

class InUsername extends StatefulWidget {

  @override
  _InUsernameState createState() => _InUsernameState();
}

class _InUsernameState extends State<InUsername> {

  final channel = WebSocketChannel.connect(
    Uri.parse('ws://besquare-demo.herokuapp.com'),
  );

  final myController = TextEditingController();

  void _toHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(channel: channel)), 
      //MyApp()
    );
  }

  void _signIn() {
    if (myController.text.isNotEmpty) {
      channel.sink.add('{"type": "sign_in","data": {"name": "${myController.text}"}}');
      print('${myController.text} sign in success');
      myController.clear();
      _toHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Welcome!'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                width: 250,
                child: Padding(
                  padding: EdgeInsets.all(10),                
                  child: Image.network('https://cdn-icons-png.flaticon.com/512/501/501127.png'),
                  ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Hello!! Come on in after you enter your name!',
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  )
                ),
                ),
            Container(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your name'),
                  controller: myController,
                )),
            Container(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {_signIn();},
                  child: Text(
                    'Enter App',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                )),
          ]),
        ),
      ),
    ));
  }
}
