class TransferModel {
  List<Transfers>? transfers;
  String? requestId;

  TransferModel({this.transfers, this.requestId});

  TransferModel.fromJson(Map<String, dynamic> json) {
    if (json['transfers'] != null) {
      transfers = <Transfers>[];
      json['transfers'].forEach((v) {
        transfers!.add(Transfers.fromJson(v));
      });
    }
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transfers != null) {
      data['transfers'] = transfers!.map((v) => v.toJson()).toList();
    }
    data['request_id'] = requestId;
    return data;
  }
}

class Transfers {
  String? accountId;
  String? fundingAccountId;
  String? achClass;
  String? amount;
  bool? cancellable;
  String? created;
  String? description;
  String? guaranteeDecision;
  String? guaranteeDecisionRationale;
  FailureReason? failureReason;
  String? id;
  Metadata? metadata;
  String? network;
  String? originationAccountId;
  String? originatorClientId;
  List<String>? refunds;
  String? status;
  String? type;
  String? isoCurrencyCode;
  String? standardReturnWindow;
  String? unauthorizedReturnWindow;
  String? expectedSettlementDate;
  User? user;
  String? recurringTransferId;
  String? creditFundsSource;

  Transfers(
      {this.accountId,
        this.fundingAccountId,
        this.achClass,
        this.amount,
        this.cancellable,
        this.created,
        this.description,
        this.guaranteeDecision,
        this.guaranteeDecisionRationale,
        this.failureReason,
        this.id,
        this.metadata,
        this.network,
        this.originationAccountId,
        this.originatorClientId,
        this.refunds,
        this.status,
        this.type,
        this.isoCurrencyCode,
        this.standardReturnWindow,
        this.unauthorizedReturnWindow,
        this.expectedSettlementDate,
        this.user,
        this.recurringTransferId,
        this.creditFundsSource});

  Transfers.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    fundingAccountId = json['funding_account_id'];
    achClass = json['ach_class'];
    amount = json['amount'];
    cancellable = json['cancellable'];
    created = json['created'];
    description = json['description'];
    guaranteeDecision = json['guarantee_decision'];
    guaranteeDecisionRationale = json['guarantee_decision_rationale'];
    failureReason = json['failure_reason'] != null
        ? FailureReason.fromJson(json['failure_reason'])
        : null;
    id = json['id'];
    metadata = json['metadata'] != null
        ? Metadata.fromJson(json['metadata'])
        : null;
    network = json['network'];
    originationAccountId = json['origination_account_id'];
    originatorClientId = json['originator_client_id'];
    refunds = json['refunds'].cast<String>();
    status = json['status'];
    type = json['type'];
    isoCurrencyCode = json['iso_currency_code'];
    standardReturnWindow = json['standard_return_window'];
    unauthorizedReturnWindow = json['unauthorized_return_window'];
    expectedSettlementDate = json['expected_settlement_date'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    recurringTransferId = json['recurring_transfer_id'];
    creditFundsSource = json['credit_funds_source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_id'] = accountId;
    data['funding_account_id'] = fundingAccountId;
    data['ach_class'] = achClass;
    data['amount'] = amount;
    data['cancellable'] = cancellable;
    data['created'] = created;
    data['description'] = description;
    data['guarantee_decision'] = guaranteeDecision;
    data['guarantee_decision_rationale'] = guaranteeDecisionRationale;
    if (failureReason != null) {
      data['failure_reason'] = failureReason!.toJson();
    }
    data['id'] = id;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    data['network'] = network;
    data['origination_account_id'] = originationAccountId;
    data['originator_client_id'] = originatorClientId;
    data['refunds'] = refunds;
    data['status'] = status;
    data['type'] = type;
    data['iso_currency_code'] = isoCurrencyCode;
    data['standard_return_window'] = standardReturnWindow;
    data['unauthorized_return_window'] = unauthorizedReturnWindow;
    data['expected_settlement_date'] = expectedSettlementDate;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['recurring_transfer_id'] = recurringTransferId;
    data['credit_funds_source'] = creditFundsSource;
    return data;
  }
}

class FailureReason {
  String? achReturnCode;
  String? description;

  FailureReason({this.achReturnCode, this.description});

  FailureReason.fromJson(Map<String, dynamic> json) {
    achReturnCode = json['ach_return_code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ach_return_code'] = achReturnCode;
    data['description'] = description;
    return data;
  }
}

class Metadata {
  String? key1;
  String? key2;

  Metadata({this.key1, this.key2});

  Metadata.fromJson(Map<String, dynamic> json) {
    key1 = json['key1'];
    key2 = json['key2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key1'] = key1;
    data['key2'] = key2;
    return data;
  }
}

class User {
  String? emailAddress;
  String? legalName;
  String? phoneNumber;
  Address? address;

  User({this.emailAddress, this.legalName, this.phoneNumber, this.address});

  User.fromJson(Map<String, dynamic> json) {
    emailAddress = json['email_address'];
    legalName = json['legal_name'];
    phoneNumber = json['phone_number'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email_address'] = emailAddress;
    data['legal_name'] = legalName;
    data['phone_number'] = phoneNumber;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class Address {
  String? street;
  String? city;
  String? region;
  String? postalCode;
  String? country;

  Address({this.street, this.city, this.region, this.postalCode, this.country});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    region = json['region'];
    postalCode = json['postal_code'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['city'] = city;
    data['region'] = region;
    data['postal_code'] = postalCode;
    data['country'] = country;
    return data;
  }
}