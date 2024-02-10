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

class ShopifyCountryResponse {
  List<ShopifyCountry>? countries;

  ShopifyCountryResponse({this.countries});

  ShopifyCountryResponse.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <ShopifyCountry>[];
      json['countries'].forEach((v) {
        countries!.add(ShopifyCountry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopifyCountry {
  int? id;
  String? name;
  String? code;
  String? taxName;
  double? tax;
  List<Provinces>? provinces;

  ShopifyCountry(
      {this.id, this.name, this.code, this.taxName, this.tax, this.provinces});

  ShopifyCountry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    taxName = json['tax_name'];
    tax = double.parse(json['tax'].toString());
    if (json['provinces'] != null) {
      provinces = <Provinces>[];
      json['provinces'].forEach((v) {
        provinces!.add(Provinces.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['tax_name'] = taxName;
    data['tax'] = tax;
    if (provinces != null) {
      data['provinces'] = provinces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Provinces {
  int? id;
  int? countryId;
  String? name;
  String? code;
  String? taxName;
  String? taxType;
  int? shippingZoneId;
  double? tax;
  double? taxPercentage;

  Provinces(
      {this.id,
      this.countryId,
      this.name,
      this.code,
      this.taxName,
      this.taxType,
      this.shippingZoneId,
      this.tax,
      this.taxPercentage});

  Provinces.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    code = json['code'];
    taxName = json['tax_name'];
    taxType = json['tax_type'];
    shippingZoneId = json['shipping_zone_id'];
    tax = double.parse(json['tax'].toString());
    taxPercentage = double.parse(json['tax_percentage'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country_id'] = countryId;
    data['name'] = name;
    data['code'] = code;
    data['tax_name'] = taxName;
    data['tax_type'] = taxType;
    data['shipping_zone_id'] = shippingZoneId;
    data['tax'] = tax;
    data['tax_percentage'] = taxPercentage;
    return data;
  }
}
