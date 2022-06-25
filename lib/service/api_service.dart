import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:suitmedia_test_flutter_dev/helper/url_helper.dart';
import 'package:suitmedia_test_flutter_dev/model/user.dart';

class APIService {
  Future<User> getUserList(int page, int perPage) async {
    try {
      final result = await http.get(
          Uri.parse(URLHelper.url+'?page=$page&per_page=$perPage'));
      // print('url: $uri');
      if (result.statusCode == 200) {
        return User.fromJson(jsonDecode(result.body));
      } else {
        return User(
            page: 0,
            perPage: 0,
            total: 0,
            totalPages: 0,
            data: [],
            support: Support(url: '', text: ''));
      }
    } catch (e) {
      return User(
          page: 0,
          perPage: 0,
          total: 0,
          totalPages: 0,
          data: null,
          support:  Support(url: '', text: ''));
    }
  }
}
