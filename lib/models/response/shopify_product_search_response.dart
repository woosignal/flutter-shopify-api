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

import 'package:woosignal_shopify/models/response/page_info.dart';

class ShopifyProductSearch {
  int? status;
  List<ProductSearch>? products;
  List<dynamic>? errors;
  PageInfo? pageInfo;

  ShopifyProductSearch({this.status, this.products, this.errors});

  ShopifyProductSearch.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class ProductSearch {
  String? id;
  int? uId;
  String? title;
  String? description;
  String? createdAt;
  FeaturedImage? featuredImage;
  String? handle;
  String? publishedAt;
  int? totalInventory;
  PriceRange? priceRange;
  PriceRange? compareAtPriceRange;
  String? productType;
  List<Variants>? variants;

  ProductSearch(
      {this.id,
      this.uId,
      this.title,
      this.description,
      this.createdAt,
      this.featuredImage,
      this.handle,
      this.publishedAt,
      this.totalInventory,
      this.priceRange,
      this.compareAtPriceRange,
      this.productType,
      this.variants});

  ProductSearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uId = json['uid'];
    title = json['title'];
    description = json['description'];
    createdAt = json['createdAt'];
    featuredImage = json['featuredImage'] != null
        ? FeaturedImage.fromJson(json['featuredImage'])
        : null;
    handle = json['handle'];
    publishedAt = json['publishedAt'];
    totalInventory = json['totalInventory'];
    priceRange = json['priceRange'] != null
        ? PriceRange.fromJson(json['priceRange'])
        : null;
    compareAtPriceRange = json['compareAtPriceRange'] != null
        ? PriceRange.fromJson(json['compareAtPriceRange'])
        : null;
    productType = json['productType'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uId;
    data['title'] = title;
    data['description'] = description;
    data['createdAt'] = createdAt;
    if (featuredImage != null) {
      data['featuredImage'] = featuredImage!.toJson();
    }
    data['handle'] = handle;
    data['publishedAt'] = publishedAt;
    data['totalInventory'] = totalInventory;
    if (priceRange != null) {
      data['priceRange'] = priceRange!.toJson();
    }
    if (compareAtPriceRange != null) {
      data['compareAtPriceRange'] = compareAtPriceRange!.toJson();
    }
    data['productType'] = productType;
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedImage {
  String? id;
  String? url;

  FeaturedImage({this.id, this.url});

  FeaturedImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}

class PriceRange {
  MaxVariantPrice? maxVariantPrice;
  MaxVariantPrice? minVariantPrice;

  PriceRange({this.maxVariantPrice, this.minVariantPrice});

  PriceRange.fromJson(Map<String, dynamic> json) {
    maxVariantPrice = json['maxVariantPrice'] != null
        ? MaxVariantPrice.fromJson(json['maxVariantPrice'])
        : null;
    minVariantPrice = json['minVariantPrice'] != null
        ? MaxVariantPrice.fromJson(json['minVariantPrice'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (maxVariantPrice != null) {
      data['maxVariantPrice'] = maxVariantPrice!.toJson();
    }
    if (minVariantPrice != null) {
      data['minVariantPrice'] = minVariantPrice!.toJson();
    }
    return data;
  }
}

class MaxVariantPrice {
  String? amount;
  String? currencyCode;

  MaxVariantPrice({this.amount, this.currencyCode});

  MaxVariantPrice.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currencyCode = json['currencyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['currencyCode'] = currencyCode;
    return data;
  }
}

class Variants {
  String? id;
  String? title;
  bool? taxable;
  String? sku;
  MaxVariantPrice? compareAtPrice;
  List<SelectedOptions>? selectedOptions;
  MaxVariantPrice? price;
  FeaturedImage? image;

  Variants(
      {this.id,
      this.title,
      this.taxable,
      this.sku,
      this.compareAtPrice,
      this.selectedOptions,
      this.price,
      this.image});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    taxable = json['taxable'];
    sku = json['sku'];
    compareAtPrice = json['compareAtPrice'] != null
        ? MaxVariantPrice.fromJson(json['compareAtPrice'])
        : null;
    if (json['selectedOptions'] != null) {
      selectedOptions = <SelectedOptions>[];
      json['selectedOptions'].forEach((v) {
        selectedOptions!.add(SelectedOptions.fromJson(v));
      });
    }
    price =
        json['price'] != null ? MaxVariantPrice.fromJson(json['price']) : null;
    image =
        json['image'] != null ? FeaturedImage.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['taxable'] = taxable;
    data['sku'] = sku;
    if (compareAtPrice != null) {
      data['compareAtPrice'] = compareAtPrice!.toJson();
    }
    if (selectedOptions != null) {
      data['selectedOptions'] =
          selectedOptions!.map((v) => v.toJson()).toList();
    }
    if (price != null) {
      data['price'] = price!.toJson();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}

class SelectedOptions {
  String? name;
  String? value;

  SelectedOptions({this.name, this.value});

  SelectedOptions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}
