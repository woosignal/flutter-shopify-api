# Shopify API Dart plugin

[Official WooSignal Shopify package](https://woosignal.com)

Build apps for Shopify easier with our new package.
Free to get started, see the simple examples below.

### Getting Started #
In your flutter project add the dependency:

``` dart 
dependencies:
  ...
  woosignal_shopify_api: ^2.1.0
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

# Shopify API Client Documentation

Below is a comprehensive list of available methods grouped by their functionality.

## Cart Operations

### `cartCheck(List<Map<String, dynamic>> cartLines)`
Validates if items in the cart are in stock.
- **Parameters**: List of cart items
- **Returns**: List of validated cart items
- **Method**: POST

## Product Operations

### `getProducts({int? first, String? after, String? status})`
Fetches products with pagination support.
- **Parameters**:
    - `first`: Number of products to fetch
    - `after`: Cursor for pagination
    - `status`: Product status (active, archived, draft)
- **Returns**: `ShopifyProductResponse`
- **Method**: POST

### `getProductsRestApi({...})`
Fetches products using REST API with extensive filtering options.
- **Parameters**:
    - `limit`: Maximum number of products
    - `productType`: Filter by product type
    - `collectionId`: Filter by collection
    - Various date filters and other parameters
- **Returns**: List of `Product`
- **Method**: POST

### `getProduct({required int productId, String? fields})`
Fetches a single product by ID.
- **Parameters**:
    - `productId`: Product identifier
    - `fields`: Specific fields to retrieve
- **Returns**: `Product`
- **Method**: POST

### `getProductCount({...})`
Gets the total count of products with filtering options.
- **Parameters**: Various filters including product type, collection ID, date ranges
- **Returns**: `CountResponse`
- **Method**: POST

### `productSearch({String? query, int first = 100, String? after})`
Searches for products.
- **Parameters**:
    - `query`: Search term
    - `first`: Number of results
    - `after`: Pagination cursor
- **Returns**: `ShopifyProductSearch`
- **Method**: POST

## Collection Operations

### `getCollectionsByIds({required List<String> ids})`
Fetches collections by their IDs.
- **Parameters**: List of collection IDs
- **Returns**: `CollectionItem`
- **Method**: POST

### `getProductsByCollectionId({String? id, int? first, String? after})`
Retrieves products within a specific collection.
- **Parameters**:
    - `id`: Collection ID
    - `first`: Number of products
    - `after`: Pagination cursor
- **Returns**: `ProductsByCollectionIdResponse`
- **Method**: POST

## Customer Authentication

### `authCustomerLogin({required String? email, required String? password, bool? loginUser})`
Authenticates a customer.
- **Parameters**:
    - `email`: Customer email
    - `password`: Customer password
    - `loginUser`: Whether to automatically log in
- **Returns**: `AuthCustomer`
- **Method**: POST

### `authCustomerRegister({...})`
Registers a new customer.
- **Parameters**:
    - `email`: Customer email
    - `password`: Customer password
    - `firstName`: Customer first name
    - `lastName`: Customer last name
    - `acceptsMarketing`: Marketing preferences
- **Returns**: `AuthCustomer`
- **Method**: POST

### `authCustomerForgotPassword({required String email})`
Initiates password reset process.
- **Parameters**: Customer email
- **Returns**: Boolean indicating success
- **Method**: POST

## Customer Management

### `authCustomer({String? accessToken})`
Retrieves customer details.
- **Parameters**: Customer access token
- **Returns**: `AuthCustomerInfo`
- **Method**: GET

### `authCustomerUpdate({String? customerAccessToken, String? firstName, String? lastName})`
Updates customer information.
- **Parameters**: Access token and updated fields
- **Returns**: `AuthCustomerUpdateResponse`
- **Method**: PUT

### `authCustomerUpdateAddress({...})`
Updates customer shipping address.
- **Parameters**: Address details including street, city, country, etc.
- **Returns**: `AuthCustomerAddressUpdated`
- **Method**: PUT

## Order Management

### `createOrder(ShopifyOrder shopifyOrder)`
Creates a new order.
- **Parameters**: Order details
- **Returns**: `OrderCreatedResponse`
- **Method**: POST

### `getOrder({required String orderId})`
Retrieves order details.
- **Parameters**: Order ID
- **Returns**: `OrderResponse`
- **Method**: GET

### `authCustomerOrders({String? customerAccessToken, int? perPage, String? after})`
Fetches customer's order history.
- **Parameters**:
    - `customerAccessToken`: Customer access token
    - `perPage`: Results per page
    - `after`: Pagination cursor
- **Returns**: `AuthCustomerOrder`
- **Method**: GET

## Shop Information

### `getShop({String? fields})`
Retrieves shop details.
- **Parameters**: Specific fields to retrieve
- **Returns**: `ShopResponse`
- **Method**: POST

### `getPolicies({String? fields})`
Fetches shop policies.
- **Parameters**: Specific fields to retrieve
- **Returns**: `PoliciesResponse`
- **Method**: POST

### `checkAppStatus()`
Verifies if the app can process orders.
- **Returns**: Boolean
- **Method**: POST

## Shipping

### `fetchShippingZones()`
Retrieves available shipping zones.
- **Returns**: `ShopifyShippingZone`
- **Method**: GET

### `getShippingZones({String? fields})`
Fetches detailed shipping zone information.
- **Parameters**: Specific fields to retrieve
- **Returns**: `ShippingZonesResponse`
- **Method**: POST

### `getProvinces({required int id, String? fields})`
Retrieves provinces/states for a country.
- **Parameters**:
    - `id`: Country ID
    - `fields`: Specific fields to retrieve
- **Returns**: `ProvincesResponse`
- **Method**: POST

## Discounts

### `getDiscountCodeByLookup({String? code})`
Validates a discount code.
- **Parameters**: Discount code
- **Returns**: `DiscountCode`
- **Method**: GET

### `getPriceRuleById({String? priceRuleId})`
Retrieves price rule details.
- **Parameters**: Price rule ID
- **Returns**: `PriceRuleResponse`
- **Method**: POST

Disclaimer: This plugin is not affiliated with or supported by Shopify. All logos and trademarks are the property of their respective owners.
