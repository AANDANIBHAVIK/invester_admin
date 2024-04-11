import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  AccountInfo? accountInfo;
  BankAccountInfo? bankAccountInfo;
  List<PropertyInfo>? propertyInfo;
  String? email;
  String? status;
  String? signInWith;
  String? phone;
  String? fName;
  String? profileImg;
  String? uid;

  UserModel(
      {this.accountInfo,
      this.bankAccountInfo,
      this.propertyInfo,
      this.email,
      this.status,
      this.signInWith,
      this.phone,
      this.fName,
      this.profileImg,
      this.uid});

  UserModel.fromJson(Map<String, dynamic> json) {
    accountInfo = json['accountInfo'] != null
        ? AccountInfo.fromJson(json['accountInfo'])
        : null;
    bankAccountInfo = json['bankAccountInfo'] != null
        ? BankAccountInfo.fromJson(json['bankAccountInfo'])
        : null;
    if (json['propertyInfo'] != null) {
      propertyInfo = <PropertyInfo>[];
      json['propertyInfo'].forEach((v) {
        propertyInfo!.add(new PropertyInfo.fromJson(v));
      });
    }
    email = json['email'];
    status = json['status'];
    signInWith = json['signInWith'];
    phone = json['phone'];
    fName = json['fName'];
    profileImg = json['profileImg'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (accountInfo != null) {
      data['accountInfo'] = accountInfo!.toJson();
    }
    if (bankAccountInfo != null) {
      data['bankAccountInfo'] = bankAccountInfo!.toJson();
    }
    if (email != null) {
      data['email'] = email;
    }
    if (status != null) {
      data['status'] = status;
    }
    if (signInWith != null) {
      data['signInWith'] = signInWith;
    }
    if (phone != null) {
      data['phone'] = phone;
    }
    if (fName != null) {
      data['fName'] = fName;
    }
    if (profileImg != null) {
      data['profileImg'] = profileImg;
    }
    if (propertyInfo != null) {
      data['propertyInfo'] = propertyInfo!.map((v) => v.toJson()).toList();
    }
    if (uid != null) {
      data['uid'] = uid;
    }
    return data;
  }
}

class BankAccountInfo {
  List<Items>? items;
  List<Transactions>? transactions;

  BankAccountInfo({this.items, this.transactions});

  BankAccountInfo.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? accessToken;
  String? accountId;
  String? itemsID;
  String? institutionName;
  String? holderName;
  String? accountNumber;

  Items(
      {this.accessToken,
      this.accountId,
      this.itemsID,
      this.institutionName,
      this.holderName,
      this.accountNumber});

  Items.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    accountId = json['accountId'];
    itemsID = json['itemsID'];
    institutionName = json['institutionName'];
    holderName = json['holderName'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (accessToken != null) {
      data['accessToken'] = accessToken;
    }
    if (accountId != null) {
      data['accountId'] = accountId;
    }
    if (itemsID != null) {
      data['itemsID'] = itemsID;
    }
    if (institutionName != null) {
      data['institutionName'] = institutionName;
    }
    if (holderName != null) {
      data['holderName'] = holderName;
    }
    if (accountNumber != null) {
      data['accountNumber'] = accountNumber;
    }
    return data;
  }
}

class Transactions {
  String? propertyImg;
  String? transferId;
  String? date;
  String? propertyName;
  String? amount;

  Transactions(
      {this.propertyImg,
      this.transferId,
      this.date,
      this.propertyName,
      this.amount});

  Transactions.fromJson(Map<String, dynamic> json) {
    propertyImg = json['propertyImg'];
    transferId = json['transferId'];
    date = json['date'];
    propertyName = json['propertyName'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (propertyImg != null) {
      data['propertyImg'] = propertyImg;
    }
    if (transferId != null) {
      data['transferId'] = transferId;
    }
    if (date != null) {
      data['date'] = date;
    }
    if (amount != null) {
      data['amount'] = amount;
    }
    if (propertyName != null) {
      data['propertyName'] = propertyName;
    }
    return data;
  }
}

class AccountInfo {
  AccountType? accountType;
  String? type;

  AccountInfo({this.accountType, this.type});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    accountType = json['accountType'] != null
        ? AccountType.fromJson(json['accountType'])
        : null;
    type = json['typeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (accountType != null) {
      data['accountType'] = accountType!.toJson();
    }
    // if (type != null) {
    data['typeName'] = type;
    // }
    return data;
  }
}

class AccountType {
  Enterprise? enterprise;
  Individual? individual;

  AccountType({this.enterprise, this.individual});

  AccountType.fromJson(Map<String, dynamic> json) {
    enterprise = json['enterprise'] != null
        ? Enterprise.fromJson(json['enterprise'])
        : null;
    individual = json['individual'] != null
        ? Individual.fromJson(json['individual'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (enterprise != null) {
      data['enterprise'] = enterprise!.toJson();
    }
    if (individual != null) {
      data['individual'] = individual!.toJson();
    }

    return data;
  }
}

class Enterprise {
  Documents? documents;
  EmpInfoEnterprise? empInfoEnterprise;
  List<String>? statements;

  Enterprise({this.documents, this.empInfoEnterprise, this.statements});

  Enterprise.fromJson(Map<String, dynamic> json) {
    documents = json['documents'] != null
        ? Documents.fromJson(json['documents'])
        : null;
    empInfoEnterprise = json['empInfoEnterprise'] != null
        ? EmpInfoEnterprise.fromJson(json['empInfoEnterprise'])
        : null;
    if (json['statements'] != null) {
      statements = <String>[];
      json['statements'].forEach((v) {
        statements!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (documents != null) {
      data['documents'] = documents!.toJson();
    }
    if (empInfoEnterprise != null) {
      data['empInfoEnterprise'] = empInfoEnterprise!.toJson();
    }
    if (statements != null) {
      data['statements'] = statements!.map((v) => v).toList();
    }

    return data;
  }
}

class Documents {
  DocumentUserFile? eniVerification;
  DocumentUserFile? formationCertificate;
  DocumentUserFile? operatingAgreement;

  Documents(
      {this.eniVerification,
      this.formationCertificate,
      this.operatingAgreement});

  Documents.fromJson(Map<String, dynamic> json) {
    eniVerification = json['eniVerification'] != null
        ? new DocumentUserFile.fromJson(json['eniVerification'])
        : null;
    formationCertificate = json['formationCertificate'] != null
        ? new DocumentUserFile.fromJson(json['formationCertificate'])
        : null;
    operatingAgreement = json['operatingAgreement'] != null
        ? new DocumentUserFile.fromJson(json['operatingAgreement'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eniVerification != null) {
      data['eniVerification'] = eniVerification!.toJson();
    }
    if (formationCertificate != null) {
      data['formationCertificate'] = formationCertificate!.toJson();
    }
    if (operatingAgreement != null) {
      data['operatingAgreement'] = operatingAgreement!.toJson();
    }
    return data;
  }
}

class EmpInfoEnterprise {
  String? empIndentificationNum;
  String? enterpriceName;
  Timestamp? formationDate;
  String? signatoryTitle;

  EmpInfoEnterprise(
      {this.empIndentificationNum,
      this.enterpriceName,
      this.formationDate,
      this.signatoryTitle});

  EmpInfoEnterprise.fromJson(Map<String, dynamic> json) {
    empIndentificationNum = json['empIndentificationNum'];
    enterpriceName = json['enterpriceName'];
    formationDate = json['formationDate'];
    signatoryTitle = json['signatoryTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (empIndentificationNum != null) {
      data['empIndentificationNum'] = empIndentificationNum;
    }
    if (enterpriceName != null) {
      data['enterpriceName'] = enterpriceName;
    }

    if (formationDate != null) {
      data['formationDate'] = formationDate;
    }
    if (signatoryTitle != null) {
      data['signatoryTitle'] = signatoryTitle;
    }
    return data;
  }
}

// class FormationDate {
//   String? sTime;
//
//   FormationDate({this.sTime});
//
//   FormationDate.fromJson(Map<String, dynamic> json) {
//     sTime = json['__time__'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['__time__'] = sTime;
//     return data;
//   }
// }

class Individual {
  String? amiaAccount;
  Document? document;
  EmpInfoIndividual? empInfoIndividual;
  String? empStatus;
  bool? isAccredited;
  bool? isMemberStock;
  bool? isPolitical;
  PersonalInfo? personalInfo;
  String? relationStatus;
  String? riskLevel;

  Individual(
      {this.amiaAccount,
      this.document,
      this.empInfoIndividual,
      this.empStatus,
      this.isAccredited,
      this.isMemberStock,
      this.isPolitical,
      this.personalInfo,
      this.relationStatus,
      this.riskLevel});

  Individual.fromJson(Map<String, dynamic> json) {
    amiaAccount = json['amiaAccount'];
    document =
        json['document'] != null ? Document.fromJson(json['document']) : null;
    empInfoIndividual = json['empInfoIndividual'] != null
        ? EmpInfoIndividual.fromJson(json['empInfoIndividual'])
        : null;
    empStatus = json['empStatus'];
    isAccredited = json['isAccredited'];
    isMemberStock = json['isMemberStock'];
    isPolitical = json['isPolitical'];
    personalInfo = json['personalInfo'] != null
        ? PersonalInfo.fromJson(json['personalInfo'])
        : null;
    relationStatus = json['relationStatus'];
    riskLevel = json['riskLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (amiaAccount != null) {
      data['amiaAccount'] = amiaAccount;
    }
    if (document != null) {
      data['document'] = document!.toJson();
    }
    if (empInfoIndividual != null) {
      data['empInfoIndividual'] = empInfoIndividual!.toJson();
    }
    if (empStatus != null) {
      data['empStatus'] = empStatus;
    }
    if (isAccredited != null) {
      data['isAccredited'] = isAccredited;
    }
    if (isMemberStock != null) {
      data['isMemberStock'] = isMemberStock;
    }
    if (isPolitical != null) {
      data['isPolitical'] = isPolitical;
    }
    if (personalInfo != null) {
      data['personalInfo'] = personalInfo!.toJson();
    }
    if (relationStatus != null) {
      data['relationStatus'] = relationStatus;
    }
    if (riskLevel != null) {
      data['riskLevel'] = riskLevel;
    }
    return data;
  }
}

class Document {
  String? drivingLicenseName;
  String? drivingLicenseUrl;
  String? socialSecurityName;
  String? socialSecurityUrl;

  Document(
      {this.drivingLicenseName,
      this.drivingLicenseUrl,
      this.socialSecurityName,
      this.socialSecurityUrl});

  Document.fromJson(Map<String, dynamic> json) {
    drivingLicenseName = json['drivingLicenseName'];
    drivingLicenseUrl = json['drivingLicenseUrl'];
    socialSecurityName = json['socialSecurityName'];
    socialSecurityUrl = json['socialSecurityUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['drivingLicenseName'] = this.drivingLicenseName;
    data['drivingLicenseUrl'] = this.drivingLicenseUrl;
    data['socialSecurityName'] = this.socialSecurityName;
    data['socialSecurityUrl'] = this.socialSecurityUrl;
    return data;
  }
}

class EmpInfoIndividual {
  String? empName;
  String? jobTitle;
  String? occupationIndustry;

  EmpInfoIndividual({this.empName, this.jobTitle, this.occupationIndustry});

  EmpInfoIndividual.fromJson(Map<String, dynamic> json) {
    empName = json['empName'];
    jobTitle = json['jobTitle'];
    occupationIndustry = json['occupationIndustry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (empName != null) {
      data['empName'] = empName;
    }
    if (jobTitle != null) {
      data['jobTitle'] = jobTitle;
    }
    if (occupationIndustry != null) {
      data['occupationIndustry'] = occupationIndustry;
    }
    return data;
  }
}

class PersonalInfo {
  Timestamp? dob;
  String? address;
  String? city;
  String? state;
  String? zip;
  String? socialNumber;

  PersonalInfo(
      {this.dob,
      this.address,
      this.city,
      this.state,
      this.zip,
      this.socialNumber});

  PersonalInfo.fromJson(Map<String, dynamic> json) {
    dob = json['dob'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    socialNumber = json['socialNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dob != null) {
      data['dob'] = dob;
    }
    if (address != null) {
      data['address'] = address;
    }
    if (city != null) {
      data['city'] = city;
    }
    if (state != null) {
      data['state'] = state;
    }
    if (zip != null) {
      data['zip'] = zip;
    }
    if (socialNumber != null) {
      data['socialNumber'] = socialNumber;
    }
    return data;
  }
}

class PropertyInfo {
  String? returnOnInvestment;
  String? earns;
  String? invested;
  Timestamp? investedDate;
  String? investmentValue;
  String? transferId;
  String? pid;

  PropertyInfo(
      {this.returnOnInvestment,
      this.earns,
      this.invested,
      this.investedDate,
      this.investmentValue,
      this.transferId,
      this.pid});

  PropertyInfo.fromJson(Map<String, dynamic> json) {
    returnOnInvestment = json['ReturnOnInvestment'];
    earns = json['earns'];
    invested = json['invested'];
    investedDate = json['investedDate'];
    investmentValue = json['investmentValue'];
    transferId = json['transferId'];
    pid = json['pid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (returnOnInvestment != null) {
      data['ReturnOnInvestment'] = returnOnInvestment;
    }
    if (earns != null) {
      data['earns'] = earns;
    }
    if (invested != null) {
      data['invested'] = invested;
    }
    if (investmentValue != null) {
      data['investmentValue'] = investmentValue;
    }
    if (investmentValue != null) {
      data['investedDate'] = investedDate;
    }
    if (transferId != null) {
      data['transferId'] = transferId;
    }
    if (pid != null) {
      data['pid'] = pid;
    }
    return data;
  }
}

class DocumentUserFile {
  String? fileName;
  String? fileUrl;

  DocumentUserFile({this.fileName, this.fileUrl});

  DocumentUserFile.fromJson(Map<String, dynamic> json) {
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
