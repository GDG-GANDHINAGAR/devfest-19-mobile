class Sponsor {
  String name;
  // String image;
  String desc;
  String redirectUrl;
  String logo;

  Sponsor({this.name, this.desc, this.redirectUrl, this.logo});

  Sponsor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    // image = json['image'];
    desc = json['desc'];
    redirectUrl = json['redirectUrl'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    // data['image'] = this.image;
    data['desc'] = this.desc;
    data['redirectUrl'] = this.redirectUrl;
    data['logo'] = this.logo;
    return data;
  }
}
