import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:woosignal_shopify/models/response/countries_response.dart';
import 'package:woosignal_shopify/models/response/policies_response.dart';
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

  group('Testing Shopify Products', () {
    test('get products', () async {
      ProductsResponse? productsResponse =
          await WooSignal.instance.getProducts();

      expect(productsResponse is ProductsResponse, true);

      expect(productsResponse?.products!.isNotEmpty, true);
    }, tags: ['get-products']);
  }, tags: ['products']);

  group('Testing Shopify Shop', () {
    test('get shop', () async {
      ShopResponse? shopResponse = await WooSignal.instance.getShop();

      expect(shopResponse is ShopResponse, true);

      expect(shopResponse != null, true);
    }, tags: ['get-shop']);
  }, tags: ['store-properties']);

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

  /// test for shipping-zones retrieval
  group('Testing Shopify shipping-zones', () {
    test('get shipping-zones', () async {
      ShippingZonesResponse? shippingZonesResponse =
          await WooSignal.instance.getShippingZones();

      expect(shippingZonesResponse is ShippingZonesResponse, true);

      expect(shippingZonesResponse != null, true);
    }, tags: ['get-shipping-zones']);
  }, tags: ['shipping-zones-properties']);

  /// test for provinces retrieval
  group('Testing Shopify provinces', () {
    test('get provinces', () async {
      ProvincesResponse? provincesResponse =
          await WooSignal.instance.getProvinces(id: 765701030200);

      expect(provincesResponse is ProvincesResponse, true);

      expect(provincesResponse != null, true);
    }, tags: ['get-provinces']);
  }, tags: ['shipping-provinces']);
}
