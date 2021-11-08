import 'package:flutter/material.dart';
import 'package:mobile_project/main.dart';

class MySettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('About Us'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(15),
                      height: 200,
                      width: 200,
                      child: Image.network("https://cdn-icons.flaticon.com/png/512/3815/premium/3815602.png?token=exp=1636362678~hmac=459f1a9f5c2d5caae262c4ac67056702"),
                    ),
                    Container(
                      child: Text(
                        'About Us page',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text('HAVE FUN HERE!!'),
                    )
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.arrow_back),
              onPressed: () {
                var widget;
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyHomePage(channel: widget.channel,)));
              })
              ),
    );
  }
}
