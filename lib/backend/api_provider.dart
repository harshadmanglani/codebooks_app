import 'package:http/http.dart';
import 'dart:convert';
import 'dart:core';

class ApiProvider {
  String url = 'https://api.itbook.store/1.0/';

  Future<dynamic> getRequest(String function, dynamic params) async {
    Response response;

    switch (function) {
      case 'new':
        response = await get(url + 'new');
        break;

      case 'search':
        // params['query'] = params['query'].replaceAll(' ', '%20');
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
