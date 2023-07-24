class CountriesResponse {
  List<Countries>? countries;

  CountriesResponse({this.countries});

  CountriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
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
        provinces!.add(new Provinces.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['tax_name'] = this.taxName;
    data['tax'] = this.tax;
    if (this.provinces != null) {
      data['provinces'] = this.provinces!.map((v) => v.toJson()).toList();
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
  Null? shippingZoneId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['tax_name'] = this.taxName;
    data['tax_type'] = this.taxType;
    data['shipping_zone_id'] = this.shippingZoneId;
    data['tax'] = this.tax;
    data['tax_percentage'] = this.taxPercentage;
    return data;
  }
}
