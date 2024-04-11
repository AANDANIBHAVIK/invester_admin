import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyModel {
  AboutShare? aboutShare;
  Address? address;
  String? bundle;
  DocumentFile? cashFinancing;
  String? category;
  String? company;
  String? projectTitle;
  String? finalValue;
  String? projectDes;
  String? offer;
  DocumentFile? documents;
  List<String>? image;
  String? investPerMonth;
  String? investmentPrice;
  String? status;
  MarchDividends? marchDividends;
  String? pId;
  ProjectMetrics? projectMetrics;
  DocumentFile? propertyDetails;
  String? sold;
  String? unite;
  List<String>? video;

  PropertyModel(
      {this.aboutShare,
      this.address,
      this.bundle,
      this.cashFinancing,
      this.category,
      this.company,
      this.projectTitle,
      this.finalValue,
      this.projectDes,
      this.offer,
      this.documents,
      this.image,
      this.investPerMonth,
      this.investmentPrice,
      this.status,
      this.marchDividends,
      this.pId,
      this.projectMetrics,
      this.propertyDetails,
      this.sold,
      this.unite,
      this.video});

  PropertyModel.fromJson(Map<String, dynamic> json) {
    aboutShare = json['aboutShare'] != null
        ? AboutShare.fromJson(json['aboutShare'])
        : null;
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    bundle = json['bundle'];
    cashFinancing = json['cashFinancing'] != null
        ? DocumentFile.fromJson(json['cashFinancing'])
        : null;
    category = json['category'];
    company = json['company'];
    projectTitle = json['projectTitle'];
    finalValue = json['finalValue'];
    projectDes = json['projectDes'];
    offer = json['offer'];
    documents = json['documents'] != null
        ? DocumentFile.fromJson(json['documents'])
        : null;
    image = json['image'].cast<String>();
    investPerMonth = json['investPerMonth'];
    investmentPrice = json['investmentPrice'];
    status = json['status'];
    marchDividends = json['marchDividends'] != null
        ? MarchDividends.fromJson(json['marchDividends'])
        : null;
    pId = json['pId'];
    projectMetrics = json['projectMetrics'] != null
        ? ProjectMetrics.fromJson(json['projectMetrics'])
        : null;
    propertyDetails = json['propertyDetails'] != null
        ? DocumentFile.fromJson(json['propertyDetails'])
        : null;
    sold = json['sold'];
    unite = json['unite'];
    video = json['video'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (aboutShare != null) {
      data['aboutShare'] = aboutShare!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (bundle != null) {
      data['bundle'] = bundle;
    }
    if (cashFinancing != null) {
      data['cashFinancing'] = cashFinancing!.toJson();
    }
    if (category != null) {
      data['category'] = category;
    }
    if (company != null) {
      data['company'] = company;
    }
    if (projectTitle != null) {
      data['projectTitle'] = projectTitle;
    }
    if (finalValue != null) {
      data['finalValue'] = finalValue;
    }
    if (projectDes != null) {
      data['projectDes'] = projectDes;
    }
    if (offer != null) {
      data['offer'] = offer;
    }
    if (documents != null) {
      data['documents'] = documents!.toJson();
    }
    if (image != null) {
      data['image'] = image;
    }
    if (investPerMonth != null) {
      data['investPerMonth'] = investPerMonth;
    }
    if (investmentPrice != null) {
      data['investmentPrice'] = investmentPrice;
    }
    if (status != null) {
      data['status'] = status;
    }
    if (marchDividends != null) {
      data['marchDividends'] = marchDividends!.toJson();
    }
    if (pId != null) {
      data['pId'] = pId;
    }
    if (projectMetrics != null) {
      data['projectMetrics'] = projectMetrics!.toJson();
    }
    if (propertyDetails != null) {
      data['propertyDetails'] = propertyDetails!.toJson();
    }
    if (sold != null) {
      data['sold'] = sold;
    }
    if (unite != null) {
      data['unite'] = unite;
    }
    if (video != null) {
      data['video'] = video;
    }
    return data;
  }
}

class AboutShare {
  String? avgPurchase;
  String? perShare;
  String? shareLeft;

  AboutShare({this.avgPurchase, this.perShare, this.shareLeft});

  AboutShare.fromJson(Map<String, dynamic> json) {
    avgPurchase = json['avgPurchase'];
    perShare = json['perShare'];
    shareLeft = json['shareLeft'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (avgPurchase != null) {
      data['avgPurchase'] = avgPurchase;
    }
    if (perShare != null) {
      data['perShare'] = perShare;
    }
    if (shareLeft != null) {
      data['shareLeft'] = shareLeft;
    }
    return data;
  }
}

class Address {
  String? city;
  String? country;
  String? street;
  String? zipCode;

  Address({this.city, this.country, this.street, this.zipCode});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    street = json['street'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (city != null) {
      data['city'] = city;
    }
    if (country != null) {
      data['country'] = country;
    }
    if (street != null) {
      data['street'] = street;
    }
    if (zipCode != null) {
      data['zipCode'] = zipCode;
    }

    return data;
  }
}

class MarchDividends {
  String? afterDevValue;
  String? annualCollection;
  String? devCapRate;
  Timestamp? dispositionDate;

  MarchDividends(
      {this.afterDevValue,
      this.annualCollection,
      this.devCapRate,
      this.dispositionDate});

  MarchDividends.fromJson(Map<String, dynamic> json) {
    afterDevValue = json['afterDevValue'];
    annualCollection = json['annualCollection'];
    devCapRate = json['devCapRate'];
    dispositionDate = json['dispositionDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (afterDevValue != null) {
      data['afterDevValue'] = afterDevValue;
    }

    if (annualCollection != null) {
      data['annualCollection'] = annualCollection;
    }

    if (devCapRate != null) {
      data['devCapRate'] = devCapRate;
    }

    if (dispositionDate != null) {
      data['dispositionDate'] = dispositionDate;
    }

    return data;
  }
}

class ProjectMetrics {
  String? afterDevARC;
  String? afterDevCapRate;
  String? afterDevValue;
  Timestamp? estimatedDispositionDate;

  ProjectMetrics(
      {this.afterDevARC,
      this.afterDevCapRate,
      this.afterDevValue,
      this.estimatedDispositionDate});

  ProjectMetrics.fromJson(Map<String, dynamic> json) {
    afterDevARC = json['afterDevARC'];
    afterDevCapRate = json['afterDevCapRate'];
    afterDevValue = json['afterDevValue'];
    estimatedDispositionDate = json['estimatedDispositionDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (afterDevARC != null) {
      data['afterDevARC'] = afterDevARC;
    }
    if (afterDevCapRate != null) {
      data['afterDevCapRate'] = afterDevCapRate;
    }
    if (afterDevValue != null) {
      data['afterDevValue'] = afterDevValue;
    }
    if (estimatedDispositionDate != null) {
      data['estimatedDispositionDate'] = estimatedDispositionDate;
    }
    return data;
  }
}

class DocumentFile {
  String? fileName;
  String? fileUrl;

  DocumentFile({this.fileName, this.fileUrl});

  DocumentFile.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    fileUrl = json['fileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fileName != null) {
      data['fileName'] = fileName;
    }
    if (fileUrl != null) {
      data['fileUrl'] = fileUrl;
    }
    return data;
  }
}
