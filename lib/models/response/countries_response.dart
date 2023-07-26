class CountriesResponse {
  Shop? shop;

  CountriesResponse({
    this.shop,
  });

  factory CountriesResponse.fromJson(Map<String, dynamic> json) => CountriesResponse(
    shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
  );

  Map<String, dynamic> toJson() => {
    "shop": shop?.toJson(),
  };
}

class Shop {
  int? id;
  String? name;
  String? email;
  String? domain;
  String? province;
  String? country;
  String? address1;
  String? zip;
  String? city;
  dynamic source;
  String? phone;
  double? latitude;
  double? longitude;
  String? primaryLocale;
  String? address2;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? countryCode;
  String? countryName;
  String? currency;
  String? customerEmail;
  String? timezone;
  String? ianaTimezone;
  String? shopOwner;
  String? moneyFormat;
  String? moneyWithCurrencyFormat;
  String? weightUnit;
  String? provinceCode;
  bool? taxesIncluded;
  dynamic autoConfigureTaxInclusivity;
  dynamic taxShipping;
  bool? countyTaxes;
  String? planDisplayName;
  String? planName;
  bool? hasDiscounts;
  bool? hasGiftCards;
  String? myshopifyDomain;
  dynamic googleAppsDomain;
  dynamic googleAppsLoginEnabled;
  String? moneyInEmailsFormat;
  String? moneyWithCurrencyInEmailsFormat;
  bool? eligibleForPayments;
  bool? requiresExtraPaymentsAgreement;
  bool? passwordEnabled;
  bool? hasStorefront;
  bool? finances;
  int? primaryLocationId;
  String? cookieConsentLevel;
  bool? checkoutApiSupported;
  bool? multiLocationEnabled;
  bool? setupRequired;
  bool? preLaunchEnabled;
  List<String>? enabledPresentmentCurrencies;
  bool? transactionalSmsDisabled;
  bool? marketingSmsConsentEnabledAtCheckout;

  Shop({
    this.id,
    this.name,
    this.email,
    this.domain,
    this.province,
    this.country,
    this.address1,
    this.zip,
    this.city,
    this.source,
    this.phone,
    this.latitude,
    this.longitude,
    this.primaryLocale,
    this.address2,
    this.createdAt,
    this.updatedAt,
    this.countryCode,
    this.countryName,
    this.currency,
    this.customerEmail,
    this.timezone,
    this.ianaTimezone,
    this.shopOwner,
    this.moneyFormat,
    this.moneyWithCurrencyFormat,
    this.weightUnit,
    this.provinceCode,
    this.taxesIncluded,
    this.autoConfigureTaxInclusivity,
    this.taxShipping,
    this.countyTaxes,
    this.planDisplayName,
    this.planName,
    this.hasDiscounts,
    this.hasGiftCards,
    this.myshopifyDomain,
    this.googleAppsDomain,
    this.googleAppsLoginEnabled,
    this.moneyInEmailsFormat,
    this.moneyWithCurrencyInEmailsFormat,
    this.eligibleForPayments,
    this.requiresExtraPaymentsAgreement,
    this.passwordEnabled,
    this.hasStorefront,
    this.finances,
    this.primaryLocationId,
    this.cookieConsentLevel,
    this.checkoutApiSupported,
    this.multiLocationEnabled,
    this.setupRequired,
    this.preLaunchEnabled,
    this.enabledPresentmentCurrencies,
    this.transactionalSmsDisabled,
    this.marketingSmsConsentEnabledAtCheckout,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    domain: json["domain"],
    province: json["province"],
    country: json["country"],
    address1: json["address1"],
    zip: json["zip"],
    city: json["city"],
    source: json["source"],
    phone: json["phone"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    primaryLocale: json["primary_locale"],
    address2: json["address2"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    countryCode: json["country_code"],
    countryName: json["country_name"],
    currency: json["currency"],
    customerEmail: json["customer_email"],
    timezone: json["timezone"],
    ianaTimezone: json["iana_timezone"],
    shopOwner: json["shop_owner"],
    moneyFormat: json["money_format"],
    moneyWithCurrencyFormat: json["money_with_currency_format"],
    weightUnit: json["weight_unit"],
    provinceCode: json["province_code"],
    taxesIncluded: json["taxes_included"],
    autoConfigureTaxInclusivity: json["auto_configure_tax_inclusivity"],
    taxShipping: json["tax_shipping"],
    countyTaxes: json["county_taxes"],
    planDisplayName: json["plan_display_name"],
    planName: json["plan_name"],
    hasDiscounts: json["has_discounts"],
    hasGiftCards: json["has_gift_cards"],
    myshopifyDomain: json["myshopify_domain"],
    googleAppsDomain: json["google_apps_domain"],
    googleAppsLoginEnabled: json["google_apps_login_enabled"],
    moneyInEmailsFormat: json["money_in_emails_format"],
    moneyWithCurrencyInEmailsFormat: json["money_with_currency_in_emails_format"],
    eligibleForPayments: json["eligible_for_payments"],
    requiresExtraPaymentsAgreement: json["requires_extra_payments_agreement"],
    passwordEnabled: json["password_enabled"],
    hasStorefront: json["has_storefront"],
    finances: json["finances"],
    primaryLocationId: json["primary_location_id"],
    cookieConsentLevel: json["cookie_consent_level"],
    checkoutApiSupported: json["checkout_api_supported"],
    multiLocationEnabled: json["multi_location_enabled"],
    setupRequired: json["setup_required"],
    preLaunchEnabled: json["pre_launch_enabled"],
    enabledPresentmentCurrencies: json["enabled_presentment_currencies"] == null ? [] : List<String>.from(json["enabled_presentment_currencies"]!.map((x) => x)),
    transactionalSmsDisabled: json["transactional_sms_disabled"],
    marketingSmsConsentEnabledAtCheckout: json["marketing_sms_consent_enabled_at_checkout"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "domain": domain,
    "province": province,
    "country": country,
    "address1": address1,
    "zip": zip,
    "city": city,
    "source": source,
    "phone": phone,
    "latitude": latitude,
    "longitude": longitude,
    "primary_locale": primaryLocale,
    "address2": address2,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "country_code": countryCode,
    "country_name": countryName,
    "currency": currency,
    "customer_email": customerEmail,
    "timezone": timezone,
    "iana_timezone": ianaTimezone,
    "shop_owner": shopOwner,
    "money_format": moneyFormat,
    "money_with_currency_format": moneyWithCurrencyFormat,
    "weight_unit": weightUnit,
    "province_code": provinceCode,
    "taxes_included": taxesIncluded,
    "auto_configure_tax_inclusivity": autoConfigureTaxInclusivity,
    "tax_shipping": taxShipping,
    "county_taxes": countyTaxes,
    "plan_display_name": planDisplayName,
    "plan_name": planName,
    "has_discounts": hasDiscounts,
    "has_gift_cards": hasGiftCards,
    "myshopify_domain": myshopifyDomain,
    "google_apps_domain": googleAppsDomain,
    "google_apps_login_enabled": googleAppsLoginEnabled,
    "money_in_emails_format": moneyInEmailsFormat,
    "money_with_currency_in_emails_format": moneyWithCurrencyInEmailsFormat,
    "eligible_for_payments": eligibleForPayments,
    "requires_extra_payments_agreement": requiresExtraPaymentsAgreement,
    "password_enabled": passwordEnabled,
    "has_storefront": hasStorefront,
    "finances": finances,
    "primary_location_id": primaryLocationId,
    "cookie_consent_level": cookieConsentLevel,
    "checkout_api_supported": checkoutApiSupported,
    "multi_location_enabled": multiLocationEnabled,
    "setup_required": setupRequired,
    "pre_launch_enabled": preLaunchEnabled,
    "enabled_presentment_currencies": enabledPresentmentCurrencies == null ? [] : List<dynamic>.from(enabledPresentmentCurrencies!.map((x) => x)),
    "transactional_sms_disabled": transactionalSmsDisabled,
    "marketing_sms_consent_enabled_at_checkout": marketingSmsConsentEnabledAtCheckout,
  };
}
