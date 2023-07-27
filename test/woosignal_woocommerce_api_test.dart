import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:woosignal_shopify/models/response/countries_response.dart';
import 'package:woosignal_shopify/models/response/policies_response.dart';
import 'package:woosignal_shopify/models/product_image.dart';
import 'package:woosignal_shopify/models/response/product_image_count_response.dart';
import 'package:woosignal_shopify/models/response/product_images_response.dart';
import 'package:woosignal_shopify/models/product.dart';
import 'package:woosignal_shopify/models/response/count_response.dart';
import 'package:woosignal_shopify/models/response/products_response.dart';
import 'package:woosignal_shopify/models/response/provinces_response.dart';
import 'package:woosignal_shopify/models/response/shipping_zones_response.dart';
import 'package:woosignal_shopify/models/response/shop_response.dart';
import 'package:woosignal_shopify/woosignal_shopify.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  setUp(() async {
    await WooSignal.instance.init(
      appKey:
      "app_affb6434339b34443a297c2e40a3edab7102137e6d67de9abfe612b749bd",
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

  group('Testing Shopify Shop', () {
    test('get shop', () async {
      ShopResponse? shopResponse = await WooSignal.instance.getShop();

      expect(shopResponse is ShopResponse, true);
      expect(shopResponse != null, true);
    }, tags: ['get-shop']);

    group('Testing Shopify provinces', () {
      test('get provinces', () async {
        ProvincesResponse? provincesResponse =
        await WooSignal.instance.getProvinces(id: 765701030200);

        expect(provincesResponse is ProvincesResponse, true);

        expect(provincesResponse != null, true);
      }, tags: ['get-provinces']);
    }, tags: ['shipping-provinces']);

    /// test for countries retrieval
    group('Testing Shopify countries', () {
      test('get countries', () async {
        CountriesResponse? countriesResponse =
        await WooSignal.instance.getCountries();

        expect(countriesResponse is CountriesResponse, true);

        expect(countriesResponse != null, true);
      }, tags: ['get-countries']);
    }, tags: ['countries-properties']);

    /// test for policies retrieval
    group('Testing Shopify policies', () {
      test('get policies', () async {
        PoliciesResponse? policiesResponse =
        await WooSignal.instance.getPolicies();

        expect(policiesResponse is PoliciesResponse, true);

        expect(policiesResponse != null, true);
      }, tags: ['get-policies']);
    }, tags: ['policies-properties']);

    /// test for policies retrieval
    group('Testing Shopify shipping-zones', () {
      test('get shipping-zones', () async {
        ShippingZonesResponse? shippingZonesResponse =
        await WooSignal.instance.getShippingZones();

        expect(shippingZonesResponse is ShippingZonesResponse, true);

        expect(shippingZonesResponse != null, true);
      }, tags: ['get-shipping-zones']);
    }, tags: ['shipping-zones-properties']);

    /// test for policies retrieval
    group('Testing Shopify provinces', () {
      test('get provinces', () async {
        ProvincesResponse? provincesResponse =
        await WooSignal.instance.getProvinces(id: 765701030200);

        expect(provincesResponse is ProvincesResponse, true);

        expect(provincesResponse != null, true);
      }, tags: ['get-provinces']);
    }, tags: ['shipping-provinces']);

  }, tags: ['store-properties']);
}

