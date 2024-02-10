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

class ProductImage {
  int? id;
  int? productId;
  int? position;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? alt;
  int? width;
  int? height;
  String? src;
  List<int>? variantIds;
  String? adminGraphqlApiId;

  ProductImage(
      {this.id,
      this.productId,
      this.position,
      this.createdAt,
      this.updatedAt,
      this.alt,
      this.width,
      this.height,
      this.src,
      this.variantIds,
      this.adminGraphqlApiId});

  ProductImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    position = json['position'];
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt =
        json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
    alt = json['alt'];
    width = json['width'];
    height = json['height'];
    src = json['src'];
    variantIds = json['variant_ids'].cast<int>();
    adminGraphqlApiId = json['admin_graphql_api_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['product_id'] = productId;
    data['position'] = position;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['alt'] = alt;
    data['width'] = width;
    data['height'] = height;
    data['src'] = src;
    data['variant_ids'] = variantIds;
    data['admin_graphql_api_id'] = adminGraphqlApiId;
    return data;
  }
}
