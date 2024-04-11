class DocumentsModel {
  Documents? documents;
  String? did;

  DocumentsModel({this.documents, this.did});

  DocumentsModel.fromJson(Map<String, dynamic> json) {
    documents = json['Documents'] != null
        ? new Documents.fromJson(json['Documents'])
        : null;
    did = json['did'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.documents != null) {
      data['Documents'] = this.documents!.toJson();
    }
    data['did'] = this.did;
    return data;
  }
}

class Documents {
  String? fileName;
  String? fileUrl;

  Documents({this.fileName, this.fileUrl});

  Documents.fromJson(Map<String, dynamic> json) {
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
