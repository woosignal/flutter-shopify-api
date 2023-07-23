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


import 'package:woosignal_shopify/models/response/count_response.dart';
import 'package:woosignal_shopify/models/response/product_response.dart';

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
      path: "ws/cart_check",
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
        int? collection_id,
        DateTime? created_at_max,
        DateTime? created_at_min,
        String? fields,
        String? handle,
        List<int>? ids,
        String? presentment_currencies,
        DateTime? published_at_max,
        DateTime? published_at_min,
        String? published_status,
        int? since_id,
        String? status,
        String? title,
        DateTime? updated_at_max,
        DateTime? updated_at_min,
        String? vendor,

      }) async {
    Map<String, dynamic> payload = {};
    if (limit != null) payload["limit"] = limit;
    if (productType != null) payload["product_type"] = productType;
    if (collection_id != null) payload["collection_id"] = collection_id;
    if (created_at_max != null) payload["created_at_max"] = created_at_max;
    if (created_at_min != null) payload["created_at_min"] = created_at_min;
    if (fields != null) payload["fields"] = fields;
    if (handle != null) payload["handle"] = handle;
    if (ids != null) payload["ids"] = ids;
    if (presentment_currencies != null) payload["presentment_currencies"] = presentment_currencies;
    if (published_at_max != null) payload["published_at_max"] = published_at_max;
    if (published_at_min != null) payload["published_at_min"] = published_at_min;
    if (published_status != null) payload["published_status"] = published_status;
    if (since_id != null) payload["since_id"] = since_id;
    if (status != null) payload["status"] = status;
    if (title != null) payload["title"] = title;
    if (updated_at_max != null) payload["updated_at_max"] = updated_at_max;
    if (updated_at_min != null) payload["updated_at_min"] = updated_at_min;
    if (vendor != null) payload["vendor"] = vendor;


    return await _wooSignalRequest<ProductsResponse>(
          path: "products",
          method: "post",
          payload: payload,
          jsonResponse: (json) => ProductsResponse.fromJson(json)
        );
  }


  Future<ProductResponse?> getProduct(
      {int? product_id,
        String? fields


      }) async {
    Map<String, dynamic> payload = {};
    if (product_id != null) payload["product_id"] = product_id;
    if (fields != null) payload["fields"] = fields;



    return await _wooSignalRequest<ProductResponse>(
        path: "product",
        method: "post",
        payload: payload,
        jsonResponse: (json) => ProductResponse.fromJson(json)
    );
  }


  Future<CountResponse?> getCount(
      { String? productType,
        int? collection_id,
        DateTime? created_at_max,
        DateTime? created_at_min,
        DateTime? published_at_max,
        DateTime? published_at_min,
        String? published_status,
        DateTime? updated_at_max,
        DateTime? updated_at_min,
        String? vendor,

      }) async {
    Map<String, dynamic> payload = {};
    if (productType != null) payload["productType"] = productType;
    if (collection_id != null) payload["collection_id"] = collection_id;
    if (created_at_max != null) payload["created_at_max"] = created_at_max;
    if (created_at_min != null) payload["created_at_min"] = created_at_min;
    if (published_at_max != null) payload["published_at_max"] = published_at_max;
    if (published_at_min != null) payload["published_at_min"] = published_at_min;
    if (published_status != null) payload["published_status"] = published_status;
    if (updated_at_max != null) payload["updated_at_max"] = updated_at_max;
    if (updated_at_min != null) payload["updated_at_min"] = updated_at_min;
    if (vendor != null) payload["vendor"] = vendor;



    return await _wooSignalRequest<CountResponse>(
        path: "count",
        method: "post",
        payload: payload,
        jsonResponse: (json) => CountResponse.fromJson(json)
    );
  }
}





