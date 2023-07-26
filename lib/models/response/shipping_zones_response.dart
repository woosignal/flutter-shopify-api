class ShippingZonesResponse {
  List<ShippingZone>? shippingZones;

  ShippingZonesResponse({
    this.shippingZones,
  });

  factory ShippingZonesResponse.fromJson(Map<String, dynamic> json) => ShippingZonesResponse(
    shippingZones: json["shipping_zones"] == null ? [] : List<ShippingZone>.from(json["shipping_zones"]!.map((x) => ShippingZone.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "shipping_zones": shippingZones == null ? [] : List<dynamic>.from(shippingZones!.map((x) => x.toJson())),
  };
}

class ShippingZone {
  int? id;
  String? name;
  String? profileId;
  String? locationGroupId;
  String? adminGraphqlApiId;
  List<Country>? countries;
  List<dynamic>? weightBasedShippingRates;
  List<PriceBasedShippingRate>? priceBasedShippingRates;
  List<dynamic>? carrierShippingRateProviders;

  ShippingZone({
    this.id,
    this.name,
    this.profileId,
    this.locationGroupId,
    this.adminGraphqlApiId,
    this.countries,
    this.weightBasedShippingRates,
    this.priceBasedShippingRates,
    this.carrierShippingRateProviders,
  });

  factory ShippingZone.fromJson(Map<String, dynamic> json) => ShippingZone(
    id: json["id"],
    name: json["name"],
    profileId: json["profile_id"],
    locationGroupId: json["location_group_id"],
    adminGraphqlApiId: json["admin_graphql_api_id"],
    countries: json["countries"] == null ? [] : List<Country>.from(json["countries"]!.map((x) => Country.fromJson(x))),
    weightBasedShippingRates: json["weight_based_shipping_rates"] == null ? [] : List<dynamic>.from(json["weight_based_shipping_rates"]!.map((x) => x)),
    priceBasedShippingRates: json["price_based_shipping_rates"] == null ? [] : List<PriceBasedShippingRate>.from(json["price_based_shipping_rates"]!.map((x) => PriceBasedShippingRate.fromJson(x))),
    carrierShippingRateProviders: json["carrier_shipping_rate_providers"] == null ? [] : List<dynamic>.from(json["carrier_shipping_rate_providers"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_id": profileId,
    "location_group_id": locationGroupId,
    "admin_graphql_api_id": adminGraphqlApiId,
    "countries": countries == null ? [] : List<dynamic>.from(countries!.map((x) => x.toJson())),
    "weight_based_shipping_rates": weightBasedShippingRates == null ? [] : List<dynamic>.from(weightBasedShippingRates!.map((x) => x)),
    "price_based_shipping_rates": priceBasedShippingRates == null ? [] : List<dynamic>.from(priceBasedShippingRates!.map((x) => x.toJson())),
    "carrier_shipping_rate_providers": carrierShippingRateProviders == null ? [] : List<dynamic>.from(carrierShippingRateProviders!.map((x) => x)),
  };
}

class Country {
  int? id;
  String? name;
  double? tax;
  String? code;
  String? taxName;
  int? shippingZoneId;
  List<Province>? provinces;

  Country({
    this.id,
    this.name,
    this.tax,
    this.code,
    this.taxName,
    this.shippingZoneId,
    this.provinces,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    tax: json["tax"]?.toDouble(),
    code: json["code"],
    taxName: json["tax_name"],
    shippingZoneId: json["shipping_zone_id"],
    provinces: json["provinces"] == null ? [] : List<Province>.from(json["provinces"]!.map((x) => Province.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "tax": tax,
    "code": code,
    "tax_name": taxName,
    "shipping_zone_id": shippingZoneId,
    "provinces": provinces == null ? [] : List<dynamic>.from(provinces!.map((x) => x.toJson())),
  };
}

class Province {
  int? id;
  int? countryId;
  String? name;
  String? code;
  int? tax;
  TaxName? taxName;
  String? taxType;
  int? taxPercentage;
  int? shippingZoneId;

  Province({
    this.id,
    this.countryId,
    this.name,
    this.code,
    this.tax,
    this.taxName,
    this.taxType,
    this.taxPercentage,
    this.shippingZoneId,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
    id: json["id"],
    countryId: json["country_id"],
    name: json["name"],
    code: json["code"],
    tax: json["tax"],
    taxName: taxNameValues.map[json["tax_name"]]!,
    taxType: json["tax_type"],
    taxPercentage: json["tax_percentage"],
    shippingZoneId: json["shipping_zone_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_id": countryId,
    "name": name,
    "code": code,
    "tax": tax,
    "tax_name": taxNameValues.reverse[taxName],
    "tax_type": taxType,
    "tax_percentage": taxPercentage,
    "shipping_zone_id": shippingZoneId,
  };
}

enum TaxName {
  GRT,
  GST,
  HST,
  PST,
  QST,
  RST,
  SST,
  STATE_TAX,
  TAX,
  THE_00,
  VAT
}

final taxNameValues = EnumValues({
  "GRT": TaxName.GRT,
  "GST": TaxName.GST,
  "HST": TaxName.HST,
  "PST": TaxName.PST,
  "QST": TaxName.QST,
  "RST": TaxName.RST,
  "SST": TaxName.SST,
  "State Tax": TaxName.STATE_TAX,
  "Tax": TaxName.TAX,
  "0.0": TaxName.THE_00,
  "VAT": TaxName.VAT
});

class PriceBasedShippingRate {
  int? id;
  String? name;
  String? price;
  int? shippingZoneId;
  String? minOrderSubtotal;
  dynamic maxOrderSubtotal;

  PriceBasedShippingRate({
    this.id,
    this.name,
    this.price,
    this.shippingZoneId,
    this.minOrderSubtotal,
    this.maxOrderSubtotal,
  });

  factory PriceBasedShippingRate.fromJson(Map<String, dynamic> json) => PriceBasedShippingRate(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    shippingZoneId: json["shipping_zone_id"],
    minOrderSubtotal: json["min_order_subtotal"],
    maxOrderSubtotal: json["max_order_subtotal"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "shipping_zone_id": shippingZoneId,
    "min_order_subtotal": minOrderSubtotal,
    "max_order_subtotal": maxOrderSubtotal,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
