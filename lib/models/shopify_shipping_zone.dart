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

class ShopifyShippingZone {
  List<ShippingZones>? shippingZones;

  ShopifyShippingZone({this.shippingZones});

  ShopifyShippingZone.fromJson(Map<String, dynamic> json) {
    if (json['shipping_zones'] != null) {
      shippingZones = [];
      json['shipping_zones'].forEach((v) {
        shippingZones!.add(ShippingZones.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shippingZones != null) {
      data['shipping_zones'] = shippingZones!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingZones {
  int? id;
  String? name;
  String? profileId;
  String? locationGroupId;
  String? adminGraphqlApiId;
  late List<Countries?> countries;
  List<WeightBasedShippingRates>? weightBasedShippingRates;
  List<PriceBasedShippingRates>? priceBasedShippingRates;
  List<CarrierShippingRateProviders>? carrierShippingRateProviders;

  ShippingZones(
      {this.id,
      this.name,
      this.profileId,
      this.locationGroupId,
      this.adminGraphqlApiId,
      this.countries = const [],
      this.weightBasedShippingRates,
      this.priceBasedShippingRates,
      this.carrierShippingRateProviders});

  ShippingZones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileId = json['profile_id'];
    locationGroupId = json['location_group_id'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
    if (json['countries'] != null) {
      countries = [];
      json['countries'].forEach((v) {
        countries.add(Countries.fromJson(v));
      });
    }
    if (json['weight_based_shipping_rates'] != null) {
      weightBasedShippingRates = [];
      json['weight_based_shipping_rates'].forEach((v) {
        weightBasedShippingRates!.add(WeightBasedShippingRates.fromJson(v));
      });
    }
    if (json['price_based_shipping_rates'] != null) {
      priceBasedShippingRates = [];
      json['price_based_shipping_rates'].forEach((v) {
        priceBasedShippingRates!.add(PriceBasedShippingRates.fromJson(v));
      });
    }
    if (json['carrier_shipping_rate_providers'] != null) {
      carrierShippingRateProviders = [];
      json['carrier_shipping_rate_providers'].forEach((v) {
        carrierShippingRateProviders!
            .add(CarrierShippingRateProviders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['profile_id'] = profileId;
    data['location_group_id'] = locationGroupId;
    data['admin_graphql_api_id'] = adminGraphqlApiId;
    data['countries'] = countries.map((v) => v?.toJson()).toList();
    if (weightBasedShippingRates != null) {
      data['weight_based_shipping_rates'] =
          weightBasedShippingRates!.map((v) => v.toJson()).toList();
    }
    if (priceBasedShippingRates != null) {
      data['price_based_shipping_rates'] =
          priceBasedShippingRates!.map((v) => v.toJson()).toList();
    }
    if (carrierShippingRateProviders != null) {
      data['carrier_shipping_rate_providers'] =
          carrierShippingRateProviders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  int? id;
  String? name;
  double? tax;
  String? code;
  String? taxName;
  int? shippingZoneId;
  late List<Provinces?> provinces;

  Countries(
      {this.id,
      this.name,
      this.tax,
      this.code,
      this.taxName,
      this.shippingZoneId,
      this.provinces = const []});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tax = double.parse((json['tax'] == 0 ? 0.0 : json['tax']).toString());
    code = json['code'];
    taxName = json['tax_name'];
    shippingZoneId = json['shipping_zone_id'];
    if (json['provinces'] != null) {
      provinces = [];
      json['provinces'].forEach((v) {
        provinces.add(Provinces.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tax'] = tax;
    data['code'] = code;
    data['tax_name'] = taxName;
    data['shipping_zone_id'] = shippingZoneId;
    data['provinces'] = provinces.map((v) => v?.toJson()).toList();
    return data;
  }
}

class Provinces {
  int? id;
  int? countryId;
  String? name;
  String? code;
  double? tax;
  String? taxName;
  String? taxType;
  int? taxPercentage;
  int? shippingZoneId;

  Provinces(
      {this.id,
      this.countryId,
      this.name,
      this.code,
      this.tax,
      this.taxName,
      this.taxType,
      this.taxPercentage,
      this.shippingZoneId});

  Provinces.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    code = json['code'];
    tax = double.parse((json['tax'] == 0 ? 0.0 : json['tax']).toString());
    taxName = json['tax_name'];
    taxType = json['tax_type'];
    taxPercentage = json['tax_percentage'];
    shippingZoneId = json['shipping_zone_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country_id'] = countryId;
    data['name'] = name;
    data['code'] = code;
    data['tax'] = tax;
    data['tax_name'] = taxName;
    data['tax_type'] = taxType;
    data['tax_percentage'] = taxPercentage;
    data['shipping_zone_id'] = shippingZoneId;
    return data;
  }
}

class WeightBasedShippingRates {
  int? id;
  String? name;
  String? price;
  int? shippingZoneId;
  int? weightLow;
  int? weightHigh;

  WeightBasedShippingRates(
      {this.id,
      this.name,
      this.price,
      this.shippingZoneId,
      this.weightLow,
      this.weightHigh});

  WeightBasedShippingRates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    shippingZoneId = json['shipping_zone_id'];
    weightLow = json['weight_low'];
    weightHigh = json['weight_high'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['shipping_zone_id'] = shippingZoneId;
    data['weight_low'] = weightLow;
    data['weight_high'] = weightHigh;
    return data;
  }
}

class PriceBasedShippingRates {
  int? id;
  String? name;
  String? price;
  int? shippingZoneId;
  String? minOrderSubtotal;
  String? maxOrderSubtotal;

  PriceBasedShippingRates(
      {this.id,
      this.name,
      this.price,
      this.shippingZoneId,
      this.minOrderSubtotal,
      this.maxOrderSubtotal});

  PriceBasedShippingRates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    shippingZoneId = json['shipping_zone_id'];
    minOrderSubtotal = json['min_order_subtotal'];
    maxOrderSubtotal = json['max_order_subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['shipping_zone_id'] = shippingZoneId;
    data['min_order_subtotal'] = minOrderSubtotal;
    data['max_order_subtotal'] = maxOrderSubtotal;
    return data;
  }
}

class CarrierShippingRateProviders {
  int? id;
  int? carrierServiceId;
  String? flatModifier;
  String? percentModifier;
  ServiceFilter? serviceFilter;
  int? shippingZoneId;

  CarrierShippingRateProviders(
      {this.id,
      this.carrierServiceId,
      this.flatModifier,
      this.percentModifier,
      this.serviceFilter,
      this.shippingZoneId});

  CarrierShippingRateProviders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carrierServiceId = json['carrier_service_id'];
    flatModifier = json['flat_modifier'];
    percentModifier = json['percent_modifier'];
    serviceFilter = json['service_filter'] != null
        ? ServiceFilter.fromJson(json['service_filter'])
        : null;
    shippingZoneId = json['shipping_zone_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['carrier_service_id'] = carrierServiceId;
    data['flat_modifier'] = flatModifier;
    data['percent_modifier'] = percentModifier;
    if (serviceFilter != null) {
      data['service_filter'] = serviceFilter!.toJson();
    }
    data['shipping_zone_id'] = shippingZoneId;
    return data;
  }
}

class ServiceFilter {
  String? d;

  ServiceFilter({this.d});

  ServiceFilter.fromJson(Map<String, dynamic> json) {
    d = json['d'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['d'] = d;
    return data;
  }
}
