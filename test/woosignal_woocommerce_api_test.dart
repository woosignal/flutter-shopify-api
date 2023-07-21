import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:woosignal_shopify/models/response/products_response.dart';
import 'package:woosignal_shopify/woosignal_shopify.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  setUp(() async {
    await WooSignal.instance.init(
      appKey: "app_affb6434339b34443a297c2e40a3edab7102137e6d67de9abfe612b749bd",
      debugMode: false,
    );
  });

  group('Testing Shopify Products', () {

    test('get products', () async {

      ProductsResponse? productsResponse = await WooSignal.instance.getProducts();

      expect(productsResponse is ProductsResponse, true);

      expect(productsResponse?.products!.isNotEmpty, true);

    }, tags: ['get-products']);

  }, tags: ['products']);
}
