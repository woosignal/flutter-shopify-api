import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:woosignal_shopify/models/response/count_response.dart';
import 'package:woosignal_shopify/models/response/product_response.dart';
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
      productsResponse?.products?.first.title.toString();
      expect(productsResponse is ProductsResponse, true);

      expect(productsResponse?.products!.isNotEmpty, true);

    }, tags: ['get-products']);

  }, tags: ['products']);


  group('Testing Shopify Product', () {

    test('get product', () async {

      ProductResponse? productResponse = await WooSignal.instance.getProduct();
      productResponse?.product?.title.toString();
      expect(productResponse is ProductResponse, true);

      expect(productResponse?.product, true);

    }, tags: ['get-product']);

  }, tags: ['product']);


  group('Testing Shopify Count', () {

    test('get Count', () async {

      CountResponse? countResponse = await WooSignal.instance.getCount();
      countResponse?.count.toString();
      expect(countResponse is CountResponse, true);

      expect(countResponse?.count, true);

    }, tags: ['get-Count']);

  }, tags: ['count']);
}
