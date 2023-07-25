import 'package:woosignal_shopify/models/product.dart';

class ProductsResponse {
  List<Product>? products;

  ProductsResponse({this.products});

  ProductsResponse.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
