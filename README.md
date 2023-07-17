# Shopify API Dart plugin

[Official WooSignal WooCommerce package](https://woosignal.com)

Build apps for WooCommerce easier with our new package.
Our API provides many requests types e.g. getProducts, getOrders and many more.
Free to get started, see the simple examples below.

For help getting started with WooSignal, view our
[online documentation](https://woosignal.com/docs/api/1.0/overview), which offers a more detail guide.

### Getting Started #
In your flutter project add the dependency:

``` dart 
dependencies:
  ...
  shopify: ^1.0.0
```

### Usage example #
Import `woosignal_shopify.dart`
``` dart
import 'package:woosignal_shopify/woosignal_shopify.dart';
```

### Example using WooSignal API for Shopify

``` dart
import 'package:woosignal_shopify/woosignal_shopify.dart';

...

// EXAMPLE GET PRODUCT
_getProducts() async {

        // Step 1 - Initialize WooSignal
        await WooSignal.instance.init(appKey: "your app key");

        // Step 2 - Call an API
        List<Product> products = await WooSignal.instance.getProducts();

        print(products[0].name); // prints a product name
  });
}
```

### Available API Requests

#### WooCommerce - Products
- Get Products
- Retrieve a Product by id
- Update a Product by id
- Delete a Product by id 
- Create a Product 
- Batch update Products

[See Customers API](https://woosignal.com/docs/api/1.0/customers)

#### WooCommerce - API Orders Notes
- List all Orders Notes
- Retrieve a Orders Notes by id
- Delete a Orders Notes by id
- Create a Orders Notes


Disclaimer: This plugin is not affiliated with or supported by Shopify. All logos and trademarks are the property of their respective owners.
