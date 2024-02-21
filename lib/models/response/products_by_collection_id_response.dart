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

import 'package:woosignal_shopify_api/models/response/page_info.dart';
import 'package:woosignal_shopify_api/models/response/product_search.dart';

class ProductsByCollectionIdResponse {
  int? status;
  List<ProductSearch>? products;
  List<dynamic>? errors;
  PageInfo? pageInfo;
  String? title;

  ProductsByCollectionIdResponse(
      {this.status, this.products, this.errors, this.pageInfo, this.title});

  ProductsByCollectionIdResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['products'] != null) {
      products = <ProductSearch>[];
      json['products'].forEach((v) {
        products!.add(ProductSearch.fromJson(v));
      });
    }
    errors = json['errors'];
    pageInfo =
        json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['errors'] = errors;
    if (pageInfo != null) {
      data['pageInfo'] = pageInfo!.toJson();
    }
    data['title'] = title;
    return data;
  }
}
