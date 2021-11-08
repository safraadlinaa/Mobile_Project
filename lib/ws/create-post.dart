import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostCubit extends Cubit<String> {
  CreatePostCubit() : super("");

  void creat_post() {
    var map = ({
      "type": "create_post",
      "data": {"title": 'string', "description": 'string', "image": 'string'}
    });
  }

  // void create_response() {
  //   emit({
  //     "type": "new_post",
  //     "data": {
  //       "_id": 'string',
  //       "title": 'string',
  //       "description": 'string',
  //       "image": 'string',
  //       "date": 'string',
  //       "author": 'string'
  //     },
  //     "errors": []
  //   });
  // }
}
