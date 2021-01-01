import 'package:http/http.dart';
import 'dart:convert';
import 'dart:core';

/// This class interacts directly with the API.

class ApiProvider {
  String url = 'https://api.itbook.store/1.0/';

  /// Uses the `http.get` method, the `String function` decides the API endpoint to call.
  Future<dynamic> getRequest(String function, dynamic params) async {
    Response response;

    switch (function) {
      case 'new':
        response = await get(url + 'new');
        break;

      case 'search':
        response = await get(url +
            'search/' +
            params['query'] +
            '/' +
            params['page'].toString());
        break;

      case 'isbn':
        response = await get(url + 'books/' + params);
        break;
    }
    try {
      // print(response);
      // print(response.body);
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      return responseMap;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
