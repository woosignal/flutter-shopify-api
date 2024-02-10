// Copyright (c) 2024, WooSignal Ltd.
// All rights reserved.
//
// Redistribution and use in source and binary forms are permitted
// provided that the above copyright notice and this paragraph are
// duplicated in all such forms and that any documentation,
// advertising materials, and other materials related to such
// distribution and use acknowledge that the software was developed
// by the WooSignal. The name of the
// WooSignal may not be used to endorse or promote products derived
// from this software without specific prior written permission.
// THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
// IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.

class ShopifyCategory {
  List<CustomCollections>? customCollections;
  PageLink? pageLink;

  ShopifyCategory({this.customCollections, this.pageLink});

  ShopifyCategory.fromJson(Map<String, dynamic> json) {
    if (json['custom_collections'] != null) {
      customCollections = [];
      json['custom_collections'].forEach((v) {
        customCollections!.add(CustomCollections.fromJson(v));
      });
    }
    pageLink =
        json['page_link'] != null ? PageLink.fromJson(json['page_link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customCollections != null) {
      data['custom_collections'] =
          customCollections!.map((v) => v.toJson()).toList();
    }
    if (pageLink != null) {
      data['page_link'] = pageLink!.toJson();
    }
    return data;
  }
}

class CustomCollections {
  int? id;
  String? handle;
  String? title;
  String? updatedAt;
  String? bodyHtml;
  String? publishedAt;
  String? sortOrder;
  String? templateSuffix;
  String? publishedScope;
  String? adminGraphqlApiId;
  Image? image;

  CustomCollections(
      {this.id,
      this.handle,
      this.title,
      this.updatedAt,
      this.bodyHtml,
      this.publishedAt,
      this.sortOrder,
      this.templateSuffix,
      this.publishedScope,
      this.adminGraphqlApiId,
      this.image});

  CustomCollections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    handle = json['handle'];
    title = json['title'];
    updatedAt = json['updated_at'];
    bodyHtml = json['body_html'];
    publishedAt = json['published_at'];
    sortOrder = json['sort_order'];
    templateSuffix = json['template_suffix'];
    publishedScope = json['published_scope'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['handle'] = handle;
    data['title'] = title;
    data['updated_at'] = updatedAt;
    data['body_html'] = bodyHtml;
    data['published_at'] = publishedAt;
    data['sort_order'] = sortOrder;
    data['template_suffix'] = templateSuffix;
    data['published_scope'] = publishedScope;
    data['admin_graphql_api_id'] = adminGraphqlApiId;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}

class Image {
  String? createdAt;
  String? alt;
  int? width;
  int? height;
  String? src;

  Image({this.createdAt, this.alt, this.width, this.height, this.src});

  Image.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    alt = json['alt'];
    width = json['width'];
    height = json['height'];
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['alt'] = alt;
    data['width'] = width;
    data['height'] = height;
    data['src'] = src;
    return data;
  }
}

class PageLink {
  String? next;
  String? previous;

  PageLink({this.next, this.previous});

  PageLink.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    previous = json['previous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['next'] = next;
    data['previous'] = previous;
    return data;
  }
}
