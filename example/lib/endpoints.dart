import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:woosignal_shopify_api/models/shopify_order.dart';
import 'package:woosignal_shopify_api/woosignal_shopify_api.dart';

import 'request_log.dart';

typedef EndpointRun = Future<Object?> Function(Map<String, String> inputs);

class EndpointInput {
  final String key;
  final String label;
  final String? defaultValue;
  final String? hint;
  final TextInputType keyboardType;
  final bool obscureText;

  const EndpointInput({
    required this.key,
    required this.label,
    this.defaultValue,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });
}

class Endpoint {
  final String group;
  final String title;
  final String description;
  final List<EndpointInput> inputs;
  final bool requiresAuth;
  final bool persistsSession;
  final EndpointRun run;

  const Endpoint({
    required this.group,
    required this.title,
    required this.description,
    required this.run,
    this.inputs = const [],
    this.requiresAuth = false,
    this.persistsSession = false,
  });
}

String? _str(Map<String, String> m, String k) {
  final v = m[k]?.trim();
  return (v == null || v.isEmpty) ? null : v;
}

int? _int(Map<String, String> m, String k) {
  final v = _str(m, k);
  return v == null ? null : int.tryParse(v);
}

bool? _bool(Map<String, String> m, String k) {
  final v = _str(m, k)?.toLowerCase();
  if (v == null) return null;
  return v == 'true' || v == '1' || v == 'yes';
}

final WooSignalShopify _ws = WooSignalShopify.instance;

final List<Endpoint> kEndpoints = [
  // ---------------- Catalog ----------------
  Endpoint(
    group: 'Catalog',
    title: 'getProducts',
    description: 'Paginated list of products via the Storefront API.',
    inputs: const [
      EndpointInput(
          key: 'first',
          label: 'first',
          defaultValue: '10',
          keyboardType: TextInputType.number),
      EndpointInput(key: 'after', label: 'after (cursor)'),
      EndpointInput(
          key: 'status',
          label: 'status',
          defaultValue: 'active',
          hint: 'active | archived | draft'),
    ],
    run: (i) => _ws.getProducts(
      first: _int(i, 'first'),
      after: _str(i, 'after'),
      status: _str(i, 'status'),
    ),
  ),
  Endpoint(
    group: 'Catalog',
    title: 'getProduct',
    description: 'Fetch a single product by its ID.',
    inputs: const [
      EndpointInput(
          key: 'productId',
          label: 'productId',
          hint: 'e.g. gid://shopify/Product/12345'),
      EndpointInput(key: 'fields', label: 'fields'),
    ],
    run: (i) => _ws.getProduct(
      productId: _str(i, 'productId') ?? '',
      fields: _str(i, 'fields'),
    ),
  ),
  Endpoint(
    group: 'Catalog',
    title: 'getProductCount',
    description: 'Count of products matching optional filters.',
    inputs: const [
      EndpointInput(key: 'productType', label: 'productType'),
      EndpointInput(key: 'vendor', label: 'vendor'),
      EndpointInput(key: 'publishedStatus', label: 'publishedStatus'),
    ],
    run: (i) => _ws.getProductCount(
      productType: _str(i, 'productType'),
      vendor: _str(i, 'vendor'),
      publishedStatus: _str(i, 'publishedStatus'),
    ),
  ),
  Endpoint(
    group: 'Catalog',
    title: 'productSearch',
    description: 'Search products by a text query.',
    requiresAuth: true,
    inputs: const [
      EndpointInput(key: 'query', label: 'query', defaultValue: 'shirt'),
      EndpointInput(
          key: 'first',
          label: 'first',
          defaultValue: '20',
          keyboardType: TextInputType.number),
      EndpointInput(key: 'after', label: 'after (cursor)'),
    ],
    run: (i) => _ws.productSearch(
      query: _str(i, 'query'),
      first: _int(i, 'first') ?? 20,
      after: _str(i, 'after'),
    ),
  ),
  Endpoint(
    group: 'Catalog',
    title: 'getProductImages',
    description: 'List images for a product.',
    inputs: const [
      EndpointInput(key: 'productId', label: 'productId'),
      EndpointInput(key: 'fields', label: 'fields'),
    ],
    run: (i) => _ws.getProductImages(
      productId: _str(i, 'productId') ?? '',
      fields: _str(i, 'fields'),
    ),
  ),
  Endpoint(
    group: 'Catalog',
    title: 'getProductImage',
    description: 'Fetch a single product image by ID.',
    inputs: const [
      EndpointInput(key: 'productId', label: 'productId'),
      EndpointInput(key: 'imageId', label: 'imageId'),
    ],
    run: (i) => _ws.getProductImage(
      productId: _str(i, 'productId') ?? '',
      imageId: _str(i, 'imageId') ?? '',
    ),
  ),
  Endpoint(
    group: 'Catalog',
    title: 'getProductImageCount',
    description: 'Number of images on a product.',
    inputs: const [
      EndpointInput(key: 'productId', label: 'productId'),
    ],
    run: (i) => _ws.getProductImageCount(
      productId: _str(i, 'productId'),
    ),
  ),
  Endpoint(
    group: 'Catalog',
    title: 'getProductVariants',
    description: 'List variants for a product.',
    inputs: const [
      EndpointInput(key: 'productId', label: 'productId'),
      EndpointInput(
          key: 'limit', label: 'limit', keyboardType: TextInputType.number),
    ],
    run: (i) => _ws.getProductVariants(
      productId: _str(i, 'productId') ?? '',
      limit: _int(i, 'limit'),
    ),
  ),
  Endpoint(
    group: 'Catalog',
    title: 'getProductsRestApi',
    description: 'Products via the REST API (filterable).',
    inputs: const [
      EndpointInput(
          key: 'limit',
          label: 'limit',
          defaultValue: '10',
          keyboardType: TextInputType.number),
      EndpointInput(key: 'title', label: 'title'),
      EndpointInput(key: 'vendor', label: 'vendor'),
    ],
    run: (i) => _ws.getProductsRestApi(
      limit: _int(i, 'limit'),
      title: _str(i, 'title'),
      vendor: _str(i, 'vendor'),
    ),
  ),

  // ---------------- Collections ----------------
  Endpoint(
    group: 'Collections',
    title: 'getProductsByCollectionId',
    description: 'Products in a specific collection.',
    inputs: const [
      EndpointInput(key: 'id', label: 'collection id'),
      EndpointInput(
          key: 'first',
          label: 'first',
          defaultValue: '10',
          keyboardType: TextInputType.number),
      EndpointInput(key: 'after', label: 'after (cursor)'),
    ],
    run: (i) => _ws.getProductsByCollectionId(
      id: _str(i, 'id'),
      first: _int(i, 'first'),
      after: _str(i, 'after'),
    ),
  ),
  Endpoint(
    group: 'Collections',
    title: 'getCollectionsByIds',
    description: 'Look up multiple collections by ID.',
    inputs: const [
      EndpointInput(key: 'ids', label: 'ids (comma separated)'),
    ],
    run: (i) {
      final raw = _str(i, 'ids') ?? '';
      final ids = raw
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      return _ws.getCollectionsByIds(ids: ids);
    },
  ),

  // ---------------- Shop ----------------
  Endpoint(
    group: 'Shop',
    title: 'getShop',
    description: 'Top-level shop metadata.',
    inputs: const [EndpointInput(key: 'fields', label: 'fields')],
    run: (i) => _ws.getShop(fields: _str(i, 'fields')),
  ),
  Endpoint(
    group: 'Shop',
    title: 'getPolicies',
    description: 'Refund / privacy / terms policies.',
    inputs: const [EndpointInput(key: 'fields', label: 'fields')],
    run: (i) => _ws.getPolicies(fields: _str(i, 'fields')),
  ),
  Endpoint(
    group: 'Shop',
    title: 'getShippingZones',
    description: 'Shop-configured shipping zones.',
    inputs: const [EndpointInput(key: 'fields', label: 'fields')],
    run: (i) => _ws.getShippingZones(fields: _str(i, 'fields')),
  ),
  Endpoint(
    group: 'Shop',
    title: 'fetchShippingZones',
    description: 'Shipping zones as ShopifyShippingZone (WS).',
    run: (i) => _ws.fetchShippingZones(),
  ),
  Endpoint(
    group: 'Shop',
    title: 'getCountries',
    description: 'Supported countries.',
    inputs: const [EndpointInput(key: 'sinceId', label: 'sinceId')],
    run: (i) => _ws.getCountries(sinceId: _str(i, 'sinceId')),
  ),
  Endpoint(
    group: 'Shop',
    title: 'getProvinces',
    description: 'Provinces / states for a country.',
    inputs: const [EndpointInput(key: 'id', label: 'country id')],
    run: (i) => _ws.getProvinces(id: _str(i, 'id') ?? ''),
  ),
  Endpoint(
    group: 'Shop',
    title: 'getApp',
    description: 'WooSignal app configuration.',
    inputs: const [
      EndpointInput(
          key: 'encrypted',
          label: 'encrypted',
          defaultValue: 'false',
          hint: 'true | false'),
    ],
    run: (i) => _ws.getApp(encrypted: _bool(i, 'encrypted') ?? false),
  ),
  Endpoint(
    group: 'Shop',
    title: 'checkAppStatus',
    description: 'Boolean — can the app make orders?',
    run: (i) => _ws.checkAppStatus(),
  ),

  // ---------------- Discounts ----------------
  Endpoint(
    group: 'Discounts',
    title: 'getDiscountCodeByLookup',
    description: 'Look up a discount by its code.',
    inputs: const [EndpointInput(key: 'code', label: 'code')],
    run: (i) => _ws.getDiscountCodeByLookup(code: _str(i, 'code')),
  ),
  Endpoint(
    group: 'Discounts',
    title: 'getPriceRuleById',
    description: 'Fetch a price rule by ID.',
    inputs: const [EndpointInput(key: 'priceRuleId', label: 'priceRuleId')],
    run: (i) => _ws.getPriceRuleById(priceRuleId: _str(i, 'priceRuleId')),
  ),

  // ---------------- Cart & Orders ----------------
  Endpoint(
    group: 'Cart & Orders',
    title: 'getOrder',
    description: 'Fetch a single order by ID.',
    inputs: const [EndpointInput(key: 'orderId', label: 'orderId')],
    run: (i) => _ws.getOrder(orderId: _str(i, 'orderId') ?? ''),
  ),
  Endpoint(
    group: 'Cart & Orders',
    title: 'cartCheck',
    description: 'Validate cart line stock. Paste a JSON array of cart lines.',
    inputs: const [
      EndpointInput(
        key: 'cartLines',
        label: 'cart lines (JSON)',
        defaultValue: '[{"variant_id":"123","quantity":1}]',
        keyboardType: TextInputType.multiline,
      ),
    ],
    run: (i) {
      final raw = _str(i, 'cartLines') ?? '[]';
      final parsed = jsonDecode(raw);
      if (parsed is! List) {
        throw const FormatException('cart lines must be a JSON array');
      }
      return _ws.cartCheck(parsed.cast<Map<String, dynamic>>());
    },
  ),
  Endpoint(
    group: 'Cart & Orders',
    title: 'createOrder (demo payload)',
    description:
        'Creates a minimal test order. Inspect the body in the source.',
    inputs: const [
      EndpointInput(
          key: 'email', label: 'email', defaultValue: 'demo@example.com'),
      EndpointInput(key: 'variantId', label: 'variantId'),
      EndpointInput(
          key: 'quantity',
          label: 'quantity',
          defaultValue: '1',
          keyboardType: TextInputType.number),
    ],
    run: (i) {
      final order = ShopifyOrder(
        email: _str(i, 'email'),
        currency: 'USD',
        test: true,
        financialStatus: 'pending',
        lineItems: [
          LineItems()
            ..variantId = _int(i, 'variantId')
            ..quantity = _int(i, 'quantity') ?? 1,
        ],
      );
      return _ws.createOrder(order);
    },
  ),
  Endpoint(
    group: 'Cart & Orders',
    title: 'stripePaymentIntent',
    description: 'Create a Stripe payment intent for the cart total.',
    inputs: const [
      EndpointInput(
          key: 'amount',
          label: 'amount (cents)',
          defaultValue: '1000',
          keyboardType: TextInputType.number),
      EndpointInput(
          key: 'desc',
          label: 'description',
          defaultValue: 'WooSignal demo order'),
      EndpointInput(
          key: 'email',
          label: 'receipt email',
          defaultValue: 'demo@example.com'),
    ],
    run: (i) => _ws.stripePaymentIntent(
      amount: _str(i, 'amount'),
      desc: _str(i, 'desc'),
      email: _str(i, 'email'),
    ),
  ),

  // ---------------- Auth ----------------
  Endpoint(
    group: 'Auth',
    title: 'authCustomerLogin',
    description: 'Log in a customer. Toggle "persist" to keep the session.',
    persistsSession: true,
    inputs: const [
      EndpointInput(
          key: 'email',
          label: 'email',
          keyboardType: TextInputType.emailAddress),
      EndpointInput(key: 'password', label: 'password', obscureText: true),
      EndpointInput(
          key: 'persist',
          label: 'persist session',
          defaultValue: 'true',
          hint: 'true | false'),
    ],
    run: (i) => _ws.authCustomerLogin(
      email: _str(i, 'email'),
      password: _str(i, 'password'),
      loginUser: _bool(i, 'persist') ?? true,
    ),
  ),
  Endpoint(
    group: 'Auth',
    title: 'authCustomerRegister',
    description: 'Create a new Shopify customer account.',
    persistsSession: true,
    inputs: const [
      EndpointInput(
          key: 'email',
          label: 'email',
          keyboardType: TextInputType.emailAddress),
      EndpointInput(key: 'password', label: 'password', obscureText: true),
      EndpointInput(key: 'firstName', label: 'firstName'),
      EndpointInput(key: 'lastName', label: 'lastName'),
      EndpointInput(
          key: 'acceptsMarketing',
          label: 'acceptsMarketing',
          defaultValue: 'false'),
      EndpointInput(
          key: 'persist', label: 'persist session', defaultValue: 'true'),
    ],
    run: (i) => _ws.authCustomerRegister(
      email: _str(i, 'email'),
      password: _str(i, 'password'),
      firstName: _str(i, 'firstName'),
      lastName: _str(i, 'lastName'),
      acceptsMarketing: _bool(i, 'acceptsMarketing'),
      loginUser: _bool(i, 'persist') ?? true,
    ),
  ),
  Endpoint(
    group: 'Auth',
    title: 'authCustomer',
    description: 'Read the currently logged-in customer.',
    requiresAuth: true,
    run: (i) => _ws.authCustomer(),
  ),
  Endpoint(
    group: 'Auth',
    title: 'authCustomerOrders',
    description: 'List orders for the logged-in customer.',
    requiresAuth: true,
    inputs: const [
      EndpointInput(
          key: 'perPage',
          label: 'perPage',
          defaultValue: '20',
          keyboardType: TextInputType.number),
      EndpointInput(key: 'after', label: 'after (cursor)'),
    ],
    run: (i) => _ws.authCustomerOrders(
      perPage: _int(i, 'perPage'),
      after: _str(i, 'after'),
    ),
  ),
  Endpoint(
    group: 'Auth',
    title: 'authCustomerUpdate',
    description: 'Update the logged-in customer\'s name.',
    requiresAuth: true,
    inputs: const [
      EndpointInput(key: 'firstName', label: 'firstName'),
      EndpointInput(key: 'lastName', label: 'lastName'),
    ],
    run: (i) => _ws.authCustomerUpdate(
      firstName: _str(i, 'firstName'),
      lastName: _str(i, 'lastName'),
    ),
  ),
  Endpoint(
    group: 'Auth',
    title: 'authCustomerUpdateAddress',
    description: 'Update the logged-in customer\'s default address.',
    requiresAuth: true,
    inputs: const [
      EndpointInput(key: 'address1', label: 'address1'),
      EndpointInput(key: 'city', label: 'city'),
      EndpointInput(key: 'country', label: 'country'),
      EndpointInput(key: 'province', label: 'province'),
      EndpointInput(key: 'zip', label: 'zip'),
      EndpointInput(
          key: 'phone', label: 'phone', keyboardType: TextInputType.phone),
    ],
    run: (i) => _ws.authCustomerUpdateAddress(
      address1: _str(i, 'address1'),
      city: _str(i, 'city'),
      country: _str(i, 'country'),
      province: _str(i, 'province'),
      zip: _str(i, 'zip'),
      phone: _str(i, 'phone'),
    ),
  ),
  Endpoint(
    group: 'Auth',
    title: 'authCustomerForgotPassword',
    description: 'Send a password reset email.',
    inputs: const [
      EndpointInput(
          key: 'email',
          label: 'email',
          keyboardType: TextInputType.emailAddress),
    ],
    run: (i) => _ws.authCustomerForgotPassword(email: _str(i, 'email') ?? ''),
  ),
];

Map<String, List<Endpoint>> get kEndpointsByGroup {
  final out = <String, List<Endpoint>>{};
  for (final e in kEndpoints) {
    out.putIfAbsent(e.group, () => []).add(e);
  }
  return out;
}

Future<RequestLogEntry> runEndpoint(
  Endpoint endpoint,
  Map<String, String> inputs,
) async {
  final started = DateTime.now();
  final sw = Stopwatch()..start();
  try {
    final result = await endpoint.run(inputs);
    sw.stop();
    final entry = RequestLogEntry(
      timestamp: started,
      endpoint: endpoint.title,
      group: endpoint.group,
      inputs: Map.of(inputs),
      duration: sw.elapsed,
      result: result,
    );
    requestLog.add(entry);
    return entry;
  } catch (e, stack) {
    sw.stop();
    final entry = RequestLogEntry(
      timestamp: started,
      endpoint: endpoint.title,
      group: endpoint.group,
      inputs: Map.of(inputs),
      duration: sw.elapsed,
      error: '$e',
      stackTrace: stack.toString(),
    );
    requestLog.add(entry);
    return entry;
  }
}
