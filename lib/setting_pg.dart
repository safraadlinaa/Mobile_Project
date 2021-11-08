import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySettings(),
    );
  }
}

class MySettings extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  'About Us page',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
              ElevatedButton(     
                 child: Text('Log Out'),
                onPressed: (){}
                ),
            ],
            
          ),
          // floatingActionButton: 
        )
      )
    );
  }
}