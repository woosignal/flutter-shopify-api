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

class PriceRuleResponse {
  PriceRule? priceRule;

  PriceRuleResponse({this.priceRule});

  PriceRuleResponse.fromJson(Map<String, dynamic> json) {
    priceRule = json['price_rule'] != null
        ? PriceRule.fromJson(json['price_rule'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (priceRule != null) {
      data['price_rule'] = priceRule!.toJson();
    }
    return data;
  }
}

class PriceRule {
  int? id;
  String? valueType;
  String? value;
  String? customerSelection;
  String? targetType;
  String? targetSelection;
  String? allocationMethod;
  int? allocationLimit;
  bool? oncePerCustomer;
  int? usageLimit;
  String? startsAt;
  String? endsAt;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? adminGraphqlApiId;
  List<int>? entitledCollectionIds;
  EntitledCountryIds? entitledCountryIds;
  List<int>? entitledProductIds;
  List<int>? entitledVariantIds;
  List<int>? prerequisiteCustomerIds;
  PrerequisiteQuantityRange? prerequisiteQuantityRange;
  List<int>? customerSegmentPrerequisiteIds;
  PrerequisiteShippingPriceRange? prerequisiteShippingPriceRange;
  PrerequisiteSubtotalRange? prerequisiteSubtotalRange;
  PrerequisiteToEntitlementPurchase? prerequisiteToEntitlementPurchase;
  List<int>? prerequisiteProductIds;
  List<int>? prerequisiteVariantIds;
  List<int>? prerequisiteCollectionIds;
  PrerequisiteToEntitlementQuantityRatio?
      prerequisiteToEntitlementQuantityRatio;

  PriceRule(
      {this.id,
      this.valueType,
      this.value,
      this.customerSelection,
      this.targetType,
      this.targetSelection,
      this.allocationMethod,
      this.allocationLimit,
      this.oncePerCustomer,
      this.usageLimit,
      this.startsAt,
      this.endsAt,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.adminGraphqlApiId,
      this.entitledCollectionIds,
      this.entitledCountryIds,
      this.entitledProductIds,
      this.entitledVariantIds,
      this.prerequisiteCustomerIds,
      this.prerequisiteQuantityRange,
      this.customerSegmentPrerequisiteIds,
      this.prerequisiteShippingPriceRange,
      this.prerequisiteSubtotalRange,
      this.prerequisiteToEntitlementPurchase,
      this.prerequisiteProductIds,
      this.prerequisiteVariantIds,
      this.prerequisiteCollectionIds,
      this.prerequisiteToEntitlementQuantityRatio});

  PriceRule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    valueType = json['value_type'];
    value = json['value'];
    customerSelection = json['customer_selection'];
    targetType = json['target_type'];
    targetSelection = json['target_selection'];
    allocationMethod = json['allocation_method'];
    allocationLimit = json['allocation_limit'];
    oncePerCustomer = json['once_per_customer'];
    usageLimit = json['usage_limit'];
    startsAt = json['starts_at'];
    endsAt = json['ends_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
    entitledCollectionIds = json['entitled_collection_ids'].cast<int>();
    entitledCountryIds = json['entitled_country_ids'] != null
        ? EntitledCountryIds.fromJson(json['entitled_country_ids'])
        : null;
    entitledProductIds = json['entitled_product_ids'].cast<int>();
    entitledVariantIds = json['entitled_variant_ids'].cast<int>();
    prerequisiteCustomerIds = json['prerequisite_customer_ids'].cast<int>();
    prerequisiteQuantityRange = json['prerequisite_quantity_range'] != null
        ? PrerequisiteQuantityRange.fromJson(
            json['prerequisite_quantity_range'])
        : null;
    customerSegmentPrerequisiteIds =
        json['customer_segment_prerequisite_ids'].cast<int>();
    prerequisiteShippingPriceRange =
        json['prerequisite_shipping_price_range'] != null
            ? PrerequisiteShippingPriceRange.fromJson(
                json['prerequisite_shipping_price_range'])
            : null;
    prerequisiteSubtotalRange = json['prerequisite_subtotal_range'] != null
        ? PrerequisiteSubtotalRange.fromJson(
            json['prerequisite_subtotal_range'])
        : null;
    prerequisiteToEntitlementPurchase =
        json['prerequisite_to_entitlement_purchase'] != null
            ? PrerequisiteToEntitlementPurchase.fromJson(
                json['prerequisite_to_entitlement_purchase'])
            : null;
    prerequisiteProductIds = json['prerequisite_product_ids'].cast<int>();
    prerequisiteVariantIds = json['prerequisite_variant_ids'].cast<int>();
    prerequisiteCollectionIds = json['prerequisite_collection_ids'].cast<int>();
    prerequisiteToEntitlementQuantityRatio =
        json['prerequisite_to_entitlement_quantity_ratio'] != null
            ? PrerequisiteToEntitlementQuantityRatio.fromJson(
                json['prerequisite_to_entitlement_quantity_ratio'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value_type'] = valueType;
    data['value'] = value;
    data['customer_selection'] = customerSelection;
    data['target_type'] = targetType;
    data['target_selection'] = targetSelection;
    data['allocation_method'] = allocationMethod;
    data['allocation_limit'] = allocationLimit;
    data['once_per_customer'] = oncePerCustomer;
    data['usage_limit'] = usageLimit;
    data['starts_at'] = startsAt;
    data['ends_at'] = endsAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['title'] = title;
    data['admin_graphql_api_id'] = adminGraphqlApiId;
    data['entitled_collection_ids'] = entitledCollectionIds;
    if (entitledCountryIds != null) {
      data['entitled_country_ids'] = entitledCountryIds!.toJson();
    }
    data['entitled_product_ids'] = entitledProductIds;
    data['entitled_variant_ids'] = entitledVariantIds;
    data['prerequisite_customer_ids'] = prerequisiteCustomerIds;
    if (prerequisiteQuantityRange != null) {
      data['prerequisite_quantity_range'] = prerequisiteQuantityRange!.toJson();
    }
    data['customer_segment_prerequisite_ids'] = customerSegmentPrerequisiteIds;
    if (prerequisiteShippingPriceRange != null) {
      data['prerequisite_shipping_price_range'] =
          prerequisiteShippingPriceRange!.toJson();
    }
    if (prerequisiteSubtotalRange != null) {
      data['prerequisite_subtotal_range'] = prerequisiteSubtotalRange!.toJson();
    }
    if (prerequisiteToEntitlementPurchase != null) {
      data['prerequisite_to_entitlement_purchase'] =
          prerequisiteToEntitlementPurchase!.toJson();
    }
    data['prerequisite_product_ids'] = prerequisiteProductIds;
    data['prerequisite_variant_ids'] = prerequisiteVariantIds;
    data['prerequisite_collection_ids'] = prerequisiteCollectionIds;
    if (prerequisiteToEntitlementQuantityRatio != null) {
      data['prerequisite_to_entitlement_quantity_ratio'] =
          prerequisiteToEntitlementQuantityRatio!.toJson();
    }
    return data;
  }
}

class EntitledCountryIds {
  List<int>? entitledCountryIds;

  EntitledCountryIds({this.entitledCountryIds});

  EntitledCountryIds.fromJson(Map<String, dynamic> json) {
    entitledCountryIds = json[' entitled_country_ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' entitled_country_ids'] = entitledCountryIds;
    return data;
  }
}

class PrerequisiteQuantityRange {
  int? greaterThanOrEqualTo;

  PrerequisiteQuantityRange({this.greaterThanOrEqualTo});

  PrerequisiteQuantityRange.fromJson(Map<String, dynamic> json) {
    greaterThanOrEqualTo = json['greater_than_or_equal_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['greater_than_or_equal_to'] = greaterThanOrEqualTo;
    return data;
  }
}

class PrerequisiteShippingPriceRange {
  String? lessThanOrEqualTo;

  PrerequisiteShippingPriceRange({this.lessThanOrEqualTo});

  PrerequisiteShippingPriceRange.fromJson(Map<String, dynamic> json) {
    lessThanOrEqualTo = json['less_than_or_equal_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['less_than_or_equal_to'] = lessThanOrEqualTo;
    return data;
  }
}

class PrerequisiteSubtotalRange {
  String? greaterThanOrEqualTo;

  PrerequisiteSubtotalRange({this.greaterThanOrEqualTo});

  PrerequisiteSubtotalRange.fromJson(Map<String, dynamic> json) {
    greaterThanOrEqualTo = json['greater_than_or_equal_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['greater_than_or_equal_to'] = greaterThanOrEqualTo;
    return data;
  }
}

class PrerequisiteToEntitlementPurchase {
  String? prerequisiteAmount;

  PrerequisiteToEntitlementPurchase({this.prerequisiteAmount});

  PrerequisiteToEntitlementPurchase.fromJson(Map<String, dynamic> json) {
    prerequisiteAmount = json['prerequisite_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prerequisite_amount'] = prerequisiteAmount;
    return data;
  }
}

class PrerequisiteToEntitlementQuantityRatio {
  int? prerequisiteQuantity;
  int? entitledQuantity;

  PrerequisiteToEntitlementQuantityRatio(
      {this.prerequisiteQuantity, this.entitledQuantity});

  PrerequisiteToEntitlementQuantityRatio.fromJson(Map<String, dynamic> json) {
    prerequisiteQuantity = json['prerequisite_quantity'];
    entitledQuantity = json['entitled_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prerequisite_quantity'] = prerequisiteQuantity;
    data['entitled_quantity'] = entitledQuantity;
    return data;
  }
}
