class CompaniesModel {
  String? location;
  String? type;
  String? cid;
  String? foundedYear;
  String? name;
  String? numOfEmp;
  String? owner;
  String? sizeOfCompany;
  String? website;

  CompaniesModel(
      {this.location,
      this.type,
      this.cid,
      this.foundedYear,
      this.name,
      this.numOfEmp,
      this.owner,
      this.sizeOfCompany,
      this.website});

  CompaniesModel.fromJson(Map<String, dynamic> json) {
    location = json['Location'];
    type = json['Type'];
    cid = json['cid'];
    foundedYear = json['foundedYear'];
    name = json['name'];
    numOfEmp = json['numOfEmp'];
    owner = json['owner'];
    sizeOfCompany = json['sizeOfCompany'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Location'] = this.location;
    data['Type'] = this.type;
    data['cid'] = this.cid;
    data['foundedYear'] = this.foundedYear;
    data['name'] = this.name;
    data['numOfEmp'] = this.numOfEmp;
    data['owner'] = this.owner;
    data['sizeOfCompany'] = this.sizeOfCompany;
    data['website'] = this.website;
    return data;
  }
}
