import 'package:flutter/material.dart';

void main() {
  runApp(MyPost());
}

class MyPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Project',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyPosting(),
    );
  }
}

class MyPosting extends StatefulWidget{
  @override
  _MyPostingState createState() => _MyPostingState();
}

class _MyPostingState extends State<MyPosting> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add Post'),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 30),
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
             
              Text(
                'Title: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your post title',
                  labelText: 'Post Title'
                ),
              ),
              
              
              Text(
                'Description: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your post description',
                  labelText: 'Post Description'
                ),
              ),
              Text(
                'Image URL: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your post image url',
                  labelText: 'Post Image URL'
                ),
              ),
              FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyPosting()));
                    }),
            ],
          ),
        ),
      ),
    );
  }
}