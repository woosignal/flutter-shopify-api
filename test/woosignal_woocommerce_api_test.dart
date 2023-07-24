import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  test('api data testing', () async {
    Future<http.Response> _mockRequest(http.Request request) async {
      if (request.url
          .toString()
          .startsWith('https://api.woosignal.com/shopify/v1/shop')) {
        return http.Response(
            File('test/test_resources/shop_data.json').readAsStringSync(),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      }
      return http.Response('Error: Unknown endpoint', 404);
    }


  //   final apiProvider = ApiProvider(MockClient(_mockRequest));
  //   final user = await apiProvider.getUser();
  //   expect(user.userId, 1);
  //   expect(user.id, 1);
  //   expect(
  //     user.title,
  //     'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
  //   );
  //   expect(
  //     user.body,
  //     'quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto',
  //   );
  });


}
