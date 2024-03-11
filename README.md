# Shopify API Dart plugin

[Official WooSignal Shopify package](https://woosignal.com)

Build apps for Shopify easier with our new package.
Free to get started, see the simple examples below.

### Getting Started #
In your flutter project add the dependency:

``` dart 
dependencies:
  ...
  woosignal_shopify_api: ^1.2.0
```

### Usage example #
Import `woosignal_shopify_api.dart`
``` dart
import 'package:shopify_woosignal/woosignal_shopify_api.dart';
```

### Example using WooSignal API for Shopify

``` dart
import 'woosignal_shopify_api/woosignal_shopify_api.dart';

...

// EXAMPLE GET PRODUCT
_getProducts() async {

        // Step 1 - Initialize WooSignal
        await WooSignalShopify.instance.init(appKey: "your app key");

        // Step 2 - Call an API
        ShopifyProductResponse? shopifyProductResponse = await WooSignalShopify.instance.getProducts();

        print(shopifyProductResponse?.products?[0].name); // prints a product name
  });
}
```

### Available API Requests

Coming soon

Disclaimer: This plugin is not affiliated with or supported by Shopify. All logos and trademarks are the property of their respective owners.
