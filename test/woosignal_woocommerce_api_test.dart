import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:woosignal_shopify/models/response/product_image_count_response.dart';
import 'package:woosignal_shopify/models/response/product_image_response.dart';
import 'package:woosignal_shopify/models/response/product_images_response.dart';
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


    test('get product images', () async {
      ProductImagesResponse? productImagesResponse = await WooSignal.instance.getProductImages(productId: 8443055702328);
      expect(productImagesResponse is ProductImagesResponse, true);
      expect(productImagesResponse?.images!.isNotEmpty, true);
    }, tags: ['get-product-images']);

    test('products single product image', () async {
      ProductImageResponse? productImageResponse = await WooSignal.instance.getProductImage(imageId: 42256696181048, productId: 8443055702328);
      expect(productImageResponse is ProductImageResponse, true);
      expect(productImageResponse?.image!.isDefinedAndNotNull, true);
    }, tags: ['products-single-product-image']);

    test('products count of product images', () async {
      ProductImageCountResponse? productImageCountResponse = await WooSignal.instance.getProductImageCount(productId: 8443055702328);
      expect(productImageCountResponse is ProductImageCountResponse, true);
      expect(productImageCountResponse?.count!.isDefinedAndNotNull, true);
    }, tags: ['products-count-of-product-images']);

  }, tags: ['products']);
}
