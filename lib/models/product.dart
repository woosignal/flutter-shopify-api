// Copyright (c) 2026, WooSignal Ltd.
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

import 'package:collection/collection.dart';

class Product {
  int? id;
  String? title;
  String? bodyHtml;
  String? vendor;
  String? productType;
  DateTime? createdAt;
  String? handle;
  DateTime? updatedAt;
  DateTime? publishedAt;
  String? templateSuffix;
  String? status;
  String? publishedScope;
  String? tags;
  String? adminGraphqlApiId;
  List<Variants>? variants;
  List<Options>? options;
  List<Images>? images;
  Images? image;

  Product(
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
      this.variants,
      this.options,
      this.images,
      this.image});

  String get price {
    return defaultVariant?.price ?? "0.00";
  }

  String get compareAtPrice {
    return defaultVariant?.compareAtPrice ?? "0.00";
  }

  bool get onSale {
    return defaultVariant?.compareAtPrice != null &&
        defaultVariant?.compareAtPrice != defaultVariant?.price;
  }

  Variants? get defaultVariant {
    if (variants?.isEmpty ?? false) {
      return null;
    }
    Variants? variant =
        variants?.firstWhereOrNull((element) => element.position == 1);
    if (variant != null) {
      return variant;
    }
    return variants?.first;
  }

  String? findVariationImage(int? imageId) {
    Images? image = images?.firstWhereOrNull((image) => image.id == imageId);
    if (image != null) {
      return image.src;
    }
    image = images!.firstWhereOrNull((image) => image.position == 1);
    if (image != null) {
      return image.src;
    }
    return images?.first.src;
  }

  List<String?>? optionNameList() {
    return options?.map((e) => e.name).toList();
  }

  Options? getOption(String name) {
    return options?.firstWhereOrNull((element) => element.name == name);
  }

  List<String>? getOptionValues(String name) {
    Options? option = getOption(name);
    return option != null ? option.values : [];
  }

  Variants? findVariation(Map<int, dynamic> options) {
    List<int?> positions = this.options!.map((e) => e.position).toList();

    List<Variants>? variants;
    for (int i = 1; i < positions.length + 1; i++) {
      if (i == 1) {
        variants = this
            .variants!
            .where((element) => element.option1 == options[i])
            .toList();
      }

      if (i == 2) {
        variants = variants!
            .where((element) => element.option2 == options[i])
            .toList();
      }

      if (i == 3) {
        variants = variants!
            .where((element) => element.option3 == options[i])
            .toList();
      }

      if (variants == null || variants.isEmpty) {
        return null;
      }
    }

    if (variants != null && variants.isNotEmpty) {
      return variants.first;
    }
    return null;
  }

  bool hasVariations() {
    return (variants?.length ?? 0) > 1;
  }

  String get name {
    return title ?? "";
  }

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    bodyHtml = json['body_html'];
    vendor = json['vendor'];
    productType = json['product_type'];
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    handle = json['handle'];
    updatedAt =
        json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
    publishedAt = json['published_at'] != null
        ? DateTime.parse(json['published_at'])
        : null;
    templateSuffix = json['template_suffix'];
    status = json['status'];
    publishedScope = json['published_scope'];
    tags = json['tags'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    image = json['image'] != null ? Images.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}

class Variants {
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
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? taxable;
  String? barcode;
  double? grams;
  int? imageId;
  double? weight;
  String? weightUnit;
  int? inventoryItemId;
  int? inventoryQuantity;
  int? oldInventoryQuantity;
  bool? requiresShipping;
  String? adminGraphqlApiId;

  Variants(
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

  Variants.fromJson(Map<String, dynamic> json) {
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
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt =
        json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
    taxable = json['taxable'];
    barcode = json['barcode'];
    grams = double.tryParse(json['grams'].toString());
    imageId = json['image_id'];
    weight = double.tryParse(json['weight'].toString());
    weightUnit = json['weight_unit'];
    inventoryItemId = json['inventory_item_id'];
    inventoryQuantity = json['inventory_quantity'];
    oldInventoryQuantity = json['old_inventory_quantity'];
    requiresShipping = json['requires_shipping'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
    if (inventoryManagement == null) return true;

    if (inventoryManagement == 'shopify') {
      if (inventoryPolicy == 'continue') {
        return true;
      }
      if (inventoryPolicy == 'deny') {
        return inventoryQuantity! > 0;
      }
      return true;
    }
    return true;
  }

  bool isOutOfStock() {
    return !inStock();
  }

  bool get canPurchase {
    return inStock();
  }
}

class Options {
  int? id;
  int? productId;
  String? name;
  int? position;
  List<String>? values;

  Options({this.id, this.productId, this.name, this.position, this.values});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    position = json['position'];
    values = json['values'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['product_id'] = productId;
    data['name'] = name;
    data['position'] = position;
    data['values'] = values;
    return data;
  }
}

class Images {
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

  Images(
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

  Images.fromJson(Map<String, dynamic> json) {
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
