class PoliciesResponse {
  List<Policies>? policies;

  PoliciesResponse({this.policies});

  PoliciesResponse.fromJson(Map<String, dynamic> json) {
    if (json['policies'] != null) {
      policies = <Policies>[];
      json['policies'].forEach((v) {
        policies!.add(Policies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (policies != null) {
      data['policies'] = policies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Policies {
  String? body;
  String? createdAt;
  String? updatedAt;
  String? handle;
  String? title;
  String? url;

  Policies(
      {this.body,
        this.createdAt,
        this.updatedAt,
        this.handle,
        this.title,
        this.url});

  Policies.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    handle = json['handle'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body'] = body;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['handle'] = handle;
    data['title'] = title;
    data['url'] = url;
    return data;
  }
}
