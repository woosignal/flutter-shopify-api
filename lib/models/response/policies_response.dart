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

class PoliciesResponse {
  List<Policy>? policies;

  PoliciesResponse({
    this.policies,
  });

  factory PoliciesResponse.fromJson(Map<String, dynamic> json) =>
      PoliciesResponse(
        policies: json["policies"] == null
            ? []
            : List<Policy>.from(
                json["policies"]!.map((x) => Policy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "policies": policies == null
            ? []
            : List<dynamic>.from(policies!.map((x) => x.toJson())),
      };
}

class Policy {
  String? body;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? handle;
  String? title;
  String? url;

  Policy({
    this.body,
    this.createdAt,
    this.updatedAt,
    this.handle,
    this.title,
    this.url,
  });

  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
        body: json["body"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        handle: json["handle"],
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "handle": handle,
        "title": title,
        "url": url,
      };
}
