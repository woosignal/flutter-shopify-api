library woosignal_shopify_api;
// Copyright (c) 2024, WooSignal Ltd.
// All rights reserved.
//
// Redistribution and use in source and binary forms are permitted
// provided that the above copyright notice and this paragraph are
// duplicated in all such forms and that any documentation,
// advertising materials, and other materials related to such
// distribution and use acknowledge that the software was developed
// by the WooSignal. The name of the
// WooSignal may not be used to endorse or promote products derived
// from this software without specific prior written permission.
// THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
// IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.

import 'package:nylo_framework/nylo_framework.dart';
import '/models/response/collection_item_response.dart';
import '/models/response/products_by_collection_id_response.dart';
import '/models/response/products_response.dart';
import '/models/discount_code.dart';
import '/models/response/auth/auth_customer_address_updated.dart';
import '/models/response/auth/auth_customer_info.dart';
import '/models/response/auth/auth_customer_order.dart';
import '/models/response/auth/auth_customer_updated_response.dart';
import '/models/response/auth/auth_user.dart';
import '/models/response/order_created_response.dart';
import '/models/response/order_response.dart';
import '/models/response/policies_response.dart';
import '/models/response/price_rule_response.dart';
import '/models/response/product_variants_response.dart';
import '/models/response/provinces_response.dart';
import '/models/response/shop_response.dart';
import '/models/product_image.dart';
import '/models/response/product_image_count_response.dart';
import '/models/response/product_images_response.dart';
import '/models/product.dart';
import '/models/response/count_response.dart';
import '/models/response/shopify_country_response.dart';
import '/models/response/shopify_product_response.dart';
import '/models/response/shopify_product_search_response.dart';
import '/models/shopify_order.dart';
import '/models/shopify_shipping_zone.dart';
import 'models/response/shipping_zones_response.dart';
import '/models/response/woosignal_app.dart';
import '/networking/api_provider.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:encrypt/encrypt.dart';
import 'dart:convert';

/// WooSignal Package version
const String _wooSignalVersion = "1.3.12";

class WooSignalShopify {
  WooSignalShopify._privateConstructor();
  static final WooSignalShopify instance =
      WooSignalShopify._privateConstructor();

  String get version => _wooSignalVersion;

  late ApiProvider _apiProvider;
  bool? _debugMode;
  String? _encryptKey, _encryptSecret;

  /// Returns the storage key for the plugin
  static String storageKey() => 'shopify_customer';

  /// Initialize the class
  Future<void> init(
      {required String? appKey,
      bool debugMode = false,
      String? encryptKey,
      String? encryptSecret}) async {
    assert(appKey != null && appKey != "",
        "Provide a valid app key. Visit https://woosignal.com");
    _apiProvider =
        ApiProvider(appKey: appKey!, debugMode: debugMode, version: version);
    setDebugMode(debugMode);
    if (encryptKey != null) {
      _encryptKey = encryptKey;
    }
    if (encryptSecret != null) {
      _encryptSecret = encryptSecret;
    }
    await _apiProvider.init();
  }

  /// Set the FCM token for notifications
  void setFcmToken(String token) {
    _apiProvider.setFcmToken(token);
  }

  /// Set the Shopify customer ID
  void setShopifyUserId(String userId) {
    _apiProvider.setShopifyCustomerId(userId);
  }

  /// Enable debug mode for logging information
  void setDebugMode(bool debugMode) {
    _debugMode = debugMode;
    _apiProvider.setDebugMode(debugMode);
  }

  /// Print to the console a [message]
  void _printLog(String message) {
    if (_debugMode == true) {
      print("WooSignal LOG: $message");
    }
  }

  /// WooSignal Request
  Future<T?> _wooSignalRequest<T>(
      {dynamic payload,
      required String method,
      required String path,
      required T Function(dynamic json) jsonResponse,
      bool auth = false}) async {
    _printLog("Parameters: $payload");

    if (auth == true) {
      if (!payload.containsKey('access_token')) {
        AuthCustomer? authCustomer =
            Auth.user(key: WooSignalShopify.storageKey());
        if (authCustomer?.user?.accessToken == null) {
          return null;
        }
        payload["access_token"] = authCustomer!.user!.accessToken;
      }
    }

    dynamic json;
    if (method == 'get') {
      json = await _apiProvider.get(path, data: payload);
    }
    if (method == 'post') {
      json = await _apiProvider.post(path, payload);
    }
    if (method == 'put') {
      json = await _apiProvider.put(path, payload);
    }
    if (json is Map<String, dynamic> && json.containsKey('error')) {
      _printLog(json['error']);
      return null;
    }

    T model;
    if (json == null) {
      throw Exception("No response from server");
    }
    try {
      model = jsonResponse(json);
    } on Exception catch (e) {
      _printLog(e.toString());
      return null;
    }

    _printLog(model.toString());
    return model;
  }

  /// Login a user with the [AuthCustomer]
  static authLogin(AuthCustomer authCustomer) async {
    await Auth.set(authCustomer, key: storageKey());
  }

  /// Logout a user
  static authLogout() async {
    await Auth.logout(key: storageKey());
  }

  /// Authenticate a user if they are logged in
  static authShopifyUserModel() async {
    await Auth.loginModel(
        WooSignalShopify.storageKey(), (data) => AuthCustomer.fromJson(data));
  }

  /// Check if a user is logged in
  static bool authUserLoggedIn() {
    AuthCustomer? authCustomer = Auth.user(key: storageKey());
    if (authCustomer == null) {
      return false;
    }
    if (authCustomer.user?.accessToken == null) {
      return false;
    }
    return true;
  }

  /// Returns the logged in user
  static Future<AuthCustomer?> authUser() async {
    return await NyStorage.read<AuthCustomer>(storageKey(), modelDecoders: {
      AuthCustomer: (json) => AuthCustomer.fromJson(json),
    });
  }

  /// Returns the user ID of the logged in user
  static Future<String?> authUserId() async {
    AuthCustomer? authCustomer = await authUser();
    return authCustomer?.user?.uid.toString();
  }

  /// Get the token for the user
  static Future<String?> authUserAccessToken() async {
    AuthCustomer? authCustomer = await authUser();
    if (authCustomer == null) return null;
    return authCustomer.user?.accessToken;
  }

  /// Encrypt [text]
  String encrypt(String text) {
    if (_encryptKey == null) {
      return "";
    }
    if (_encryptSecret == null) {
      return "";
    }
    final key = enc.Key.fromUtf8(_encryptKey!);
    final iv = IV.fromUtf8(_encryptSecret!);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  /// Decrypt [text]
  String decrypt(String text) {
    if (_encryptKey == null) {
      return "";
    }
    if (_encryptSecret == null) {
      return "";
    }
    final key = enc.Key.fromUtf8(_encryptKey!);
    final iv = IV.fromUtf8(_encryptSecret!);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(text), iv: iv);
    return decrypted;
  }

  /// Get app information from WooSignal
  Future<WooSignalApp?> getApp({bool encrypted = false}) async {
    dynamic response =
        await _apiProvider.get("/app", data: {"encrypted": encrypted});
    if (response == null) {
      return null;
    }
    if (encrypted == true) {
      response = jsonDecode(decrypt(response));
    }
    WooSignalApp wooSignalApp = WooSignalApp.fromJson(response);
    _printLog(wooSignalApp.toString());
    return wooSignalApp;
  }

  /// Creates a new payment intent and save details
  Future<Map<String, dynamic>?> stripePaymentIntent({
    String? amount,
    String? desc,
    String? email,
    Map<String, dynamic>? shipping,
    Map<String, dynamic>? customerDetails,
  }) async {
    Map<String, dynamic> payload = {
      "amount": amount,
      "receipt_email": email,
      "shipping": shipping,
      "desc": desc,
      "path": "order/v2/pi",
      "type": "post",
      "customer_details": customerDetails,
    };
    Map<String, dynamic>? payloadRsp =
        await _apiProvider.post("/order/v2/pi", {"data": payload});

    _printLog(payloadRsp.toString());
    return payloadRsp;
  }

  /// Check if the cart items are in stock and returns the users cart
  Future<List<dynamic>?> cartCheck(List<Map<String, dynamic>> cartLines) async {
    return await _wooSignalRequest<List<dynamic>?>(
      method: "post",
      path: "cart-check",
      payload: {"data": cartLines},
      jsonResponse: (json) => json,
    );
  }

  /// Fetch the shipping zones
  Future<ShopifyShippingZone?> fetchShippingZones() async {
    return await _wooSignalRequest<ShopifyShippingZone>(
        path: "ws/shipping_methods",
        method: "get",
        payload: null,
        jsonResponse: (json) => ShopifyShippingZone.fromJson(json));
  }

  /// checks if the app can make orders
  Future<bool> checkAppStatus() async {
    return await _wooSignalRequest<bool>(
          method: "post",
          path: "ws/app-status",
          jsonResponse: (json) =>
              (json['status'] == "200" && json['result']['value'] == 1),
        ) ??
        false;
  }

  /// Create an order
  Future<OrderCreatedResponse?> createOrder(ShopifyOrder shopifyOrder) async {
    return await _wooSignalRequest<OrderCreatedResponse>(
        path: "order",
        method: "post",
        payload: shopifyOrder.toJson(),
        jsonResponse: (json) => OrderCreatedResponse.fromJson(json));
  }

  /// Get the collections by [ids]
  Future<CollectionItem?> getCollectionsByIds(
      {required List<String> ids}) async {
    return await _wooSignalRequest<CollectionItem?>(
        path: "collections/id",
        method: "post",
        payload: {"collection_ids": ids},
        jsonResponse: (json) {
          if (json is! Map<String, dynamic>) {
            return null;
          }
          return CollectionItem.fromJson(json);
        });
  }

  /// Get the products using the rest API
  Future<List<Product>> getProductsRestApi({
    int? limit,
    String? productType,
    int? collectionId,
    String? createdAtMax,
    String? createdAtMin,
    String? fields,
    String? handle,
    List<int>? ids,
    String? presentmentCurrencies,
    String? publishedAtMax,
    String? publishedAtMin,
    String? publishedStatus,
    int? sinceId,
    String? status,
    String? title,
    String? updatedAtMax,
    String? updatedAtMin,
    String? vendor,
  }) async {
    Map<String, dynamic> payload = {};
    if (limit != null) payload["limit"] = limit;
    if (productType != null) payload["product_type"] = productType;
    if (collectionId != null) payload["collection_id"] = collectionId;
    if (createdAtMax != null) payload["created_at_max"] = createdAtMax;
    if (createdAtMin != null) payload["created_at_min"] = createdAtMin;
    if (fields != null) payload["fields"] = fields;
    if (handle != null) payload["handle"] = handle;
    if (ids != null) payload["ids"] = ids.join(",");
    if (presentmentCurrencies != null) {
      payload["presentment_currencies"] = presentmentCurrencies;
    }
    if (publishedAtMax != null) payload["published_at_max"] = publishedAtMax;
    if (publishedAtMin != null) payload["published_at_min"] = publishedAtMin;
    if (publishedStatus != null) payload["published_status"] = publishedStatus;
    if (sinceId != null) payload["since_id"] = sinceId;
    if (status != null) payload["status"] = status;
    if (title != null) payload["title"] = title;
    if (updatedAtMax != null) payload["updated_at_max"] = updatedAtMax;
    if (updatedAtMin != null) payload["updated_at_min"] = updatedAtMin;
    if (vendor != null) payload["vendor"] = vendor;

    return await _wooSignalRequest<List<Product>?>(
            path: "products/json",
            method: "post",
            payload: payload,
            jsonResponse: (json) {
              ProductsResponse productsResponse =
                  ProductsResponse.fromJson(json);
              return productsResponse.products;
            }) ??
        [];
  }

  /// Get products
  Future<ShopifyProductResponse?> getProducts({
    int? first,
    String? after,
    String? status = 'active', // active, archived, draft
  }) async {
    Map<String, dynamic> payload = {};
    if (first != null) payload["first"] = first;
    if (after != null) payload["after"] = after;
    if (status != null) payload["query"] = "status:$status";

    return await _wooSignalRequest<ShopifyProductResponse>(
        path: "products",
        method: "post",
        payload: payload,
        jsonResponse: (json) => ShopifyProductResponse.fromJson(json));
  }

  /// Get products by collection ID
  Future<ProductsByCollectionIdResponse?> getProductsByCollectionId({
    String? id,
    int? first,
    String? after,
  }) async {
    Map<String, dynamic> payload = {};
    if (first != null) payload["first"] = first;
    if (after != null) payload["after"] = after;
    if (id != null) payload["id"] = id;

    return await _wooSignalRequest<ProductsByCollectionIdResponse>(
        path: "products/collection/id",
        method: "post",
        payload: payload,
        jsonResponse: (json) => ProductsByCollectionIdResponse.fromJson(json));
  }

  Future<Product?> getProduct({required int productId, String? fields}) async {
    Map<String, dynamic> payload = {};
    if (fields != null) payload["fields"] = fields;

    return await _wooSignalRequest<Product>(
        path: "products/$productId",
        method: "post",
        payload: payload,
        jsonResponse: (json) => Product.fromJson(json['product']));
  }

  /// Get Product Count
  Future<CountResponse?> getProductCount({
    String? productType,
    int? collectionId,
    String? createdAtMax,
    String? createdAtMin,
    String? publishedAtMax,
    String? publishedAtMin,
    String? publishedStatus,
    String? updatedAtMax,
    String? updatedAtMin,
    String? vendor,
  }) async {
    Map<String, dynamic> payload = {};
    if (productType != null) payload["productType"] = productType;
    if (collectionId != null) payload["collection_id"] = collectionId;
    if (createdAtMax != null) payload["created_at_max"] = createdAtMax;
    if (createdAtMin != null) payload["created_at_min"] = createdAtMin;
    if (publishedAtMax != null) payload["published_at_max"] = publishedAtMax;
    if (publishedAtMin != null) payload["published_at_min"] = publishedAtMin;
    if (publishedStatus != null) payload["published_status"] = publishedStatus;
    if (updatedAtMax != null) payload["updated_at_max"] = updatedAtMax;
    if (updatedAtMin != null) payload["updated_at_min"] = updatedAtMin;
    if (vendor != null) payload["vendor"] = vendor;

    return await _wooSignalRequest<CountResponse>(
        path: "products/count",
        method: "post",
        payload: payload,
        jsonResponse: (json) => CountResponse.fromJson(json));
  }

  /// Get Product Images
  Future<ProductImagesResponse?> getProductImages({
    required int productId,
    String? fields,
    int? sinceId,
  }) async {
    Map<String, dynamic> payload = {};
    if (fields != null) payload["fields"] = fields;
    if (sinceId != null) payload["since_id"] = sinceId;
    return await _wooSignalRequest<ProductImagesResponse>(
        path: "products/$productId/images",
        method: "post",
        payload: payload,
        jsonResponse: (json) => ProductImagesResponse.fromJson(json));
  }

  /// Get Product Image
  Future<ProductImage?> getProductImage({
    required int imageId,
    required int productId,
    String? fields,
  }) async {
    Map<String, dynamic> payload = {};
    if (fields != null) payload["fields"] = fields;

    return await _wooSignalRequest<ProductImage>(
        path: "products/$productId/image/$imageId",
        method: "post",
        payload: payload,
        jsonResponse: (json) => ProductImage.fromJson(json['image']));
  }

  /// Get Product Image Count
  Future<ProductImageCountResponse?> getProductImageCount({
    required int? productId,
    int? sinceId,
  }) async {
    Map<String, dynamic> payload = {};
    if (sinceId != null) payload["since_id"] = sinceId;

    return await _wooSignalRequest<ProductImageCountResponse>(
        path: "products/$productId/images/count",
        method: "post",
        payload: payload,
        jsonResponse: (json) => ProductImageCountResponse.fromJson(json));
  }

  /// Get Product Variants
  Future<ProductVariantsResponse?> getProductVariants(
      {required int productId,
      String? fields,
      int? sinceId,
      int? limit}) async {
    Map<String, dynamic> payload = {};
    if (fields != null) payload["fields"] = fields;
    if (sinceId != null) payload["since_id"] = sinceId;
    if (limit != null) payload["limit"] = limit;
    return await _wooSignalRequest<ProductVariantsResponse>(
        path: "products/$productId/variants",
        method: "post",
        payload: payload,
        jsonResponse: (json) => ProductVariantsResponse.fromJson(json));
  }

  /// Get Shop
  Future<ShopResponse?> getShop({
    String? fields,
  }) async {
    Map<String, dynamic> payload = {};
    if (fields != null) payload["fields"] = fields;

    return await _wooSignalRequest<ShopResponse>(
        path: "shop",
        method: "post",
        payload: payload,
        jsonResponse: (json) => ShopResponse.fromJson(json));
  }

  /// Get Policies
  Future<PoliciesResponse?> getPolicies({
    String? fields,
  }) async {
    Map<String, dynamic> payload = {};
    if (fields != null) payload["fields"] = fields;

    return await _wooSignalRequest<PoliciesResponse>(
        path: "policies",
        method: "post",
        payload: payload,
        jsonResponse: (json) => PoliciesResponse.fromJson(json));
  }

  /// Get Shipping Zones
  Future<ShippingZonesResponse?> getShippingZones({
    String? fields,
  }) async {
    Map<String, dynamic> payload = {};
    if (fields != null) payload["fields"] = fields;

    return await _wooSignalRequest<ShippingZonesResponse>(
        path: "shipping-zones",
        method: "post",
        payload: payload,
        jsonResponse: (json) => ShippingZonesResponse.fromJson(json));
  }

  /// Get Provinces
  Future<ProvincesResponse?> getProvinces({
    String? fields,
    required int id,
  }) async {
    Map<String, dynamic> payload = {};
    if (fields != null) payload["fields"] = fields;

    return await _wooSignalRequest<ProvincesResponse>(
        path: "provinces/$id",
        method: "post",
        payload: payload,
        jsonResponse: (json) => ProvincesResponse.fromJson(json));
  }

  /// Get the discount code by lookup [code]
  Future<DiscountCode?> getDiscountCodeByLookup({
    String? code,
  }) async {
    Map<String, dynamic> payload = {};
    if (code != null) payload["code"] = code;

    return await _wooSignalRequest<DiscountCode>(
        path: "discount-code-by-lookup",
        method: "get",
        payload: payload,
        jsonResponse: (json) => DiscountCode.fromJson(json));
  }

  /// Get the Price Rule by [priceRuleId]
  Future<PriceRuleResponse?> getPriceRuleById({
    String? priceRuleId,
  }) async {
    Map<String, dynamic> payload = {};
    if (priceRuleId != null) payload["id"] = priceRuleId;

    return await _wooSignalRequest<PriceRuleResponse>(
        path: "price-rule-by-id",
        method: "post",
        payload: payload,
        jsonResponse: (json) => PriceRuleResponse.fromJson(json));
  }

  /// Get countries
  Future<ShopifyCountryResponse?> getCountries({
    String? sinceId,
  }) async {
    Map<String, dynamic> payload = {};
    if (sinceId != null) payload["since_id"] = sinceId;

    return await _wooSignalRequest<ShopifyCountryResponse>(
        path: "countries",
        method: "get",
        payload: payload,
        jsonResponse: (json) => ShopifyCountryResponse.fromJson(json));
  }

  /// Customer Login
  Future<AuthCustomer?> authCustomerLogin(
      {required String? email,
      required String? password,
      bool? loginUser}) async {
    Map<String, dynamic> payload = {};
    if (email != null) payload["email"] = email;
    if (password != null) payload["password"] = password;

    AuthCustomer? authCustomer = await _wooSignalRequest<AuthCustomer>(
      path: "auth/customer/login",
      method: "post",
      payload: payload,
      jsonResponse: (json) => AuthCustomer.fromJson(json),
    );

    if (authCustomer?.user == null) {
      return null;
    }

    if (authCustomer?.user?.accessToken != null && loginUser == true) {
      await authCustomer!.auth(key: "shopify_customer");
    }
    return authCustomer;
  }

  /// Customer Register
  Future<AuthCustomer?> authCustomerRegister(
      {required String? email,
      required String? password,
      String? firstName,
      String? lastName,
      bool? acceptsMarketing,
      bool? loginUser}) async {
    Map<String, dynamic> payload = {};
    if (email != null) payload["email"] = email;
    if (password != null) payload["password"] = password;
    if (firstName != null) payload["first_name"] = firstName;
    if (lastName != null) payload["last_name"] = lastName;
    if (acceptsMarketing != null) {
      payload["accepts_marketing"] = acceptsMarketing;
    }

    AuthCustomer? authCustomer = await _wooSignalRequest<AuthCustomer>(
        path: "auth/customer/register",
        method: "post",
        payload: payload,
        jsonResponse: (json) => AuthCustomer.fromJson(json));

    if (authCustomer != null && loginUser == true) {
      await authCustomer.auth(key: "shopify_customer");
    }
    return authCustomer;
  }

  /// Get the customer details
  Future<AuthCustomerInfo?> authCustomer({String? accessToken}) async {
    Map<String, dynamic> payload = {};
    if (accessToken != null) payload["access_token"] = accessToken;

    return await _wooSignalRequest<AuthCustomerInfo>(
      path: "auth/customer",
      method: "get",
      payload: payload,
      jsonResponse: (json) => AuthCustomerInfo.fromJson(json),
      auth: true,
    );
  }

  /// Search products
  Future<ShopifyProductSearch?> productSearch(
      {String? query, int first = 100, String? after}) async {
    Map<String, dynamic> payload = {};
    if (query != null) payload["query"] = query;
    payload["first"] = first;
    payload["after"] = after;

    return await _wooSignalRequest<ShopifyProductSearch>(
        path: "product-search",
        method: "post",
        payload: payload,
        jsonResponse: (json) => ShopifyProductSearch.fromJson(json),
        auth: true);
  }

  /// Update the customer details
  /// [customerAccessToken] is optional
  /// [firstName] is optional
  /// [lastName] is optional
  Future<AuthCustomerUpdateResponse?> authCustomerUpdate(
      {String? customerAccessToken,
      String? firstName,
      String? lastName}) async {
    Map<String, dynamic> payload = {};
    if (customerAccessToken != null) {
      payload["access_token"] = customerAccessToken;
    }
    if (firstName != null) payload["first_name"] = firstName;
    if (lastName != null) payload["last_name"] = lastName;

    return await _wooSignalRequest<AuthCustomerUpdateResponse>(
        path: "auth/customer/update",
        method: "put",
        payload: payload,
        jsonResponse: (json) => AuthCustomerUpdateResponse.fromJson(json),
        auth: true);
  }

  /// Get the orders by [customerAccessToken]
  Future<AuthCustomerOrder?> authCustomerOrders(
      {String? customerAccessToken, int? perPage, String? after}) async {
    Map<String, dynamic> payload = {};
    if (customerAccessToken != null) {
      payload["access_token"] = customerAccessToken;
    }
    if (perPage != null) payload["perPage"] = perPage;
    if (after != null) payload["after"] = after;

    return await _wooSignalRequest<AuthCustomerOrder>(
      path: "auth/customer/orders",
      method: "get",
      payload: payload,
      jsonResponse: (json) => AuthCustomerOrder.fromJson(json),
      auth: true,
    );
  }

  /// Forgot password
  Future<bool> authCustomerForgotPassword({required String email}) async {
    Map<String, dynamic> payload = {
      "email": email,
    };

    return await _wooSignalRequest<bool>(
          path: "auth/customer/send-reset-email",
          method: "post",
          payload: payload,
          jsonResponse: (json) => json['status'] == 200,
          auth: true,
        ) ??
        false;
  }

  /// Update the customer address
  Future<AuthCustomerAddressUpdated?> authCustomerUpdateAddress({
    String? customerAccessToken,
    String? address1,
    String? city,
    String? country,
    String? province,
    String? zip,
    String? firstName,
    String? lastName,
    String? phone,
  }) async {
    Map<String, dynamic> payload = {};
    if (customerAccessToken != null) {
      payload["access_token"] = customerAccessToken;
    }
    if (address1 != null) payload["address1"] = address1;
    if (city != null) payload["city"] = city;
    if (country != null) payload["country"] = country;
    if (province != null) payload["province"] = province;
    if (zip != null) payload["zip"] = zip;
    if (firstName != null) payload["first_name"] = firstName;
    if (lastName != null) payload["last_name"] = lastName;
    if (phone != null) payload["phone"] = phone;

    return await _wooSignalRequest<AuthCustomerAddressUpdated>(
        path: "auth/customer/address/update",
        method: "put",
        payload: payload,
        jsonResponse: (json) => AuthCustomerAddressUpdated.fromJson(json),
        auth: true);
  }

  /// Get the order by [orderId]
  Future<OrderResponse?> getOrder({required String orderId}) async {
    Map<String, dynamic> payload = {};

    return await _wooSignalRequest<OrderResponse>(
      path: "order/$orderId",
      method: "get",
      payload: payload,
      jsonResponse: (json) => OrderResponse.fromJson(json),
    );
  }
}
