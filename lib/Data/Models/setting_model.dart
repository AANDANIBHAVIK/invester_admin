class SettingsModel {
  Agreements? agreements;
  HowItWork? howItWork;
  PlaceHolderImg? placeHolderImg;
  PlaidKey? plaidKey;
  DocumentUrl? documentUrl;
  PlaceHolderImg? accreditedInvestorInfo;

  SettingsModel(
      {this.agreements,
      this.howItWork,
      this.placeHolderImg,
      this.plaidKey,
      this.documentUrl,
      this.accreditedInvestorInfo});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    agreements = json['Agreements'] != null
        ? new Agreements.fromJson(json['Agreements'])
        : null;
    howItWork = json['HowItWork'] != null
        ? new HowItWork.fromJson(json['HowItWork'])
        : null;
    placeHolderImg = json['PlaceHolderImg'] != null
        ? new PlaceHolderImg.fromJson(json['PlaceHolderImg'])
        : null;
    plaidKey = json['PlaidKey'] != null
        ? new PlaidKey.fromJson(json['PlaidKey'])
        : null;
    documentUrl = json['DocumentUrl'] != null
        ? new DocumentUrl.fromJson(json['DocumentUrl'])
        : null;
    accreditedInvestorInfo = json['accreditedInvestorInfo'] != null
        ? new PlaceHolderImg.fromJson(json['accreditedInvestorInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.agreements != null) {
      data['Agreements'] = this.agreements!.toJson();
    }
    if (this.howItWork != null) {
      data['HowItWork'] = this.howItWork!.toJson();
    }
    if (this.placeHolderImg != null) {
      data['PlaceHolderImg'] = this.placeHolderImg!.toJson();
    }
    if (this.plaidKey != null) {
      data['PlaidKey'] = this.plaidKey!.toJson();
    }
    if (this.documentUrl != null) {
      data['DocumentUrl'] = this.documentUrl!.toJson();
    }
    if (this.accreditedInvestorInfo != null) {
      data['accreditedInvestorInfo'] = this.accreditedInvestorInfo!.toJson();
    }
    return data;
  }
}

class Agreements {
  String? operatingAgreement;
  String? secondaryListingAgreement;
  String? securitiesTransferAgreement;

  Agreements(
      {this.operatingAgreement,
      this.secondaryListingAgreement,
      this.securitiesTransferAgreement});

  Agreements.fromJson(Map<String, dynamic> json) {
    operatingAgreement = json['OperatingAgreement'];
    secondaryListingAgreement = json['SecondaryListingAgreement'];
    securitiesTransferAgreement = json['SecuritiesTransferAgreement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OperatingAgreement'] = this.operatingAgreement;
    data['SecondaryListingAgreement'] = this.secondaryListingAgreement;
    data['SecuritiesTransferAgreement'] = this.securitiesTransferAgreement;
    return data;
  }
}

class HowItWork {
  String? content;
  List<String>? videos;

  HowItWork({this.content, this.videos});

  HowItWork.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    videos = json['videos'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['videos'] = this.videos;
    return data;
  }
}

class PlaceHolderImg {
  String? fileName;
  String? fileUrl;

  PlaceHolderImg({this.fileName, this.fileUrl});

  PlaceHolderImg.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    fileUrl = json['fileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['fileUrl'] = this.fileUrl;
    return data;
  }
}

class PlaidKey {
  String? clientId;
  String? secretkey;

  PlaidKey({this.clientId, this.secretkey});

  PlaidKey.fromJson(Map<String, dynamic> json) {
    clientId = json['ClientId'];
    secretkey = json['Secretkey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClientId'] = this.clientId;
    data['Secretkey'] = this.secretkey;
    return data;
  }
}

class DocumentUrl {
  String? privacyPolicy;
  String? customerSupport;

  DocumentUrl({this.privacyPolicy, this.customerSupport});

  DocumentUrl.fromJson(Map<String, dynamic> json) {
    privacyPolicy = json['PrivacyPolicy'];
    customerSupport = json['CustomerSupport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PrivacyPolicy'] = this.privacyPolicy;
    data['CustomerSupport'] = this.customerSupport;
    return data;
  }
}
