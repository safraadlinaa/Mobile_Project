// import 'dart:math';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mobile_project/post_add.dart';
// import 'package:mobile_project/post_add.dart';
import 'package:mobile_project/post_details.dart';
import 'package:mobile_project/setting_pg.dart';
// import 'package:mobile_project/username.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// void main() {
//   runApp(MyUsername());
// }

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.channel, Key? key}) : super(key: key);

  final WebSocketChannel channel;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic _result;
  List _posts = [];
  List _favPost = [];
  bool _newOld = false;

  void onFavourite(id) {
    setState(() {
      _favPost.add(id);
    });
  }

  void onUnFavourite(id) {
    setState(() {
      _favPost = _favPost.where((i) => i != id).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    widget.channel.stream.listen((results) {
      _result = jsonDecode(results);
      if (_result["type"] == "all_posts") {
        _posts = _result['data']['posts'];
        _posts = _posts.reversed.toList();
      }
      setState(() {});
    });
    widget.channel.sink.add('{"type": "get_posts"}'); //,"data": { "limit": 25 }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Timeline'),
        actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MySettings()));
                },
              )
            ],
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, data) {
            //data appear in list
            return ListView.builder(
              reverse: _newOld,
              itemCount: _posts.length, //_posts.length,
              itemBuilder: (context, id) {
                bool isFavourite = _favPost.contains(_posts[id]['_id']);
                // styling for a(1) card
                return Card(
                  margin: const EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyPostDetails(
                                    postDetail: _posts[id],
                                    onUnFavourite: onUnFavourite,
                                    onFavourite: onFavourite,
                                    favPost: [],
                                    channel: widget.channel,
                                  )));
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          // margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(5),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage("${_posts[id]["image"]}"),
                            radius: 80.0,
                            backgroundColor: Colors.grey[200],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // calling for data from .json file
                            children: <Widget>[
                              Text(
                                _posts[id]['title'],
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                _posts[id]['description'],
                                maxLines: 3,
                                style: TextStyle(fontSize: 20.0),
                              ),
                              Text(
                                _posts[id]['date'],
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 10.0),
                              ),
                            ],
                          ),
                        )),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              IconButton(
                                  onPressed: () => {
                                        widget.channel.sink.add(
                                            '{"type": "delete_post", "data": { "postId": "${_posts[id]['_id']}"}}'),
                                        print(
                                            'ID: ${_posts[id]['id']} is deleted'),
                                        setState(() {
                                          _posts.indexOf(_posts[id]);
                                          _posts.removeAt(id);
                                        })
                                      },
                                  icon: const Icon(Icons.delete)),
                              IconButton(
                                  onPressed: () => {
                                        setState(() {
                                          if (isFavourite) {
                                            _favPost.remove(_posts[id]['_id']);
                                          } else {
                                            _favPost.add(_posts[id]['_id']);
                                          }
                                        })
                                      },
                                  icon: const Icon(Icons.favorite)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyPosting(channel: widget.channel)));
          }),
    );
  }
}
