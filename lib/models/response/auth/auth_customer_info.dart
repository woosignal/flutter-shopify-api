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

/// The [AuthCustomerInfo] class holds the customer's information
class AuthCustomerInfo {
  String? email;
  String? firstName;
  String? lastName;
  String? id;
  String? phone;
  String? uid;
  DefaultAddress? defaultAddress;

  AuthCustomerInfo(
      {this.email,
      this.firstName,
      this.lastName,
      this.id,
      this.uid,
      this.phone,
      this.defaultAddress});

  AuthCustomerInfo.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) {
      return;
    }
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    id = json['id'];
    uid = json['uid'];
    phone = json['phone'];
    defaultAddress = json['defaultAddress'] != null
        ? DefaultAddress.fromJson(json['defaultAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['id'] = id;
    data['uid'] = uid;
    data['phone'] = phone;
    if (defaultAddress != null) {
      data['defaultAddress'] = defaultAddress!.toJson();
    }
    return data;
  }
}

/// Default address of the customer
class DefaultAddress {
  String? id;
  String? address1;
  String? city;
  String? country;
  String? province;
  String? phone;
  String? provinceCode;
  String? countryCode;
  String? zip;

  DefaultAddress(
      {this.id,
      this.address1,
      this.city,
      this.country,
      this.province,
      this.provinceCode,
      this.phone,
      this.countryCode,
      this.zip});

  /// Parses JSON data to [DefaultAddress]
  DefaultAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address1 = json['address1'];
    city = json['city'];
    country = json['country'];
    province = json['province'];
    provinceCode = json['provinceCode'];
    countryCode = json['countryCode'];
    phone = json['phone'];
    zip = json['zip'];
  }

  /// Converts the [DefaultAddress] to a map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address1'] = address1;
    data['city'] = city;
    data['country'] = country;
    data['province'] = province;
    data['provinceCode'] = provinceCode;
    data['countryCode'] = countryCode;
    data['phone'] = phone;
    data['zip'] = zip;
    return data;
  }
}
