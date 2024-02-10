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

class AuthCustomerOrder {
  PageInfo? pageInfo;
  List<Orders>? orders;
  List<Errors>? errors;

  AuthCustomerOrder({this.orders, this.errors, this.pageInfo});

  AuthCustomerOrder.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
    if (json['pageInfo'] != null) {
      pageInfo = PageInfo.fromJson(json['pageInfo']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PageInfo {
  bool? hasNextPage;
  String? startCursor;
  String? endCursor;

  PageInfo({this.hasNextPage, this.startCursor, this.endCursor});

  PageInfo.fromJson(Map<String, dynamic> json) {
    hasNextPage = json['hasNextPage'];
    startCursor = json['startCursor'];
    endCursor = json['endCursor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hasNextPage'] = hasNextPage;
    data['startCursor'] = startCursor;
    data['endCursor'] = endCursor;
    return data;
  }
}

class Orders {
  String? id;
  String? uid;
  int? orderNumber;
  TotalPrice? totalPrice;
  TotalPrice? subtotalPrice;
  String? processedAt;
  String? phone;
  BillingAddress? billingAddress;
  BillingAddress? shippingAddress;
  String? currencyCode;
  String? cancelReason;
  String? fulfillmentStatus;
  List<LineItems>? lineItems;
  String? customerLocale;
  String? name;

  Orders(
      {this.id,
      this.uid,
      this.orderNumber,
      this.totalPrice,
      this.subtotalPrice,
      this.processedAt,
      this.phone,
      this.billingAddress,
      this.shippingAddress,
      this.currencyCode,
      this.cancelReason,
      this.fulfillmentStatus,
      this.lineItems,
      this.customerLocale,
      this.name});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    orderNumber = json['orderNumber'];
    totalPrice = json['totalPrice'] != null
        ? TotalPrice.fromJson(json['totalPrice'])
        : null;
    subtotalPrice = json['subtotalPrice'] != null
        ? TotalPrice.fromJson(json['subtotalPrice'])
        : null;
    processedAt = json['processedAt'];
    phone = json['phone'];
    billingAddress = json['billingAddress'] != null
        ? BillingAddress.fromJson(json['billingAddress'])
        : null;
    shippingAddress = json['shippingAddress'] != null
        ? BillingAddress.fromJson(json['shippingAddress'])
        : null;
    currencyCode = json['currencyCode'];
    cancelReason = json['cancelReason'];
    fulfillmentStatus = json['fulfillmentStatus'];
    if (json['lineItems'] != null) {
      lineItems = <LineItems>[];
      json['lineItems'].forEach((v) {
        lineItems!.add(LineItems.fromJson(v));
      });
    }
    customerLocale = json['customerLocale'];
    name = json['name'];
  }

  /// Converts the [Orders] to a map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['orderNumber'] = orderNumber;
    if (totalPrice != null) {
      data['totalPrice'] = totalPrice!.toJson();
    }
    if (subtotalPrice != null) {
      data['subtotalPrice'] = subtotalPrice!.toJson();
    }
    data['processedAt'] = processedAt;
    data['phone'] = phone;
    if (billingAddress != null) {
      data['billingAddress'] = billingAddress!.toJson();
    }
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    data['currencyCode'] = currencyCode;
    data['cancelReason'] = cancelReason;
    data['fulfillmentStatus'] = fulfillmentStatus;
    if (lineItems != null) {
      data['lineItems'] = lineItems!.map((v) => v.toJson()).toList();
    }
    data['customerLocale'] = customerLocale;
    data['name'] = name;
    return data;
  }
}

class TotalPrice {
  String? amount;
  String? currencyCode;

  TotalPrice({this.amount, this.currencyCode});

  TotalPrice.fromJson(Map<String, dynamic> json) {
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

class BillingAddress {
  String? address1;
  String? address2;
  String? city;
  String? company;
  String? firstName;
  String? lastName;
  String? name;
  String? phone;
  String? provinceCode;
  String? zip;
  String? country;

  BillingAddress(
      {this.address1,
      this.address2,
      this.city,
      this.company,
      this.firstName,
      this.lastName,
      this.name,
      this.phone,
      this.provinceCode,
      this.zip,
      this.country});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    company = json['company'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    name = json['name'];
    phone = json['phone'];
    provinceCode = json['provinceCode'];
    zip = json['zip'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address1'] = address1;
    data['address2'] = address2;
    data['city'] = city;
    data['company'] = company;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['name'] = name;
    data['phone'] = phone;
    data['provinceCode'] = provinceCode;
    data['zip'] = zip;
    data['country'] = country;
    return data;
  }
}

class LineItems {
  TotalPrice? originalTotalPrice;
  int? quantity;
  String? title;
  Variant? variant;

  LineItems({this.originalTotalPrice, this.quantity, this.title, this.variant});

  LineItems.fromJson(Map<String, dynamic> json) {
    originalTotalPrice = json['originalTotalPrice'] != null
        ? TotalPrice.fromJson(json['originalTotalPrice'])
        : null;
    quantity = json['quantity'];
    title = json['title'];
    variant =
        json['variant'] != null ? Variant.fromJson(json['variant']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (originalTotalPrice != null) {
      data['originalTotalPrice'] = originalTotalPrice!.toJson();
    }
    data['quantity'] = quantity;
    data['title'] = title;
    if (variant != null) {
      data['variant'] = variant!.toJson();
    }
    return data;
  }
}

class Variant {
  String? id;
  TotalPrice? price;
  Image? image;
  String? title;

  Variant({this.id, this.price, this.image, this.title});

  Variant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'] != null ? TotalPrice.fromJson(json['price']) : null;
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['title'] = title;
    return data;
  }
}

class Image {
  String? id;
  String? url;

  Image({this.id, this.url});

  Image.fromJson(Map<String, dynamic> json) {
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

class Errors {
  String? code;
  String? message;

  Errors({this.code, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}
