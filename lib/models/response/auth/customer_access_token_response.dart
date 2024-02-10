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

class AuthCustomerAccessToken {
  CustomerAccessToken? customerAccessToken;
  List<CustomerUserErrors>? customerUserErrors;

  AuthCustomerAccessToken({this.customerAccessToken, this.customerUserErrors});

  AuthCustomerAccessToken.fromJson(Map<String, dynamic> json) {
    customerAccessToken = json['customerAccessToken'] != null
        ? CustomerAccessToken.fromJson(json['customerAccessToken'])
        : null;
    if (json['customerUserErrors'] != null) {
      customerUserErrors = <CustomerUserErrors>[];
      json['customerUserErrors'].forEach((v) {
        customerUserErrors!.add(CustomerUserErrors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerAccessToken != null) {
      data['customerAccessToken'] = customerAccessToken!.toJson();
    }
    if (customerUserErrors != null) {
      data['customerUserErrors'] =
          customerUserErrors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerAccessToken {
  String? accessToken;
  String? expiresAt;

  CustomerAccessToken({this.accessToken, this.expiresAt});

  CustomerAccessToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['expiresAt'] = expiresAt;
    return data;
  }
}

class CustomerUserErrors {
  String? code;
  String? field;
  String? message;

  CustomerUserErrors({this.code, this.field, this.message});

  CustomerUserErrors.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    field = json['field'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['field'] = field;
    data['message'] = message;
    return data;
  }
}
