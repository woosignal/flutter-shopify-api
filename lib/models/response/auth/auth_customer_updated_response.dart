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

class AuthCustomerUpdateResponse {
  int? status;
  Customer? customer;

  AuthCustomerUpdateResponse({this.status, this.customer});

  AuthCustomerUpdateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class Customer {
  String? email;
  String? firstName;
  String? lastName;
  String? id;
  String? uid;
  DefaultAddress? defaultAddress;

  Customer(
      {this.email,
      this.firstName,
      this.lastName,
      this.id,
      this.uid,
      this.defaultAddress});

  Customer.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    id = json['id'];
    uid = json['uid'];
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
    if (defaultAddress != null) {
      data['defaultAddress'] = defaultAddress!.toJson();
    }
    return data;
  }
}

class DefaultAddress {
  String? address1;
  String? address2;
  String? city;
  String? company;
  String? country;
  String? countryCodeV2;
  String? firstName;
  String? lastName;
  String? formattedArea;
  String? name;
  String? phone;
  String? province;
  String? provinceCode;
  String? zip;

  DefaultAddress(
      {this.address1,
      this.address2,
      this.city,
      this.company,
      this.country,
      this.countryCodeV2,
      this.firstName,
      this.lastName,
      this.formattedArea,
      this.name,
      this.phone,
      this.province,
      this.provinceCode,
      this.zip});

  DefaultAddress.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    company = json['company'];
    country = json['country'];
    countryCodeV2 = json['countryCodeV2'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    formattedArea = json['formattedArea'];
    name = json['name'];
    phone = json['phone'];
    province = json['province'];
    provinceCode = json['provinceCode'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address1'] = address1;
    data['address2'] = address2;
    data['city'] = city;
    data['company'] = company;
    data['country'] = country;
    data['countryCodeV2'] = countryCodeV2;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['formattedArea'] = formattedArea;
    data['name'] = name;
    data['phone'] = phone;
    data['province'] = province;
    data['provinceCode'] = provinceCode;
    data['zip'] = zip;
    return data;
  }
}
