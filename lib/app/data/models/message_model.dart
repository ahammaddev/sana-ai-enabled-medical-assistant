class MessageModel {
  String? userMessage;
  String? botMessage;
  String? status;

  MessageModel({this.userMessage, this.botMessage, this.status});

  MessageModel.fromJson(Map<String, dynamic> json) {
    userMessage = json['userMessage'];
    botMessage = json['botMessage'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userMessage'] = this.userMessage;
    data['botMessage'] = this.botMessage;
    data['status'] = this.status;
    return data;
  }
}
