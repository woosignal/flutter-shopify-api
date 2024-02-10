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

import 'package:woosignal_shopify/models/shopify_order.dart';

class ShippingMethod {
  String? code;
  String? price;
  String? title;
  String? name;
  String? carrierIdentifier;
  List<TaxLines>? taxLines = [];

  ShippingMethod(
      {this.code,
      this.price,
      this.title,
      this.name,
      this.carrierIdentifier,
      this.taxLines});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['title'] = title;
    data['name'] = name;
    if (carrierIdentifier != null) {
      data['carrier_identifier'] = carrierIdentifier;
    }
    if (taxLines != null) {
      data['taxLines'] = taxLines!.map((e) => e.toJson());
    }
    return data;
  }
}
