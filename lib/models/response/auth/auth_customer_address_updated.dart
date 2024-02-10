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

class AuthCustomerAddressUpdated {
  int? status;
  Customer? customer;

  AuthCustomerAddressUpdated({this.status, this.customer});

  AuthCustomerAddressUpdated.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  /// Converts the [AuthCustomerAddressUpdated] to a map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }

  /// Check if the request was successful
  bool isSuccessful() {
    return status == 200;
  }
}

class Customer {
  CustomerAddress? customerAddress;
  List<dynamic>? customerUserErrors;
  List<dynamic>? userErrors;

  Customer({this.customerAddress, this.customerUserErrors, this.userErrors});

  Customer.fromJson(Map<String, dynamic> json) {
    customerAddress = json['customerAddress'] != null
        ? CustomerAddress.fromJson(json['customerAddress'])
        : null;
    if (json['customerUserErrors'] != null) {
      customerUserErrors = json['customerUserErrors'];
    }
    if (json['userErrors'] != null) {
      userErrors = json['userErrors'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerAddress != null) {
      data['customerAddress'] = customerAddress!.toJson();
    }
    if (customerUserErrors != null) {
      data['customerUserErrors'] =
          customerUserErrors!.map((v) => v.toJson()).toList();
    }
    if (userErrors != null) {
      data['userErrors'] = userErrors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerAddress {
  String? id;
  String? firstName;
  String? lastName;
  String? address1;
  String? city;
  String? country;
  String? province;
  String? phone;
  String? zip;

  CustomerAddress(
      {this.id,
      this.firstName,
      this.lastName,
      this.address1,
      this.city,
      this.country,
      this.province,
      this.phone,
      this.zip});

  CustomerAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    address1 = json['address1'];
    city = json['city'];
    country = json['country'];
    province = json['province'];
    phone = json['phone'];
    zip = json['zip'];
  }

  /// Converts the [CustomerAddress] to a map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['address1'] = address1;
    data['city'] = city;
    data['country'] = country;
    data['province'] = province;
    data['phone'] = phone;
    data['zip'] = zip;
    return data;
  }
}
