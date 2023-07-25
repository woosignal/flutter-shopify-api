class ProductImageResponse {
  Image? image;

  ProductImageResponse({this.image});

  ProductImageResponse.fromJson(Map<String, dynamic> json) {
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}

class Image {
  int? id;
  int? productId;
  int? position;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? alt;
  int? width;
  int? height;
  String? src;
  List<int>? variantIds;
  String? adminGraphqlApiId;

  Image(
      {this.id,
        this.productId,
        this.position,
        this.createdAt,
        this.updatedAt,
        this.alt,
        this.width,
        this.height,
        this.src,
        this.variantIds,
        this.adminGraphqlApiId});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    position = json['position'];
    createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
    alt = json['alt'];
    width = json['width'];
    height = json['height'];
    src = json['src'];
    variantIds = json['variant_ids'].cast<int>();
    adminGraphqlApiId = json['admin_graphql_api_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['position'] = position;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['alt'] = alt;
    data['width'] = width;
    data['height'] = height;
    data['src'] = src;
    data['variant_ids'] = variantIds;
    data['admin_graphql_api_id'] = adminGraphqlApiId;
    return data;
  }
}
