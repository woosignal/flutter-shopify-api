import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:woosignal_shopify/models/product.dart';
import 'package:woosignal_shopify/models/response/count_response.dart';
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

  /// Test Shopify Products
  group('Testing Shopify Products', () {

    test('products - list of products', () async {
      ProductsResponse? productsResponse = await WooSignal.instance.getProducts();

      expect(productsResponse is ProductsResponse, true);
      expect(productsResponse?.products!.isNotEmpty, true);
    }, tags: ['products-list-of-products']);

    test('products - single product', () async {
      int productId = 8443055702328;
      Product? product = await WooSignal.instance.getProduct(productId: productId);

      expect(product is Product, true);
    }, tags: ['products-single-product']);

    test('products - count of products', () async {
      CountResponse? countResponse = await WooSignal.instance.getProductCount();

      expect(countResponse is CountResponse, true);
    }, tags: ['products-count-of-products']);

  }, tags: ['shopify-products']);

}
