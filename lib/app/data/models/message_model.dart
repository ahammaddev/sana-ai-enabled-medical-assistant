class MessageModel {
  int? id;
  String? userMessage;
  String? botMessage;
  String? status;
  String? bottimestamp;
  String? usertimestamp;

  MessageModel({
    this.userMessage,
    this.botMessage,
    this.status,
    this.bottimestamp,
    this.usertimestamp,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    userMessage = json['userMessage'];
    botMessage = json['message'];
    status = json['status'];
    usertimestamp = json['usertimestamp'];
    bottimestamp = json['bottimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userMessage'] = this.userMessage;
    data['message'] = this.botMessage;
    data['status'] = this.status;
    data['bottimestamp'] = this.bottimestamp;
    data['usertimestamp'] = this.usertimestamp;
    return data;
  }
}
