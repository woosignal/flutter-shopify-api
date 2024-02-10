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

class OrderResponse {
  String? processedAt;
  BillingAddress? billingAddress;
  ShippingAddress? shippingAddress;
  String? displayFulfillmentStatus;
  List<LineItems>? lineItems;
  String? name;
  bool? fullyPaid;
  OriginalUnitPriceSet? totalPriceSet;
  int? subtotalLineItemsQuantity;
  OriginalUnitPriceSet? subtotalPriceSet;

  OrderResponse(
      {this.processedAt,
      this.billingAddress,
      this.shippingAddress,
      this.displayFulfillmentStatus,
      this.lineItems,
      this.name,
      this.fullyPaid,
      this.totalPriceSet,
      this.subtotalLineItemsQuantity,
      this.subtotalPriceSet});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    processedAt = json['processedAt'];
    billingAddress = json['billingAddress'] != null
        ? BillingAddress.fromJson(json['billingAddress'])
        : null;
    shippingAddress = json['shippingAddress'] != null
        ? ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    displayFulfillmentStatus = json['displayFulfillmentStatus'];
    if (json['lineItems'] != null) {
      lineItems = <LineItems>[];
      json['lineItems'].forEach((v) {
        lineItems!.add(LineItems.fromJson(v));
      });
    }
    name = json['name'];
    fullyPaid = json['fullyPaid'];
    totalPriceSet = json['totalPriceSet'] != null
        ? OriginalUnitPriceSet.fromJson(json['totalPriceSet'])
        : null;
    subtotalLineItemsQuantity = json['subtotalLineItemsQuantity'];
    subtotalPriceSet = json['subtotalPriceSet'] != null
        ? OriginalUnitPriceSet.fromJson(json['subtotalPriceSet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['processedAt'] = processedAt;
    if (billingAddress != null) {
      data['billingAddress'] = billingAddress!.toJson();
    }
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    data['displayFulfillmentStatus'] = displayFulfillmentStatus;
    if (lineItems != null) {
      data['lineItems'] = lineItems!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['fullyPaid'] = fullyPaid;
    if (totalPriceSet != null) {
      data['totalPriceSet'] = totalPriceSet!.toJson();
    }
    data['subtotalLineItemsQuantity'] = subtotalLineItemsQuantity;
    if (subtotalPriceSet != null) {
      data['subtotalPriceSet'] = subtotalPriceSet!.toJson();
    }
    return data;
  }
}

class BillingAddress {
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? province;
  String? city;
  String? country;
  String? countryCodeV2;
  String? zip;

  BillingAddress(
      {this.firstName,
      this.lastName,
      this.address1,
      this.address2,
      this.province,
      this.city,
      this.country,
      this.countryCodeV2,
      this.zip});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    address1 = json['address1'];
    address2 = json['address2'];
    province = json['province'];
    city = json['city'];
    country = json['country'];
    countryCodeV2 = json['countryCodeV2'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['address1'] = address1;
    data['address2'] = address2;
    data['province'] = province;
    data['city'] = city;
    data['country'] = country;
    data['countryCodeV2'] = countryCodeV2;
    data['zip'] = zip;
    return data;
  }
}

class ShippingAddress {
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? province;
  String? city;
  String? country;
  String? countryCodeV2;
  String? phone;
  String? zip;

  ShippingAddress(
      {this.firstName,
      this.lastName,
      this.address1,
      this.address2,
      this.province,
      this.city,
      this.country,
      this.countryCodeV2,
      this.phone,
      this.zip});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    address1 = json['address1'];
    address2 = json['address2'];
    province = json['province'];
    city = json['city'];
    country = json['country'];
    countryCodeV2 = json['countryCodeV2'];
    phone = json['phone'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['address1'] = address1;
    data['address2'] = address2;
    data['province'] = province;
    data['city'] = city;
    data['country'] = country;
    data['countryCodeV2'] = countryCodeV2;
    data['phone'] = phone;
    data['zip'] = zip;
    return data;
  }
}

class LineItems {
  String? id;
  Images? images;
  String? name;
  int? quantity;
  String? title;
  String? variantTitle;
  OriginalUnitPriceSet? originalUnitPriceSet;
  OriginalUnitPriceSet? originalTotalSet;

  LineItems(
      {this.id,
      this.images,
      this.name,
      this.quantity,
      this.title,
      this.variantTitle,
      this.originalUnitPriceSet,
      this.originalTotalSet});

  LineItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'] != null ? Images.fromJson(json['images']) : null;
    name = json['name'];
    quantity = json['quantity'];
    title = json['title'];
    variantTitle = json['variantTitle'];
    originalUnitPriceSet = json['originalUnitPriceSet'] != null
        ? OriginalUnitPriceSet.fromJson(json['originalUnitPriceSet'])
        : null;
    originalTotalSet = json['originalTotalSet'] != null
        ? OriginalUnitPriceSet.fromJson(json['originalTotalSet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (images != null) {
      data['images'] = images!.toJson();
    }
    data['name'] = name;
    data['quantity'] = quantity;
    data['title'] = title;
    data['variantTitle'] = variantTitle;
    if (originalUnitPriceSet != null) {
      data['originalUnitPriceSet'] = originalUnitPriceSet!.toJson();
    }
    if (originalTotalSet != null) {
      data['originalTotalSet'] = originalTotalSet!.toJson();
    }
    return data;
  }
}

class Images {
  String? url;

  Images({this.url});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}

class OriginalUnitPriceSet {
  ShopMoney? shopMoney;

  OriginalUnitPriceSet({this.shopMoney});

  OriginalUnitPriceSet.fromJson(Map<String, dynamic> json) {
    shopMoney = json['shopMoney'] != null
        ? ShopMoney.fromJson(json['shopMoney'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shopMoney != null) {
      data['shopMoney'] = shopMoney!.toJson();
    }
    return data;
  }
}

class ShopMoney {
  String? amount;
  String? currencyCode;

  ShopMoney({this.amount, this.currencyCode});

  ShopMoney.fromJson(Map<String, dynamic> json) {
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
