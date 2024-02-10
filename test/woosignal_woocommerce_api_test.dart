import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:woosignal_shopify_api/models/product.dart';
import 'package:woosignal_shopify_api/models/product_image.dart';
import 'package:woosignal_shopify_api/models/response/count_response.dart';
import 'package:woosignal_shopify_api/models/response/countries_response.dart';
import 'package:woosignal_shopify_api/models/response/policies_response.dart';
import 'package:woosignal_shopify_api/models/response/product_image_count_response.dart';
import 'package:woosignal_shopify_api/models/response/product_images_response.dart';
import 'package:woosignal_shopify_api/models/response/provinces_response.dart';
import 'package:woosignal_shopify_api/models/response/shipping_zones_response.dart';
import 'package:woosignal_shopify_api/models/response/shop_response.dart';
import 'package:woosignal_shopify_api/models/response/shopify_country_response.dart';
import 'package:woosignal_shopify_api/models/response/shopify_product_response.dart';
import 'package:woosignal_shopify_api/woosignal_shopify_api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  String appKey = "app_key";
  int testProductId = 0;
  int testImageId = 0;
  int testProvinceId = 0;

  setUp(() async {
    await WooSignalShopify.instance.init(
      appKey: appKey,
      debugMode: false,
    );
  });

  /// Test Shopify Products
  group('Testing Shopify Products', () {
    /// PRODUCTS
    test('products - list of products', () async {
      ShopifyProductResponse? productsResponse =
          await WooSignalShopify.instance.getProducts();
      expect(productsResponse is ShopifyProductResponse, true);
      expect(productsResponse?.products!.isNotEmpty, true);
    }, tags: ['products-list-of-products']);

    test('products - single product', () async {
      int productId = testProductId;
      Product? product =
          await WooSignalShopify.instance.getProduct(productId: productId);

      expect(product is Product, true);
    }, tags: ['products-single-product']);

    test('products - count of products', () async {
      CountResponse? countResponse =
          await WooSignalShopify.instance.getProductCount();

      expect(countResponse is CountResponse, true);
    }, tags: ['products-count-of-products']);

    /// IMAGES
    test('get product images', () async {
      ProductImagesResponse? productImagesResponse = await WooSignalShopify
          .instance
          .getProductImages(productId: testProductId);
      expect(productImagesResponse is ProductImagesResponse, true);
      expect(productImagesResponse?.images!.isNotEmpty, true);
    }, tags: ['get-product-images']);

    test('products single product image', () async {
      ProductImage? productImage = await WooSignalShopify.instance
          .getProductImage(imageId: testImageId, productId: testProductId);
      expect(productImage is ProductImage, true);
    }, tags: ['products-single-product-image']);

    test('products count of product images', () async {
      ProductImageCountResponse? productImageCountResponse =
          await WooSignalShopify.instance
              .getProductImageCount(productId: testProductId);
      expect(productImageCountResponse is ProductImageCountResponse, true);
    }, tags: ['products-count-of-product-images']);
  }, tags: ['shopify-products']);

  group('Testing Shopify Shop', () {
    test('get shop', () async {
      ShopResponse? shopResponse = await WooSignalShopify.instance.getShop();

      expect(shopResponse is ShopResponse, true);
      expect(shopResponse != null, true);
    }, tags: ['get-shop']);

    group('Testing Shopify provinces', () {
      test('get provinces', () async {
        ProvincesResponse? provincesResponse =
            await WooSignalShopify.instance.getProvinces(id: testProvinceId);

        expect(provincesResponse is ProvincesResponse, true);

        expect(provincesResponse != null, true);
      }, tags: ['get-provinces']);
    }, tags: ['shipping-provinces']);

    /// test for countries retrieval
    group('Testing Shopify countries', () {
      test('get countries', () async {
        ShopifyCountryResponse? countriesResponse =
            await WooSignalShopify.instance.getCountries();

        expect(countriesResponse is CountriesResponse, true);

        expect(countriesResponse != null, true);
      }, tags: ['get-countries']);
    }, tags: ['countries-properties']);

    /// test for policies retrieval
    group('Testing Shopify policies', () {
      test('get policies', () async {
        PoliciesResponse? policiesResponse =
            await WooSignalShopify.instance.getPolicies();

        expect(policiesResponse is PoliciesResponse, true);

        expect(policiesResponse != null, true);
      }, tags: ['get-policies']);
    }, tags: ['policies-properties']);

    /// test for shipping-zones
    group('Testing Shopify shipping-zones', () {
      test('get shipping-zones', () async {
        ShippingZonesResponse? shippingZonesResponse =
            await WooSignalShopify.instance.getShippingZones();

        expect(shippingZonesResponse is ShippingZonesResponse, true);

        expect(shippingZonesResponse != null, true);
      }, tags: ['get-shipping-zones']);
    }, tags: ['shipping-zones-properties']);

    /// test for provinces
    group('Testing Shopify provinces', () {
      test('get provinces', () async {
        ProvincesResponse? provincesResponse =
            await WooSignalShopify.instance.getProvinces(id: testProvinceId);

        expect(provincesResponse is ProvincesResponse, true);

        expect(provincesResponse != null, true);
      }, tags: ['get-provinces']);
    }, tags: ['shipping-provinces']);
  }, tags: ['store-properties']);
}
