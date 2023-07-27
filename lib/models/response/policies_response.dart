class PoliciesResponse {
  List<Policy>? policies;

  PoliciesResponse({
    this.policies,
  });

  factory PoliciesResponse.fromJson(Map<String, dynamic> json) => PoliciesResponse(
    policies: json["policies"] == null ? [] : List<Policy>.from(json["policies"]!.map((x) => Policy.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "policies": policies == null ? [] : List<dynamic>.from(policies!.map((x) => x.toJson())),
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
