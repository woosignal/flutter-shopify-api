class CountriesResponse {
  List<Country>? countries;

  CountriesResponse({
    this.countries,
  });

  factory CountriesResponse.fromJson(Map<String, dynamic> json) => CountriesResponse(
    countries: json["countries"] == null ? [] : List<Country>.from(json["countries"]!.map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "countries": countries == null ? [] : List<dynamic>.from(countries!.map((x) => x.toJson())),
  };
}

class Country {
  int? id;
  String? name;
  String? code;
  String? taxName;
  int? tax;
  List<Province>? provinces;

  Country({
    this.id,
    this.name,
    this.code,
    this.taxName,
    this.tax,
    this.provinces,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    taxName: json["tax_name"],
    tax: json["tax"],
    provinces: json["provinces"] == null ? [] : List<Province>.from(json["provinces"]!.map((x) => Province.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "tax_name": taxName,
    "tax": tax,
    "provinces": provinces == null ? [] : List<dynamic>.from(provinces!.map((x) => x.toJson())),
  };
}

class Province {
  int? id;
  int? countryId;
  String? name;
  String? code;
  TaxName? taxName;
  String? taxType;
  dynamic shippingZoneId;
  int? tax;
  int? taxPercentage;

  Province({
    this.id,
    this.countryId,
    this.name,
    this.code,
    this.taxName,
    this.taxType,
    this.shippingZoneId,
    this.tax,
    this.taxPercentage,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
    id: json["id"],
    countryId: json["country_id"],
    name: json["name"],
    code: json["code"],
    taxName: taxNameValues.map[json["tax_name"]]!,
    taxType: json["tax_type"],
    shippingZoneId: json["shipping_zone_id"],
    tax: json["tax"],
    taxPercentage: json["tax_percentage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_id": countryId,
    "name": name,
    "code": code,
    "tax_name": taxNameValues.reverse[taxName],
    "tax_type": taxType,
    "shipping_zone_id": shippingZoneId,
    "tax": tax,
    "tax_percentage": taxPercentage,
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
