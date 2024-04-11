class FaqModel {
  String? qid;
  Questions? questions;

  FaqModel({this.qid, this.questions});

  FaqModel.fromJson(Map<String, dynamic> json) {
    qid = json['qid'];
    questions = json['questions'] != null
        ? new Questions.fromJson(json['questions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qid'] = this.qid;
    if (this.questions != null) {
      data['questions'] = this.questions!.toJson();
    }
    return data;
  }
}

class Questions {
  String? answer;
  String? question;

  Questions({this.answer, this.question});

  Questions.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['question'] = this.question;
    return data;
  }
}
