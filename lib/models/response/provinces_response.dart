class ProvincesResponse {
  List<Province> provinces;

  ProvincesResponse({
    required this.provinces,
  });

  factory ProvincesResponse.fromJson(Map<String, dynamic> json) => ProvincesResponse(
    provinces: List<Province>.from(json["provinces"].map((x) => Province.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "provinces": List<dynamic>.from(provinces.map((x) => x.toJson())),
  };
}

class Province {
  int id;
  int countryId;
  String name;
  String code;
  String taxName;
  String? taxType;
  dynamic shippingZoneId;
  int tax;
  int taxPercentage;

  Province({
    required this.id,
    required this.countryId,
    required this.name,
    required this.code,
    required this.taxName,
    this.taxType,
    this.shippingZoneId,
    required this.tax,
    required this.taxPercentage,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
    id: json["id"],
    countryId: json["country_id"],
    name: json["name"],
    code: json["code"],
    taxName: json["tax_name"],
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
    "tax_name": taxName,
    "tax_type": taxType,
    "shipping_zone_id": shippingZoneId,
    "tax": tax,
    "tax_percentage": taxPercentage,
  };
}
