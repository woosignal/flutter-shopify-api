import 'package:woosignal_shopify/models/product_image.dart';

class ProductImagesResponse {
  List<ProductImage>? images;

  ProductImagesResponse({this.images});

  ProductImagesResponse.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = <ProductImage>[];
      json['images'].forEach((v) {
        images!.add(ProductImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
