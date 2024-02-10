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

class SmartCollectionResponse {
  List<SmartCollections>? smartCollections;
  PageLink? pageLink;

  SmartCollectionResponse({this.smartCollections, this.pageLink});

  SmartCollectionResponse.fromJson(Map<String, dynamic> json) {
    if (json['smart_collections'] != null) {
      smartCollections = [];
      json['smart_collections'].forEach((v) {
        smartCollections!.add(SmartCollections.fromJson(v));
      });
    }
    pageLink =
        json['page_link'] != null ? PageLink.fromJson(json['page_link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (smartCollections != null) {
      data['smart_collections'] =
          smartCollections!.map((v) => v.toJson()).toList();
    }
    if (pageLink != null) {
      data['page_link'] = pageLink!.toJson();
    }
    return data;
  }
}

class SmartCollections {
  int? id;
  String? handle;
  String? title;
  String? updatedAt;
  String? bodyHtml;
  String? publishedAt;
  String? sortOrder;
  String? templateSuffix;
  bool? disjunctive;
  List<Rules>? rules;
  String? publishedScope;
  String? adminGraphqlApiId;

  SmartCollections(
      {this.id,
      this.handle,
      this.title,
      this.updatedAt,
      this.bodyHtml,
      this.publishedAt,
      this.sortOrder,
      this.templateSuffix,
      this.disjunctive,
      this.rules,
      this.publishedScope,
      this.adminGraphqlApiId});

  SmartCollections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    handle = json['handle'];
    title = json['title'];
    updatedAt = json['updated_at'];
    bodyHtml = json['body_html'];
    publishedAt = json['published_at'];
    sortOrder = json['sort_order'];
    templateSuffix = json['template_suffix'];
    disjunctive = json['disjunctive'];
    if (json['rules'] != null) {
      rules = [];
      json['rules'].forEach((v) {
        rules!.add(Rules.fromJson(v));
      });
    }
    publishedScope = json['published_scope'];
    adminGraphqlApiId = json['admin_graphql_api_id'];
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
    data['disjunctive'] = disjunctive;
    if (rules != null) {
      data['rules'] = rules!.map((v) => v.toJson()).toList();
    }
    data['published_scope'] = publishedScope;
    data['admin_graphql_api_id'] = adminGraphqlApiId;
    return data;
  }
}

class Rules {
  String? column;
  String? relation;
  String? condition;

  Rules({this.column, this.relation, this.condition});

  Rules.fromJson(Map<String, dynamic> json) {
    column = json['column'];
    relation = json['relation'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['column'] = column;
    data['relation'] = relation;
    data['condition'] = condition;
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
