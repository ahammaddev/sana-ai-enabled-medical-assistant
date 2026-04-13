class MessageModel {
  String? userMessage;
  String? botMessage;
  String? status;

  MessageModel({this.botMessage, this.status});

  MessageModel.fromJson(Map<String, dynamic> json) {
    userMessage = json['userMessage'];
    botMessage = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userMessage'] = this.userMessage;
    data['message'] = this.botMessage;
    data['status'] = this.status;
    return data;
  }
}
