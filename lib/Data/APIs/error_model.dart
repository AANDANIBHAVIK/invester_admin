class ErrorModel {
  String? displayMessage;
  String? documentationUrl;
  String? errorCode;
  String? errorMessage;
  String? errorType;
  String? requestId;
  String? suggestedAction;

  ErrorModel(
      {this.displayMessage,
      this.documentationUrl,
      this.errorCode,
      this.errorMessage,
      this.errorType,
      this.requestId,
      this.suggestedAction});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    displayMessage = json['display_message'];
    documentationUrl = json['documentation_url'];
    errorCode = json['error_code'];
    errorMessage = json['error_message'];
    errorType = json['error_type'];
    requestId = json['request_id'];
    suggestedAction = json['suggested_action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['display_message'] = displayMessage;
    data['documentation_url'] = documentationUrl;
    data['error_code'] = errorCode;
    data['error_message'] = errorMessage;
    data['error_type'] = errorType;
    data['request_id'] = requestId;
    data['suggested_action'] = suggestedAction;
    return data;
  }
}
