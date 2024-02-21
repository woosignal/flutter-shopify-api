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

class CollectionItem {
  int? status;
  List<Collections>? collections;
  List<Errors>? errors;

  CollectionItem({this.status, this.collections, this.errors});

  CollectionItem.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['collections'] != null) {
      collections = <Collections>[];
      json['collections'].forEach((v) {
        collections!.add(Collections.fromJson(v));
      });
    }
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (collections != null) {
      data['collections'] = collections!.map((v) => v.toJson()).toList();
    }
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Collections {
  String? id;
  String? title;
  String? description;
  Image? image;
  String? handle;
  String? updatedAt;

  Collections(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.handle,
      this.updatedAt});

  Collections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    handle = json['handle'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['handle'] = handle;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Image {
  String? id;
  String? url;

  Image({this.id, this.url});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}

class Errors {
  String? test;

  Errors({this.test});

  Errors.fromJson(Map<String, dynamic> json) {
    test = json['test'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['test'] = test;
    return data;
  }
}
