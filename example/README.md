# WooSignal Shopify Explorer

A runnable demo of the [`woosignal_shopify_api`](https://pub.dev/packages/woosignal_shopify_api)
plugin. Browse every endpoint exposed by the SDK, fire requests with custom
parameters, and see the pretty-printed response without writing any code.

## What you get

- Grouped list of ~30 endpoints (catalog, collections, shop, discounts,
  cart & orders, auth)
- Per-endpoint form for the call's parameters with sensible defaults
- Response shown as pretty-printed JSON, with copy-to-clipboard
- Elapsed time and success/error status for every call
- Request log in a bottom sheet (the last 100 calls)
- Customer-session persistence: log in once, the other auth endpoints
  reuse the token

## Running

You need a WooSignal app key. Get one from
[woosignal.com](https://woosignal.com) and pass it in via `--dart-define`:

```bash
flutter run --dart-define=WOOSIGNAL_KEY=your_key_here
```

If the key is missing the app still launches, but a banner reminds you to
set it and endpoint calls will be disabled.

## Minimal usage

If you just want a snippet to drop into your own app:

```dart
import 'package:woosignal_shopify_api/woosignal_shopify_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WooSignalShopify.instance.init(appKey: 'your_key_here');

  final res = await WooSignalShopify.instance.getProducts(first: 10);
  print(res?.products?.first.title);
}
```

See [`lib/endpoints.dart`](lib/endpoints.dart) for one-line examples of every
SDK call.

## Docs

- Plugin docs: <https://woosignal.com/docs/api/2.0/shopify>
- Plugin on pub.dev: <https://pub.dev/packages/woosignal_shopify_api>
