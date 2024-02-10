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

class DiscountCode {
  int? id;
  int? priceRuleId;
  String? code;
  int? usageCount;
  String? createdAt;
  String? updatedAt;

  DiscountCode({
    this.id,
    this.priceRuleId,
    this.code,
    this.usageCount,
    this.createdAt,
    this.updatedAt,
  });

  DiscountCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priceRuleId = json['price_rule_id'];
    code = json['code']?.toString();
    usageCount = json['usage_count'];
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price_rule_id': priceRuleId,
      'code': code,
      'usage_count': usageCount,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
