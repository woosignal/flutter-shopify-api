class ShopResponse {
  Shop? shop;

  ShopResponse({this.shop});

  ShopResponse.fromJson(Map<String, dynamic> json) {
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shop != null) {
      data['shop'] = shop!.toJson();
    }
    return data;
  }
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
  Null? source;
  String? phone;
  double? latitude;
  double? longitude;
  String? primaryLocale;
  String? address2;
  String? createdAt;
  String? updatedAt;
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
  Null? autoConfigureTaxInclusivity;
  Null? taxShipping;
  bool? countyTaxes;
  String? planDisplayName;
  String? planName;
  bool? hasDiscounts;
  bool? hasGiftCards;
  String? myshopifyDomain;
  Null? googleAppsDomain;
  Null? googleAppsLoginEnabled;
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

  Shop(
      {this.id,
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
        this.marketingSmsConsentEnabledAtCheckout});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    domain = json['domain'];
    province = json['province'];
    country = json['country'];
    address1 = json['address1'];
    zip = json['zip'];
    city = json['city'];
    source = json['source'];
    phone = json['phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    primaryLocale = json['primary_locale'];
    address2 = json['address2'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    countryCode = json['country_code'];
    countryName = json['country_name'];
    currency = json['currency'];
    customerEmail = json['customer_email'];
    timezone = json['timezone'];
    ianaTimezone = json['iana_timezone'];
    shopOwner = json['shop_owner'];
    moneyFormat = json['money_format'];
    moneyWithCurrencyFormat = json['money_with_currency_format'];
    weightUnit = json['weight_unit'];
    provinceCode = json['province_code'];
    taxesIncluded = json['taxes_included'];
    autoConfigureTaxInclusivity = json['auto_configure_tax_inclusivity'];
    taxShipping = json['tax_shipping'];
    countyTaxes = json['county_taxes'];
    planDisplayName = json['plan_display_name'];
    planName = json['plan_name'];
    hasDiscounts = json['has_discounts'];
    hasGiftCards = json['has_gift_cards'];
    myshopifyDomain = json['myshopify_domain'];
    googleAppsDomain = json['google_apps_domain'];
    googleAppsLoginEnabled = json['google_apps_login_enabled'];
    moneyInEmailsFormat = json['money_in_emails_format'];
    moneyWithCurrencyInEmailsFormat =
    json['money_with_currency_in_emails_format'];
    eligibleForPayments = json['eligible_for_payments'];
    requiresExtraPaymentsAgreement = json['requires_extra_payments_agreement'];
    passwordEnabled = json['password_enabled'];
    hasStorefront = json['has_storefront'];
    finances = json['finances'];
    primaryLocationId = json['primary_location_id'];
    cookieConsentLevel = json['cookie_consent_level'];
    checkoutApiSupported = json['checkout_api_supported'];
    multiLocationEnabled = json['multi_location_enabled'];
    setupRequired = json['setup_required'];
    preLaunchEnabled = json['pre_launch_enabled'];
    enabledPresentmentCurrencies =
        json['enabled_presentment_currencies'].cast<String>();
    transactionalSmsDisabled = json['transactional_sms_disabled'];
    marketingSmsConsentEnabledAtCheckout =
    json['marketing_sms_consent_enabled_at_checkout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['domain'] = domain;
    data['province'] = province;
    data['country'] = country;
    data['address1'] = address1;
    data['zip'] = zip;
    data['city'] = city;
    data['source'] = source;
    data['phone'] = phone;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['primary_locale'] = primaryLocale;
    data['address2'] = address2;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['country_code'] = countryCode;
    data['country_name'] = countryName;
    data['currency'] = currency;
    data['customer_email'] = customerEmail;
    data['timezone'] = timezone;
    data['iana_timezone'] = ianaTimezone;
    data['shop_owner'] = shopOwner;
    data['money_format'] = moneyFormat;
    data['money_with_currency_format'] = moneyWithCurrencyFormat;
    data['weight_unit'] = weightUnit;
    data['province_code'] = provinceCode;
    data['taxes_included'] = taxesIncluded;
    data['auto_configure_tax_inclusivity'] = autoConfigureTaxInclusivity;
    data['tax_shipping'] = taxShipping;
    data['county_taxes'] = countyTaxes;
    data['plan_display_name'] = planDisplayName;
    data['plan_name'] = planName;
    data['has_discounts'] = hasDiscounts;
    data['has_gift_cards'] = hasGiftCards;
    data['myshopify_domain'] = myshopifyDomain;
    data['google_apps_domain'] = googleAppsDomain;
    data['google_apps_login_enabled'] = googleAppsLoginEnabled;
    data['money_in_emails_format'] = moneyInEmailsFormat;
    data['money_with_currency_in_emails_format'] =
        moneyWithCurrencyInEmailsFormat;
    data['eligible_for_payments'] = eligibleForPayments;
    data['requires_extra_payments_agreement'] =
        requiresExtraPaymentsAgreement;
    data['password_enabled'] = passwordEnabled;
    data['has_storefront'] = hasStorefront;
    data['finances'] = finances;
    data['primary_location_id'] = primaryLocationId;
    data['cookie_consent_level'] = cookieConsentLevel;
    data['checkout_api_supported'] = checkoutApiSupported;
    data['multi_location_enabled'] = multiLocationEnabled;
    data['setup_required'] = setupRequired;
    data['pre_launch_enabled'] = preLaunchEnabled;
    data['enabled_presentment_currencies'] = enabledPresentmentCurrencies;
    data['transactional_sms_disabled'] = transactionalSmsDisabled;
    data['marketing_sms_consent_enabled_at_checkout'] =
        marketingSmsConsentEnabledAtCheckout;
    return data;
  }
}
