import 'package:http/http.dart' as http;
import 'package:postapp/config/api_conf.dart' as conf;
import 'package:postapp/models/post_models.dart';

  final String ApiUrl = conf.CONFIG['API_URL'];

Future<List<Post>> getMyPost() async {
  final response = await http.get(ApiUrl);
  print(response.body);
}