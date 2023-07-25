library woosignal_shopify;
// Copyright (c) 2023, WooSignal Ltd.
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

import 'package:woosignal_shopify/models/product_image.dart';
import 'package:woosignal_shopify/models/response/product_image_count_response.dart';
import 'package:woosignal_shopify/models/response/product_images_response.dart';
import 'package:woosignal_shopify/models/product.dart';
import 'package:woosignal_shopify/models/response/count_response.dart';
import '/models/response/products_response.dart';
import '/models/response/woosignal_app.dart';
import '/networking/api_provider.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:encrypt/encrypt.dart';
import 'dart:convert';

/// WooSignal Package version
const String wooSignalVersion = "1.0.0";

class WooSignal {
  WooSignal._privateConstructor();
  static final WooSignal instance = WooSignal._privateConstructor();

  late ApiProvider _apiProvider;
  bool? _debugMode;
  String? _encryptKey, _encryptSecret;

  /// Initialize the class
  Future<void> init(
      {required String? appKey,
      bool debugMode = false,
      String? encryptKey,
      String? encryptSecret}) async {
    assert(appKey != null && appKey != "",
        "Provide a valid app key. Visit https://woosignal.com");
    _apiProvider = ApiProvider(
        appKey: appKey!, debugMode: debugMode, version: wooSignalVersion);
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
      {dynamic payload = const {},
      required String method,
      required String path,
      required T Function(dynamic json) jsonResponse}) async {
    _printLog("Parameters: $payload");

    dynamic json;
    if (method == 'get') {
     json = await _apiProvider.get(path, data: payload);
    }
    if (method == 'post') {
      json = await _apiProvider.post(path, {"data": payload});
    }
    if (json is Map<String, dynamic> && json.containsKey('error')) {
      _printLog(json['error']);
      return null;
    }

    T model;
    try {
      model = jsonResponse(json);
    } on Exception catch (e) {
      _printLog(e.toString());
      return null;
    }

    _printLog(model.toString());
    return model;
  }

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

  /// Creates a new payment intent
  Future<Map<String, dynamic>?> stripePaymentIntent(
      {String? amount,
        String? desc,
        String? email,
        Map<String, dynamic>? shipping}) async {
    Map<String, dynamic> payload = {
      "amount": amount,
      "receipt_email": email,
      "shipping": shipping,
      "desc": desc,
      "path": "order/pi",
      "type": "post"
    };
    Map<String, dynamic>? payloadRsp = {};
    await _apiProvider.post("/order/pi", payload).then((json) {
      payloadRsp = json;
    });
    _printLog(payloadRsp.toString());
    return payloadRsp;
  }

  /// Creates a new payment intent and save details
  Future<Map<String, dynamic>?> stripePaymentIntentV2({
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
    await _apiProvider.post("/order/v2/pi", payload);

    _printLog(payloadRsp.toString());
    return payloadRsp;
  }

  /// Check if the cart items are in stock and returns the users cart
  Future<List<dynamic>?> cartCheck(List<Map<String, dynamic>> cartLines) async {
    return await _wooSignalRequest<List<dynamic>?>(
      method: "get",
      path: "cart-check",
      payload: cartLines,
      jsonResponse: (json) => json,
    );
  }

  /// checks if the app can make orders
  Future<bool> checkAppStatus() async {
    return await _wooSignalRequest<bool>(
      method: "get",
      path: "ws/app-status",
      jsonResponse: (json) =>
      (json['status'] == "200" && json['result']['value'] == 1)
          ? true
          : false,
    ) ??
        false;
  }

  /// https://woosignal.com/docs/api/1.0/products
  Future<ProductsResponse?> getProducts(
      {int? limit,
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
    if (ids != null) payload["ids"] = ids;
    if (presentmentCurrencies != null) payload["presentment_currencies"] = presentmentCurrencies;
    if (publishedAtMax != null) payload["published_at_max"] = publishedAtMax;
    if (publishedAtMin != null) payload["published_at_min"] = publishedAtMin;
    if (publishedStatus != null) payload["published_status"] = publishedStatus;
    if (sinceId != null) payload["since_id"] = sinceId;
    if (status != null) payload["status"] = status;
    if (title != null) payload["title"] = title;
    if (updatedAtMax != null) payload["updated_at_max"] = updatedAtMax;
    if (updatedAtMin != null) payload["updated_at_min"] = updatedAtMin;
    if (vendor != null) payload["vendor"] = vendor;

    return await _wooSignalRequest<ProductsResponse>(
        path: "products",
        method: "post",
        payload: payload,
        jsonResponse: (json) => ProductsResponse.fromJson(json)
    );
  }

  Future<Product?> getProduct(
      {required int productId,
        String? fields
      }) async {
    Map<String, dynamic> payload = {};
    if (fields != null) payload["fields"] = fields;

    return await _wooSignalRequest<Product>(
        path: "products/$productId",
        method: "post",
        payload: payload,
        jsonResponse: (json) => Product.fromJson(json['product'])
    );
  }

  Future<CountResponse?> getProductCount(
      {String? productType,
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
        jsonResponse: (json) => CountResponse.fromJson(json)
    );
  }

  Future<ProductImagesResponse?> getProductImages(
      {required int productId,
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
        jsonResponse: (json) => ProductImagesResponse.fromJson(json)
    );
  }

  Future<ProductImage?> getProductImage(
      {required int imageId,
        required int productId,
        String? fields,
      }) async {
    Map<String, dynamic> payload = {};
    if (fields != null) payload["fields"] = fields;

    return await _wooSignalRequest<ProductImage>(
        path: "products/$productId/image/$imageId",
        method: "post",
        payload: payload,
        jsonResponse: (json) => ProductImage.fromJson(json['image'])
    );
  }

  Future<ProductImageCountResponse?> getProductImageCount(
      {required int? productId,
        int? sinceId,
      }) async {
    Map<String, dynamic> payload = {};
    if (sinceId != null) payload["since_id"] = sinceId;

    return await _wooSignalRequest<ProductImageCountResponse>(
        path: "products/$productId/images/count",
        method: "post",
        payload: payload,
        jsonResponse: (json) => ProductImageCountResponse.fromJson(json)
    );
  }
}
