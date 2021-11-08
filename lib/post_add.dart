import 'package:flutter/material.dart';
import 'package:mobile_project/main.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// void main() {
//   runApp(MyPost());
// }

// class MyPost extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Mobile Project',
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       home: MyPosting(),
//     );
//   }
// }

class MyPosting extends StatefulWidget {
  MyPosting({required this.channel, Key? key}) : super(key: key);

  WebSocketChannel channel;

  @override
  _MyPostingState createState() => _MyPostingState();
}

class _MyPostingState extends State<MyPosting> {
  late WebSocketChannel channel;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController imgController = TextEditingController();

  String _title = "";
  String _desc = "";
  String _imgURL = "";

  void createPost() {
    if (titleController.text.isNotEmpty &&
        descController.text.isNotEmpty &&
        imgController.text.isNotEmpty) {
      widget.channel.sink.add(
          '{"type": "create_post", "data": {"title": "${titleController.text}", "description": "${descController.text}", "image": "${imgController.text}"}}');
      print('New post created');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add New Post'),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 30),
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'Title: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: titleController,
                  onChanged: (String value) => _title = value,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your post title',
                    labelText: 'Post Title',
                  ),
                ),
              ),
              Text(
                'Description: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: descController,
                  onChanged: (String value) => _desc = value,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your post description',
                      labelText: 'Post Description'),
                ),
              ),
              Text(
                'Image URL: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: imgController,
                  onChanged: (String value) => _imgURL = value,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your post image url',
                      labelText: 'Image URL'
                      ),
                ),
              ),
              FloatingActionButton(
                  child: Icon(Icons.create),
                  onPressed: () {
                    createPost();
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(channel: widget.channel)));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
