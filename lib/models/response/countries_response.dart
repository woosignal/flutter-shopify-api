class CountriesResponse {
  List<Countries>? countries;

  CountriesResponse({this.countries});

  CountriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(Countries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  int? id;
  String? name;
  String? code;
  String? taxName;
  int? tax;
  List<Provinces>? provinces;

  Countries(
      {this.id, this.name, this.code, this.taxName, this.tax, this.provinces});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    taxName = json['tax_name'];
    tax = json['tax'];
    if (json['provinces'] != null) {
      provinces = <Provinces>[];
      json['provinces'].forEach((v) {
        provinces!.add(Provinces.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['tax_name'] = taxName;
    data['tax'] = tax;
    if (provinces != null) {
      data['provinces'] = provinces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Provinces {
  int? id;
  int? countryId;
  String? name;
  String? code;
  String? taxName;
  String? taxType;
  int? shippingZoneId;
  int? tax;
  int? taxPercentage;

  Provinces(
      {this.id,
        this.countryId,
        this.name,
        this.code,
        this.taxName,
        this.taxType,
        this.shippingZoneId,
        this.tax,
        this.taxPercentage});

  Provinces.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    code = json['code'];
    taxName = json['tax_name'];
    taxType = json['tax_type'];
    shippingZoneId = json['shipping_zone_id'];
    tax = json['tax'];
    taxPercentage = json['tax_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country_id'] = countryId;
    data['name'] = name;
    data['code'] = code;
    data['tax_name'] = taxName;
    data['tax_type'] = taxType;
    data['shipping_zone_id'] = shippingZoneId;
    data['tax'] = tax;
    data['tax_percentage'] = taxPercentage;
    return data;
  }
}
