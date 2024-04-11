class OffersModel {
  String? offerType;
  String? oid;
  String? returnTarget;
  String? subTitle;
  List<String>? tags;
  String? title;

  OffersModel(
      {this.offerType,
      this.oid,
      this.returnTarget,
      this.subTitle,
      this.tags,
      this.title});

  OffersModel.fromJson(Map<String, dynamic> json) {
    offerType = json['offerType'];
    oid = json['oid'];
    returnTarget = json['returnTarget'];
    subTitle = json['subTitle'];
    tags = json['tags'].cast<String>();
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offerType'] = this.offerType;
    data['oid'] = this.oid;
    data['returnTarget'] = this.returnTarget;
    data['subTitle'] = this.subTitle;
    data['tags'] = this.tags;
    data['title'] = this.title;
    return data;
  }
}
