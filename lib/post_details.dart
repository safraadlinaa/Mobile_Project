import 'package:flutter/material.dart';
// import 'dart:io';
import 'package:mobile_project/post_add.dart';

// void main() {
//   runApp(PostDetails);
// }

// class PostDetails extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Mobile Project',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PostDetails(),
//     );
//   }
// }

class MyPostDetails extends StatefulWidget {
  MyPostDetails(
      {Key? key,
      required this.postDetail,
      required this.onFavourite,
      required this.onUnFavourite,
      required this.favPost})
      : super(key: key);

  final postDetail;
  dynamic onFavourite;
  dynamic onUnFavourite;
  List favPost;

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<MyPostDetails> {
  bool isFav() {
    return widget.favPost.contains(widget.postDetail["_id"]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Post Detail Page'),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: NetworkImage(
                              "https://www.shareicon.net/data/2017/03/02/880210_images_512x512.png"),
                          fit: BoxFit.cover),
                      border: Border.all(width: 3, color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network("${widget.postDetail["image"]}",
                          errorBuilder: (_1, _2, _3) {
                        return const SizedBox.shrink();
                      }, fit: BoxFit.fill),
                    )),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (!isFav()) {
                              widget.onFavourite(widget.postDetail['_id']);
                            } else {
                              widget.onUnFavourite(widget.postDetail['_id']);
                            }
                          });
                        },
                        icon: Icon(
                          isFav()
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFav() ? Colors.red : null,
                        )),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
                  ],
                )),
                Container(
                  child: Text(
                    '${widget.postDetail['title']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Container(
                  child: Text(
                    '${widget.postDetail['description']}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${widget.postDetail['date']}',
                      style: const TextStyle(
                          fontSize: 12, fontStyle: FontStyle.italic),
                    ),
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
      ),
    );
  }
}
