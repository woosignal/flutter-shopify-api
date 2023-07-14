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

import 'dart:convert';

import '/models/response/woosignal_app.dart';
import '/networking/api_provider.dart';
import '/models/response/product.dart';
import '/models/payload/order_wc.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:encrypt/encrypt.dart';

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

  Map<String, dynamic> _standardPayload(String type, json, String path) =>
      {"type": type, "payload": json, "path": path};

  /// WooSignal Request
  Future<T?> _wooSignalRequest<T>(
      {dynamic payload = const {},
      required String method,
      required String path,
      required T Function(dynamic json) jsonResponse,
      String postUrl = "/request"}) async {
    _printLog("Parameters: $payload");
    payload = _standardPayload(method, payload, path);

    dynamic json = await _apiProvider.post(postUrl, payload);
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
      postUrl: "/ws/cart_check",
      jsonResponse: (json) => json,
    );
  }

  /// checks if the app can make orders
  Future<bool> checkAppStatus() async {
    return await _wooSignalRequest<bool>(
      method: "get",
      path: "ws/app-status",
      postUrl: "/ws/app-status",
      jsonResponse: (json) =>
      (json['status'] == "200" && json['result']['value'] == 1)
          ? true
          : false,
    ) ??
        false;
  }

  /// https://woosignal.com/docs/api/1.0/products
  Future<List<Product>> getProducts(
      {int? page,
      int? perPage,
      String? search,
      String? after,
      String? before,
      String? order,
      String? orderBy,
      String? slug,
      String? status,
      String? type,
      String? sku,
      String? category,
      String? tag,
      String? shippingClass,
      String? attribute,
      String? attributeTerm,
      String? taxClass,
      String? minPrice,
      String? maxPrice,
      String? stockStatus,
      List<int>? exclude,
      List<int>? parentExclude,
      List<int>? include,
      List<int>? parent,
      int? offset,
      bool? featured,
      bool? onSale}) async {
    Map<String, dynamic> payload = {};
    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (search != null) payload["search"] = search;
    if (after != null) payload["after"] = after;
    if (before != null) payload["before"] = before;
    if (order != null) payload["order"] = order;
    if (orderBy != null) payload["orderby"] = orderBy;
    if (slug != null) payload["slug"] = slug;
    if (status != null) payload["status"] = status;
    if (type != null) payload["type"] = type;
    if (sku != null) payload["sku"] = sku;
    if (category != null) payload["category"] = category;
    if (tag != null) payload["tag"] = tag;
    if (shippingClass != null) payload["shipping_class"] = shippingClass;
    if (attribute != null) payload["attribute"] = attribute;
    if (attributeTerm != null) payload["attribute_term"] = attributeTerm;
    if (taxClass != null) payload["tax_class"] = taxClass;
    if (minPrice != null) payload["min_price"] = minPrice;
    if (maxPrice != null) payload["max_price"] = maxPrice;
    if (stockStatus != null) payload["stock_status"] = stockStatus;
    if (exclude != null) payload["exclude"] = exclude;
    if (parentExclude != null) payload["parent_exclude"] = parentExclude;
    if (include != null) payload["include"] = include;
    if (parent != null) payload["parent"] = parent;
    if (offset != null) payload["offset"] = offset;
    if (featured != null) payload["featured"] = featured;
    if (onSale != null) payload["on_sale"] = onSale;

    return await _wooSignalRequest<List<Product>>(
          method: "get",
          payload: payload,
          path: "products",
          jsonResponse: (json) =>
              (json as List).map((i) => Product.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/products#retrive-a-product-api-call
  Future<Product?> retrieveProduct({required int id}) async {
    return await _wooSignalRequest<Product?>(
      method: "get",
      path: "products/${id.toString()}",
      jsonResponse: (json) => Product.fromJson(json),
    );
  }
}