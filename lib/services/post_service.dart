import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:postapp/config/api_conf.dart' as conf;
import 'package:postapp/models/post_models.dart';

final String ApiUrl = conf.CONFIG['API_URL'];

Future<List<Post>> getMyPost() async {
  final response = await http.get(ApiUrl + '?userId=10');
  return allPostsFromJson(response.body);
}

Future createPost(Post post) async {
  final response = await http.post(ApiUrl,
      headers: {"Content-Type": "application/json"}, body: json.encode(post));
  print(response.body);
  return response.body;
}

Future updatePost(Post post) async {
  final response = await http.put(ApiUrl + post.id.toString(),
      headers: {"Content-Type": "application/json"}, body: json.encode(post));
  print(response.body);
  return response.body;
}

Future deletePost(Post post) async {
  final response = await http.delete(ApiUrl + post.id.toString(),
      headers: {"Content-Type": "application/json"});
  print(response.body);
  return response.body;
}
