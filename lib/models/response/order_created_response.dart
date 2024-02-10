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

class OrderCreatedResponse {
  Order? order;
  String? pageLink;

  OrderCreatedResponse({this.order, this.pageLink});

  OrderCreatedResponse.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    pageLink = json['page_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (order != null) {
      data['order'] = order!.toJson();
    }
    data['page_link'] = pageLink;
    return data;
  }
}

class Order {
  int? id;
  String? email;
  String? closedAt;
  String? createdAt;
  String? updatedAt;
  int? number;
  String? note;
  String? token;
  String? gateway;
  bool? test;
  String? totalPrice;
  String? subtotalPrice;
  int? totalWeight;
  String? totalTax;
  bool? taxesIncluded;
  String? currency;
  String? financialStatus;
  bool? confirmed;
  String? totalDiscounts;
  String? totalLineItemsPrice;
  String? cartToken;
  bool? buyerAcceptsMarketing;
  String? name;
  String? referringSite;
  String? landingSite;
  String? totalPriceUsd;
  String? checkoutToken;
  int? userId;
  int? locationId;
  String? processedAt;
  String? phone;
  String? customerLocale;
  int? appId;
  int? orderNumber;
  List<void>? discountApplications;
  List<void>? discountCodes;
  List<void>? noteAttributes;
  String? processingMethod;
  int? checkoutId;
  String? sourceName;
  String? fulfillmentStatus;
  List<void>? taxLines;
  String? tags;
  String? contactEmail;
  String? orderStatusUrl;
  String? presentmentCurrency;
  List<LineItems>? lineItems;
  String? adminGraphqlApiId;
  List<void>? shippingLines;
  BillingAddress? billingAddress;
  BillingAddress? shippingAddress;
  Customer? customer;

  Order(
      {this.id,
      this.email,
      this.closedAt,
      this.createdAt,
      this.updatedAt,
      this.number,
      this.note,
      this.token,
      this.gateway,
      this.test,
      this.totalPrice,
      this.subtotalPrice,
      this.totalWeight,
      this.totalTax,
      this.taxesIncluded,
      this.currency,
      this.financialStatus,
      this.confirmed,
      this.totalDiscounts,
      this.totalLineItemsPrice,
      this.cartToken,
      this.buyerAcceptsMarketing,
      this.name,
      this.referringSite,
      this.landingSite,
      this.totalPriceUsd,
      this.checkoutToken,
      this.userId,
      this.locationId,
      this.processedAt,
      this.phone,
      this.customerLocale,
      this.appId,
      this.orderNumber,
      this.discountApplications,
      this.discountCodes,
      this.noteAttributes,
      this.processingMethod,
      this.checkoutId,
      this.sourceName,
      this.fulfillmentStatus,
      this.taxLines,
      this.tags,
      this.contactEmail,
      this.orderStatusUrl,
      this.presentmentCurrency,
      this.lineItems,
      this.adminGraphqlApiId,
      this.shippingLines,
      this.billingAddress,
      this.shippingAddress,
      this.customer});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    closedAt = json['closed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    number = json['number'];
    note = json['note'];
    token = json['token'];
    gateway = json['gateway'];
    test = json['test'];
    totalPrice = json['total_price'];
    subtotalPrice = json['subtotal_price'];
    totalWeight = json['total_weight'];
    totalTax = json['total_tax'];
    taxesIncluded = json['taxes_included'];
    currency = json['currency'];
    financialStatus = json['financial_status'];
    confirmed = json['confirmed'];
    totalDiscounts = json['total_discounts'];
    totalLineItemsPrice = json['total_line_items_price'];
    cartToken = json['cart_token'];
    buyerAcceptsMarketing = json['buyer_accepts_marketing'];
    name = json['name'];
    referringSite = json['referring_site'];
    landingSite = json['landing_site'];
    totalPriceUsd = json['total_price_usd'];
    checkoutToken = json['checkout_token'];
    userId = json['user_id'];
    locationId = json['location_id'];
    processedAt = json['processed_at'];
    phone = json['phone'];
    customerLocale = json['customer_locale'];
    appId = json['app_id'];
    orderNumber = json['order_number'];
    processingMethod = json['processing_method'];
    checkoutId = json['checkout_id'];
    sourceName = json['source_name'];
    fulfillmentStatus = json['fulfillment_status'];
    tags = json['tags'];
    contactEmail = json['contact_email'];
    orderStatusUrl = json['order_status_url'];
    presentmentCurrency = json['presentment_currency'];
    if (json['line_items'] != null) {
      lineItems = [];
      json['line_items'].forEach((v) {
        lineItems!.add(LineItems.fromJson(v));
      });
    }
    adminGraphqlApiId = json['admin_graphql_api_id'];
    billingAddress = json['billing_address'] != null
        ? BillingAddress.fromJson(json['billing_address'])
        : null;
    shippingAddress = json['shipping_address'] != null
        ? BillingAddress.fromJson(json['shipping_address'])
        : null;
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['closed_at'] = closedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['number'] = number;
    data['note'] = note;
    data['token'] = token;
    data['gateway'] = gateway;
    data['test'] = test;
    data['total_price'] = totalPrice;
    data['subtotal_price'] = subtotalPrice;
    data['total_weight'] = totalWeight;
    data['total_tax'] = totalTax;
    data['taxes_included'] = taxesIncluded;
    data['currency'] = currency;
    data['financial_status'] = financialStatus;
    data['confirmed'] = confirmed;
    data['total_discounts'] = totalDiscounts;
    data['total_line_items_price'] = totalLineItemsPrice;
    data['cart_token'] = cartToken;
    data['buyer_accepts_marketing'] = buyerAcceptsMarketing;
    data['name'] = name;
    data['referring_site'] = referringSite;
    data['landing_site'] = landingSite;
    data['total_price_usd'] = totalPriceUsd;
    data['checkout_token'] = checkoutToken;
    data['user_id'] = userId;
    data['location_id'] = locationId;
    data['processed_at'] = processedAt;
    data['phone'] = phone;
    data['customer_locale'] = customerLocale;
    data['app_id'] = appId;
    data['order_number'] = orderNumber;
    // if (this.discountApplications != null) {
    //   data['discount_applications'] =
    //       this.discountApplications.map((v) => v.toJson()).toList();
    // }
    // if (this.discountCodes != null) {
    //   data['discount_codes'] =
    //       this.discountCodes.map((v) => v.toJson()).toList();
    // }
    // if (this.noteAttributes != null) {
    //   data['note_attributes'] =
    //       this.noteAttributes.map((v) => v.toJson()).toList();
    // }
    data['processing_method'] = processingMethod;
    data['checkout_id'] = checkoutId;
    data['source_name'] = sourceName;
    data['fulfillment_status'] = fulfillmentStatus;
    // if (this.taxLines != null) {
    //   data['tax_lines'] = this.taxLines.map((v) => v.toJson()).toList();
    // }
    data['tags'] = tags;
    data['contact_email'] = contactEmail;
    data['order_status_url'] = orderStatusUrl;
    data['presentment_currency'] = presentmentCurrency;
    if (lineItems != null) {
      data['line_items'] = lineItems!.map((v) => v.toJson()).toList();
    }
    data['admin_graphql_api_id'] = adminGraphqlApiId;
    // if (this.shippingLines != null) {
    //   data['shipping_lines'] =
    //       this.shippingLines.map((v) => v.toJson()).toList();
    // }
    if (billingAddress != null) {
      data['billing_address'] = billingAddress!.toJson();
    }
    if (shippingAddress != null) {
      data['shipping_address'] = shippingAddress!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class LineItems {
  int? id;
  int? variantId;
  String? title;
  int? quantity;
  String? sku;
  String? variantTitle;
  String? vendor;
  String? fulfillmentService;
  int? productId;
  bool? requiresShipping;
  bool? taxable;
  bool? giftCard;
  String? name;
  String? variantInventoryManagement;
  List<void>? properties;
  bool? productExists;
  int? fulfillableQuantity;
  int? grams;
  String? price;
  String? totalDiscount;
  String? fulfillmentStatus;
  List<void>? discountAllocations;
  List<void>? duties;
  String? adminGraphqlApiId;
  List<void>? taxLines;

  LineItems(
      {this.id,
      this.variantId,
      this.title,
      this.quantity,
      this.sku,
      this.variantTitle,
      this.vendor,
      this.fulfillmentService,
      this.productId,
      this.requiresShipping,
      this.taxable,
      this.giftCard,
      this.name,
      this.variantInventoryManagement,
      this.properties,
      this.productExists,
      this.fulfillableQuantity,
      this.grams,
      this.price,
      this.totalDiscount,
      this.fulfillmentStatus,
      this.discountAllocations,
      this.duties,
      this.adminGraphqlApiId,
      this.taxLines});

  LineItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    variantId = json['variant_id'];
    title = json['title'];
    quantity = json['quantity'];
    sku = json['sku'];
    variantTitle = json['variant_title'];
    vendor = json['vendor'];
    fulfillmentService = json['fulfillment_service'];
    productId = json['product_id'];
    requiresShipping = json['requires_shipping'];
    taxable = json['taxable'];
    giftCard = json['gift_card'];
    name = json['name'];
    variantInventoryManagement = json['variant_inventory_management'];
    productExists = json['product_exists'];
    fulfillableQuantity = json['fulfillable_quantity'];
    grams = json['grams'];
    price = json['price'];
    totalDiscount = json['total_discount'];
    fulfillmentStatus = json['fulfillment_status'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['variant_id'] = variantId;
    data['title'] = title;
    data['quantity'] = quantity;
    data['sku'] = sku;
    data['variant_title'] = variantTitle;
    data['vendor'] = vendor;
    data['fulfillment_service'] = fulfillmentService;
    data['product_id'] = productId;
    data['requires_shipping'] = requiresShipping;
    data['taxable'] = taxable;
    data['gift_card'] = giftCard;
    data['name'] = name;
    data['variant_inventory_management'] = variantInventoryManagement;
    data['product_exists'] = productExists;
    data['fulfillable_quantity'] = fulfillableQuantity;
    data['grams'] = grams;
    data['price'] = price;
    data['total_discount'] = totalDiscount;
    data['fulfillment_status'] = fulfillmentStatus;
    data['admin_graphql_api_id'] = adminGraphqlApiId;
    return data;
  }
}

class BillingAddress {
  String? firstName;
  String? address1;
  String? phone;
  String? city;
  String? zip;
  String? province;
  String? country;
  String? lastName;
  String? address2;
  String? company;
  double? latitude;
  double? longitude;
  String? name;
  String? countryCode;
  String? provinceCode;

  BillingAddress(
      {this.firstName,
      this.address1,
      this.phone,
      this.city,
      this.zip,
      this.province,
      this.country,
      this.lastName,
      this.address2,
      this.company,
      this.latitude,
      this.longitude,
      this.name,
      this.countryCode,
      this.provinceCode});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    address1 = json['address1'];
    phone = json['phone'];
    city = json['city'];
    zip = json['zip'];
    province = json['province'];
    country = json['country'];
    lastName = json['last_name'];
    address2 = json['address2'];
    company = json['company'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    countryCode = json['country_code'];
    provinceCode = json['province_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['address1'] = address1;
    data['phone'] = phone;
    data['city'] = city;
    data['zip'] = zip;
    data['province'] = province;
    data['country'] = country;
    data['last_name'] = lastName;
    data['address2'] = address2;
    data['company'] = company;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['province_code'] = provinceCode;
    return data;
  }
}

class Customer {
  int? id;
  String? email;
  bool? acceptsMarketing;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  int? ordersCount;
  String? state;
  String? totalSpent;
  String? note;
  bool? verifiedEmail;
  bool? taxExempt;
  String? phone;
  String? tags;
  String? currency;
  String? acceptsMarketingUpdatedAt;
  List<void>? taxExemptions;

  Customer(
      {this.id,
      this.email,
      this.acceptsMarketing,
      this.createdAt,
      this.updatedAt,
      this.firstName,
      this.lastName,
      this.ordersCount,
      this.state,
      this.totalSpent,
      this.note,
      this.verifiedEmail,
      this.taxExempt,
      this.phone,
      this.tags,
      this.currency,
      this.acceptsMarketingUpdatedAt,
      this.taxExemptions});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    acceptsMarketing = json['accepts_marketing'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    ordersCount = json['orders_count'];
    state = json['state'];
    totalSpent = json['total_spent'];
    note = json['note'];
    verifiedEmail = json['verified_email'];
    taxExempt = json['tax_exempt'];
    phone = json['phone'];
    tags = json['tags'];
    currency = json['currency'];
    acceptsMarketingUpdatedAt = json['accepts_marketing_updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['accepts_marketing'] = acceptsMarketing;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['orders_count'] = ordersCount;
    data['state'] = state;
    data['total_spent'] = totalSpent;
    data['note'] = note;
    data['verified_email'] = verifiedEmail;
    data['tax_exempt'] = taxExempt;
    data['phone'] = phone;
    data['tags'] = tags;
    data['currency'] = currency;
    data['accepts_marketing_updated_at'] = acceptsMarketingUpdatedAt;
    return data;
  }
}
