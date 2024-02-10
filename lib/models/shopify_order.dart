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

class ShopifyOrder {
  String? customer;
  BillingAddress? billingAddress;
  String? currency;
  List<DiscountCodes>? discountCodes = [];
  String? email;
  String? financialStatus;
  List<LineItems>? lineItems = [];
  String? presentmentCurrency;
  ShippingAddress? shippingAddress;
  List<ShippingLines>? shippingLines = [];
  bool? taxesIncluded;
  bool? test;
  String? totalDiscounts;
  String? totalLineItemsPrice;
  String? totalPrice;
  String? totalTax;
  bool? sendReceipt;
  bool? sendFulfillmentReceipt;
  List<Transaction>? transactions = [];
  List<TaxLines>? taxLines = [];

  ShopifyOrder(
      {this.customer,
      this.billingAddress,
      this.currency,
      this.discountCodes,
      this.email,
      this.financialStatus,
      this.lineItems,
      this.presentmentCurrency,
      this.shippingAddress,
      this.shippingLines,
      this.taxesIncluded,
      this.test,
      this.totalDiscounts,
      this.totalLineItemsPrice,
      this.totalPrice,
      this.totalTax,
      this.taxLines,
      this.sendReceipt,
      this.sendFulfillmentReceipt,
      this.transactions});

  ShopifyOrder.fromJson(Map<String, dynamic> json) {
    billingAddress = json['billing_address'] != null
        ? BillingAddress.fromJson(json['billing_address'])
        : null;
    currency = json['currency'];
    if (json['discount_codes'] != null) {
      discountCodes = [];
      json['discount_codes'].forEach((v) {
        discountCodes!.add(DiscountCodes.fromJson(v));
      });
    }
    email = json['email'];
    financialStatus = json['financial_status'];
    sendFulfillmentReceipt = json['send_fulfillment_receipt'];
    if (json['line_items'] != null) {
      lineItems = [];
      json['line_items'].forEach((v) {
        lineItems!.add(LineItems.fromJson(v));
      });
    }
    sendReceipt = json['send_receipt'];
    if (json['transactions'] != null) {
      transactions = [];
      json['transactions'].forEach((v) {
        transactions!.add(Transaction.fromJson(v));
      });
    }
    if (json['tax_lines'] != null) {
      taxLines = [];
      json['tax_lines'].forEach((v) {
        taxLines!.add(TaxLines.fromJson(v));
      });
    }
    presentmentCurrency = json['presentment_currency'];
    shippingAddress = json['shipping_address'] != null
        ? ShippingAddress.fromJson(json['shipping_address'])
        : null;
    if (json['shipping_lines'] != null) {
      shippingLines = [];
      json['shipping_lines'].forEach((v) {
        shippingLines!.add(ShippingLines.fromJson(v));
      });
    }
    taxesIncluded = json['taxes_included'];
    test = json['test'];
    totalDiscounts = json['total_discounts'];
    totalLineItemsPrice = json['total_line_items_price'];
    totalPrice = json['total_price'];
    totalTax = json['total_tax'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (billingAddress != null) {
      data['billing_address'] = billingAddress!.toJson();
    }
    data['currency'] = currency;
    data['email'] = email;
    data['financial_status'] = financialStatus;
    data['send_fulfillment_receipt'] = sendFulfillmentReceipt;
    if (lineItems != null) {
      data['line_items'] = lineItems!.map((v) => v.toJson()).toList();
    }
    data['presentment_currency'] = presentmentCurrency;
    if (shippingAddress != null) {
      data['shipping_address'] = shippingAddress!.toJson();
    }
    if (shippingLines != null) {
      data['shipping_lines'] = shippingLines!.map((v) => v.toJson()).toList();
    }
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    data['taxes_included'] = taxesIncluded;
    data['test'] = test;
    data['send_receipt'] = sendReceipt;
    if (taxLines != null) {
      data['tax_lines'] = taxLines!.map((v) => v.toJson()).toList();
    }
    if (customer != null) {
      data['customer'] = {"id": customer};
      data.remove('email');
    }
    return {"order": data};
  }
}

class BillingAddress {
  String? address1;
  String? address2;
  String? city;
  String? company;
  String? country;
  String? firstName;
  String? lastName;
  String? phone;
  String? province;
  String? zip;
  String? name;
  String? provinceCode;
  String? countryCode;
  String? latitude;
  String? longitude;

  BillingAddress(
      {this.address1,
      this.address2,
      this.city,
      this.company,
      this.country,
      this.firstName,
      this.lastName,
      this.phone,
      this.province,
      this.zip,
      this.name,
      this.provinceCode,
      this.countryCode,
      this.latitude,
      this.longitude});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    company = json['company'];
    country = json['country'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    province = json['province'];
    zip = json['zip'];
    name = json['name'];
    provinceCode = json['province_code'];
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address1'] = address1;
    data['address2'] = address2;
    data['city'] = city;
    data['company'] = company;
    data['country'] = country;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['province'] = province;
    data['zip'] = zip;
    data['name'] = name;
    data['province_code'] = provinceCode;
    data['country_code'] = countryCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class DiscountCodes {
  String? code;
  String? amount;
  String? type;

  DiscountCodes({this.code, this.amount, this.type});

  DiscountCodes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    amount = json['amount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['amount'] = amount;
    data['type'] = type;
    return data;
  }
}

class LineItems {
  String? price;
  int? productId;
  int? quantity;
  bool? requiresShipping;
  String? sku;
  int? variantId;
  bool? taxable;

  LineItems({
    this.price,
    this.productId,
    this.quantity,
    this.requiresShipping,
    this.sku,
    this.variantId,
    this.taxable,
  });

  LineItems.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    productId = json['product_id'];
    quantity = json['quantity'];
    requiresShipping = json['requires_shipping'];
    sku = json['sku'];
    variantId = json['variant_id'];
    taxable = json['taxable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['requires_shipping'] = requiresShipping;
    if (sku != null) {
      data['sku'] = sku;
    }
    data['variant_id'] = variantId;
    data['taxable'] = taxable;
    return data;
  }
}

class Properties {
  String? name;
  String? value;

  Properties({this.name, this.value});

  Properties.fromJson(Map<String, dynamic> json) {
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

class TaxLines {
  String? title;
  double? price;
  double? rate;

  TaxLines({this.title, this.price, this.rate});

  TaxLines.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['price'] = price;
    data['rate'] = rate;
    return data;
  }
}

class DiscountAllocations {
  String? amount;
  int? discountApplicationIndex;

  DiscountAllocations({this.amount, this.discountApplicationIndex});

  DiscountAllocations.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    discountApplicationIndex = json['discount_application_index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['discount_application_index'] = discountApplicationIndex;
    return data;
  }
}

class OriginLocation {
  int? id;
  String? countryCode;
  String? provinceCode;
  String? name;
  String? address1;
  String? address2;
  String? city;
  String? zip;

  OriginLocation(
      {this.id,
      this.countryCode,
      this.provinceCode,
      this.name,
      this.address1,
      this.address2,
      this.city,
      this.zip});

  OriginLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryCode = json['country_code'];
    provinceCode = json['province_code'];
    name = json['name'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country_code'] = countryCode;
    data['province_code'] = provinceCode;
    data['name'] = name;
    data['address1'] = address1;
    data['address2'] = address2;
    data['city'] = city;
    data['zip'] = zip;
    return data;
  }
}

class ShippingAddress {
  String? address1;
  String? address2;
  String? city;
  String? company;
  String? country;
  String? firstName;
  String? lastName;
  String? latitude;
  String? longitude;
  String? phone;
  String? province;
  String? zip;
  String? name;
  String? countryCode;
  String? provinceCode;

  ShippingAddress(
      {this.address1,
      this.address2,
      this.city,
      this.company,
      this.country,
      this.firstName,
      this.lastName,
      this.latitude,
      this.longitude,
      this.phone,
      this.province,
      this.zip,
      this.name,
      this.countryCode,
      this.provinceCode});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    company = json['company'];
    country = json['country'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phone = json['phone'];
    province = json['province'];
    zip = json['zip'];
    name = json['name'];
    countryCode = json['country_code'];
    provinceCode = json['province_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address1'] = address1;
    data['address2'] = address2;
    data['city'] = city;
    data['company'] = company;
    data['country'] = country;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['phone'] = phone;
    data['province'] = province;
    data['zip'] = zip;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['province_code'] = provinceCode;
    return data;
  }
}

class ShippingLines {
  String? code;
  String? price;
  String? source;
  String? title;
  List<TaxLines>? taxLines;
  String? carrierIdentifier;
  String? requestedFulfillmentServiceId;

  ShippingLines(
      {this.code,
      this.price,
      this.source,
      this.title,
      this.taxLines,
      this.carrierIdentifier,
      this.requestedFulfillmentServiceId});

  ShippingLines.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    price = json['price'];
    source = json['source'];
    title = json['title'];
    if (json['tax_lines'] != null) {
      taxLines = [];
      json['tax_lines'].forEach((v) {
        taxLines!.add(TaxLines.fromJson(v));
      });
    }
    carrierIdentifier = json['carrier_identifier'];
    requestedFulfillmentServiceId = json['requested_fulfillment_service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['price'] = price;
    data['source'] = source;
    data['title'] = title;
    if (taxLines != null) {
      data['tax_lines'] = taxLines!.map((v) => v.toJson()).toList();
    }
    data['carrier_identifier'] = carrierIdentifier;
    data['requested_fulfillment_service_id'] = requestedFulfillmentServiceId;
    return data;
  }
}

class Transaction {
  String? kind;
  String? status;
  String? amount;
  String? currency;
  String? gateway;
  bool? test;

  Transaction(
      {this.kind,
      this.status,
      this.amount,
      this.currency,
      this.gateway,
      this.test});

  Transaction.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    status = json['status'];
    amount = json['amount'];
    currency = json['currency'];
    gateway = json['gateway'];
    test = json['test'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['status'] = status;
    data['amount'] = amount;
    data['currency'] = currency;
    data['test'] = test;
    return data;
  }
}
