import 'package:cloud_firestore/cloud_firestore.dart';

class AccountInfoModel {
  String accountId;
  String accountName;
  String accountNumber;
  String bankName;
  String subType;
  String accessToken;

  AccountInfoModel(
      {required this.accountId,
      required this.accountName,
      required this.accountNumber,
      required this.bankName,
      required this.subType,
      required this.accessToken});
}

class PropertyCardInfoModel {
  String? returnOnInvestment;
  String? earns;
  String? invested;
  Timestamp? investedDate;
  String? investmentValue;
  String? pid;
  List<String>? images;
  String? sold;
  String? name;

  PropertyCardInfoModel({
    this.returnOnInvestment,
    this.earns,
    this.invested,
    this.investedDate,
    this.investmentValue,
    this.pid,
    this.images,
    this.sold,
    this.name,
  });
}
