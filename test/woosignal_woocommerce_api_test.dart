import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:woosignal_shopify_api/models/product.dart';
import 'package:woosignal_shopify_api/models/product_image.dart';
import 'package:woosignal_shopify_api/models/response/count_response.dart';
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

  const String testProductId = "0";
  const String testImageId = "0";
  const String testProvinceId = "0";

  late DioAdapter dioAdapter;

  setUp(() async {
    await WooSignalShopify.instance.init(
      appKey: "app_key",
      debugMode: false,
    );
    dioAdapter = DioAdapter(dio: WooSignalShopify.instance.dio);
  });

  /// Test Shopify Products
  group('Testing Shopify Products', () {
    test('products - list of products', () async {
      dioAdapter.onPost(
        'products',
        (server) => server.reply(200, {
          'status': 200,
          'pageInfo': {
            'hasPreviousPage': false,
            'hasNextPage': false,
          },
          'products': [
            {
              'id': 'gid://shopify/Product/1',
              'uid': 1,
              'title': 'Sample Product',
            },
          ],
        }),
        data: Matchers.any,
      );

      ShopifyProductResponse? productsResponse =
          await WooSignalShopify.instance.getProducts();
      expect(productsResponse is ShopifyProductResponse, true);
      expect(productsResponse?.products!.isNotEmpty, true);
    }, tags: ['products-list-of-products', 'shopify-products']);

    test('products - single product', () async {
      dioAdapter.onPost(
        'products/$testProductId',
        (server) => server.reply(200, {
          'product': {
            'id': 1,
            'title': 'Sample Product',
          },
        }),
        data: Matchers.any,
      );

      Product? product =
          await WooSignalShopify.instance.getProduct(productId: testProductId);

      expect(product is Product, true);
    }, tags: ['products-single-product', 'shopify-products']);

    test('products - count of products', () async {
      dioAdapter.onPost(
        'products/count',
        (server) => server.reply(200, {'count': 42}),
        data: Matchers.any,
      );

      CountResponse? countResponse =
          await WooSignalShopify.instance.getProductCount();

      expect(countResponse is CountResponse, true);
    }, tags: ['products-count-of-products', 'shopify-products']);

    test('get product images', () async {
      dioAdapter.onPost(
        'products/$testProductId/images',
        (server) => server.reply(200, {
          'images': [
            {
              'id': 1,
              'product_id': int.parse(testProductId),
              'position': 1,
              'src': 'https://example.com/image.png',
              'variant_ids': <int>[],
            },
          ],
        }),
        data: Matchers.any,
      );

      ProductImagesResponse? productImagesResponse = await WooSignalShopify
          .instance
          .getProductImages(productId: testProductId);
      expect(productImagesResponse is ProductImagesResponse, true);
      expect(productImagesResponse?.images!.isNotEmpty, true);
    }, tags: ['get-product-images', 'shopify-products']);

    test('products single product image', () async {
      dioAdapter.onPost(
        'products/$testProductId/image/$testImageId',
        (server) => server.reply(200, {
          'image': {
            'id': int.parse(testImageId),
            'product_id': int.parse(testProductId),
            'position': 1,
            'src': 'https://example.com/image.png',
            'variant_ids': <int>[],
          },
        }),
        data: Matchers.any,
      );

      ProductImage? productImage = await WooSignalShopify.instance
          .getProductImage(imageId: testImageId, productId: testProductId);
      expect(productImage is ProductImage, true);
    }, tags: ['products-single-product-image', 'shopify-products']);

    test('products count of product images', () async {
      dioAdapter.onPost(
        'products/$testProductId/images/count',
        (server) => server.reply(200, {'count': 3}),
        data: Matchers.any,
      );

      ProductImageCountResponse? productImageCountResponse =
          await WooSignalShopify.instance
              .getProductImageCount(productId: testProductId);
      expect(productImageCountResponse is ProductImageCountResponse, true);
    }, tags: ['products-count-of-product-images', 'shopify-products']);
  });

  group('Testing Shopify Shop', () {
    test('get shop', () async {
      dioAdapter.onPost(
        'shop',
        (server) => server.reply(200, {
          'shop': {
            'id': 1,
            'name': 'Test Shop',
            'email': 'test@example.com',
          },
        }),
        data: Matchers.any,
      );

      ShopResponse? shopResponse = await WooSignalShopify.instance.getShop();

      expect(shopResponse is ShopResponse, true);
      expect(shopResponse != null, true);
    }, tags: ['get-shop', 'store-properties']);

    group('Testing Shopify provinces', () {
      test('get provinces', () async {
        dioAdapter.onPost(
          'provinces/$testProvinceId',
          (server) => server.reply(200, {
            'provinces': [
              {
                'id': 1,
                'country_id': 1,
                'name': 'Sample Province',
                'code': 'SP',
                'tax_name': 'Tax',
                'tax': 0,
                'tax_percentage': 0,
              },
            ],
          }),
          data: Matchers.any,
        );

        ProvincesResponse? provincesResponse =
            await WooSignalShopify.instance.getProvinces(id: testProvinceId);

        expect(provincesResponse is ProvincesResponse, true);

        expect(provincesResponse != null, true);
      }, tags: ['get-provinces', 'shipping-provinces', 'store-properties']);
    });

    group('Testing Shopify countries', () {
      test('get countries', () async {
        dioAdapter.onGet(
          'countries',
          (server) => server.reply(200, {
            'countries': [
              {
                'id': 1,
                'name': 'United States',
                'code': 'US',
                'tax_name': 'Federal Tax',
                'tax': 0,
                'provinces': <Map<String, dynamic>>[],
              },
            ],
          }),
          data: Matchers.any,
          queryParameters: <String, dynamic>{},
        );

        ShopifyCountryResponse? countriesResponse =
            await WooSignalShopify.instance.getCountries();

        expect(countriesResponse is ShopifyCountryResponse, true);

        expect(countriesResponse != null, true);
      }, tags: ['get-countries', 'countries-properties', 'store-properties']);
    });

    group('Testing Shopify policies', () {
      test('get policies', () async {
        dioAdapter.onPost(
          'policies',
          (server) => server.reply(200, {
            'policies': [
              {
                'title': 'Privacy Policy',
                'handle': 'privacy-policy',
                'body': 'Sample body',
                'url': 'https://example.com/privacy',
              },
            ],
          }),
          data: Matchers.any,
        );

        PoliciesResponse? policiesResponse =
            await WooSignalShopify.instance.getPolicies();

        expect(policiesResponse is PoliciesResponse, true);

        expect(policiesResponse != null, true);
      }, tags: ['get-policies', 'policies-properties', 'store-properties']);
    });

    group('Testing Shopify shipping-zones', () {
      test('get shipping-zones', () async {
        dioAdapter.onPost(
          'shipping-zones',
          (server) => server.reply(200, {
            'shipping_zones': [
              {
                'id': 1,
                'name': 'Domestic',
                'countries': <Map<String, dynamic>>[],
                'weight_based_shipping_rates': <Map<String, dynamic>>[],
                'price_based_shipping_rates': <Map<String, dynamic>>[],
                'carrier_shipping_rate_providers': <Map<String, dynamic>>[],
              },
            ],
          }),
          data: Matchers.any,
        );

        ShippingZonesResponse? shippingZonesResponse =
            await WooSignalShopify.instance.getShippingZones();

        expect(shippingZonesResponse is ShippingZonesResponse, true);

        expect(shippingZonesResponse != null, true);
      }, tags: [
        'get-shipping-zones',
        'shipping-zones-properties',
        'store-properties'
      ]);
    });

    group('Testing Shopify provinces', () {
      test('get provinces', () async {
        dioAdapter.onPost(
          'provinces/$testProvinceId',
          (server) => server.reply(200, {
            'provinces': [
              {
                'id': 1,
                'country_id': 1,
                'name': 'Sample Province',
                'code': 'SP',
                'tax_name': 'Tax',
                'tax': 0,
                'tax_percentage': 0,
              },
            ],
          }),
          data: Matchers.any,
        );

        ProvincesResponse? provincesResponse =
            await WooSignalShopify.instance.getProvinces(id: testProvinceId);

        expect(provincesResponse is ProvincesResponse, true);

        expect(provincesResponse != null, true);
      }, tags: ['get-provinces', 'shipping-provinces', 'store-properties']);
    });
  });
}
