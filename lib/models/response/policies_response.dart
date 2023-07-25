class PoliciesResponse {
  List<Policies>? policies;

  PoliciesResponse({this.policies});

  PoliciesResponse.fromJson(Map<String, dynamic> json) {
    if (json['policies'] != null) {
      policies = <Policies>[];
      json['policies'].forEach((v) {
        policies!.add(new Policies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.policies != null) {
      data['policies'] = this.policies!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['handle'] = this.handle;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}
