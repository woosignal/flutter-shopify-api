import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:woosignal_shopify/models/product_image.dart';
import 'package:woosignal_shopify/models/response/product_image_count_response.dart';
import 'package:woosignal_shopify/models/response/product_images_response.dart';
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

    /// PRODUCTS
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

    /// IMAGES
    test('get product images', () async {
      ProductImagesResponse? productImagesResponse = await WooSignal.instance.getProductImages(productId: 8443055702328);
      expect(productImagesResponse is ProductImagesResponse, true);
      expect(productImagesResponse?.images!.isNotEmpty, true);
    }, tags: ['get-product-images']);

    test('products single product image', () async {
      ProductImage? productImage = await WooSignal.instance.getProductImage(imageId: 42256696181048, productId: 8443055702328);
      expect(productImage is ProductImage, true);
    }, tags: ['products-single-product-image']);

    test('products count of product images', () async {
      ProductImageCountResponse? productImageCountResponse = await WooSignal.instance.getProductImageCount(productId: 8443055702328);
      expect(productImageCountResponse is ProductImageCountResponse, true);
    }, tags: ['products-count-of-product-images']);

  }, tags: ['shopify-products']);
}

