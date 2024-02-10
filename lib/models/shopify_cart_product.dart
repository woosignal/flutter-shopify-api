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

class CartProduct {
  int? id;
  String? title;
  String? bodyHtml;
  String? vendor;
  String? productType;
  String? createdAt;
  String? handle;
  String? updatedAt;
  String? publishedAt;
  String? templateSuffix;
  String? status;
  String? publishedScope;
  String? tags;
  String? adminGraphqlApiId;
  Variant? variant;
  Image? image;
  bool? isVariation;
  int? cartQuantity;

  CartProduct(
      {this.id,
      this.title,
      this.bodyHtml,
      this.vendor,
      this.productType,
      this.createdAt,
      this.handle,
      this.updatedAt,
      this.publishedAt,
      this.templateSuffix,
      this.status,
      this.publishedScope,
      this.tags,
      this.adminGraphqlApiId,
      this.variant,
      this.image,
      this.cartQuantity,
      this.isVariation});

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    bodyHtml = json['body_html'];
    vendor = json['vendor'];
    productType = json['product_type'];
    createdAt = json['created_at'];
    handle = json['handle'];
    updatedAt = json['updated_at'];
    publishedAt = json['published_at'];
    templateSuffix = json['template_suffix'];
    status = json['status'];
    publishedScope = json['published_scope'];
    tags = json['tags'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
    cartQuantity = json['cart_quantity'];
    isVariation = json['is_variation'];
    if (json['variant'] != null) {
      variant = Variant.fromJson(json['variant']);
    }
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body_html'] = bodyHtml;
    data['vendor'] = vendor;
    data['product_type'] = productType;
    data['created_at'] = createdAt;
    data['handle'] = handle;
    data['updated_at'] = updatedAt;
    data['published_at'] = publishedAt;
    data['template_suffix'] = templateSuffix;
    data['status'] = status;
    data['published_scope'] = publishedScope;
    data['tags'] = tags;
    data['admin_graphql_api_id'] = adminGraphqlApiId;
    data['is_variation'] = isVariation;
    data['cart_quantity'] = cartQuantity;
    if (variant != null) {
      data['variant'] = variant!.toJson();
    }
    if (image != null) {
      data['images'] = image!.toJson();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }

  String? findVariationImage() {
    return (image == null ? '' : image!.src);
  }

  String? price() {
    return variant!.price;
  }
}

class Variant {
  int? id;
  int? productId;
  String? title;
  String? price;
  String? sku;
  int? position;
  String? inventoryPolicy;
  String? compareAtPrice;
  String? fulfillmentService;
  String? inventoryManagement;
  String? option1;
  String? option2;
  String? option3;
  String? createdAt;
  String? updatedAt;
  bool? taxable;
  String? barcode;
  int? grams;
  int? imageId;
  double? weight;
  String? weightUnit;
  int? inventoryItemId;
  int? inventoryQuantity;
  int? oldInventoryQuantity;
  bool? requiresShipping;
  String? adminGraphqlApiId;

  Variant(
      {this.id,
      this.productId,
      this.title,
      this.price,
      this.sku,
      this.position,
      this.inventoryPolicy,
      this.compareAtPrice,
      this.fulfillmentService,
      this.inventoryManagement,
      this.option1,
      this.option2,
      this.option3,
      this.createdAt,
      this.updatedAt,
      this.taxable,
      this.barcode,
      this.grams,
      this.imageId,
      this.weight,
      this.weightUnit,
      this.inventoryItemId,
      this.inventoryQuantity,
      this.oldInventoryQuantity,
      this.requiresShipping,
      this.adminGraphqlApiId});

  Variant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    title = json['title'];
    price = json['price'];
    sku = json['sku'];
    position = json['position'];
    inventoryPolicy = json['inventory_policy'];
    compareAtPrice = json['compare_at_price'];
    fulfillmentService = json['fulfillment_service'];
    inventoryManagement = json['inventory_management'];
    option1 = json['option1'];
    option2 = json['option2'];
    option3 = json['option3'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    taxable = json['taxable'];
    barcode = json['barcode'];
    grams = json['grams'];
    imageId = json['image_id'];
    weight = double.parse(json['weight'].toString());
    weightUnit = json['weight_unit'];
    inventoryItemId = json['inventory_item_id'];
    inventoryQuantity = json['inventory_quantity'];
    oldInventoryQuantity = json['old_inventory_quantity'];
    requiresShipping = json['requires_shipping'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['title'] = title;
    data['price'] = price;
    data['sku'] = sku;
    data['position'] = position;
    data['inventory_policy'] = inventoryPolicy;
    data['compare_at_price'] = compareAtPrice;
    data['fulfillment_service'] = fulfillmentService;
    data['inventory_management'] = inventoryManagement;
    data['option1'] = option1;
    data['option2'] = option2;
    data['option3'] = option3;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['taxable'] = taxable;
    data['barcode'] = barcode;
    data['grams'] = grams;
    data['image_id'] = imageId;
    data['weight'] = weight;
    data['weight_unit'] = weightUnit;
    data['inventory_item_id'] = inventoryItemId;
    data['inventory_quantity'] = inventoryQuantity;
    data['old_inventory_quantity'] = oldInventoryQuantity;
    data['requires_shipping'] = requiresShipping;
    data['admin_graphql_api_id'] = adminGraphqlApiId;
    return data;
  }

  bool inStock() {
    return inventoryQuantity! > 0;
  }
}

class Image {
  int? id;
  int? productId;
  int? position;
  String? createdAt;
  String? updatedAt;
  String? alt;
  int? width;
  int? height;
  String? src;
  List<int>? variantIds;
  String? adminGraphqlApiId;

  Image(
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

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    alt = json['alt'];
    width = json['width'];
    height = json['height'];
    src = json['src'];
    variantIds = json['variant_ids'].cast<int>();
    adminGraphqlApiId = json['admin_graphql_api_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
