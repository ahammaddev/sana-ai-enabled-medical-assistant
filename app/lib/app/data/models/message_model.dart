class MessageModel {
  int? id;
  String? sessionId;
  String? userMessage;
  String? botMessage;
  String? status;
  String? bottimestamp;
  String? usertimestamp;

  MessageModel({
    this.id,
    this.sessionId,
    this.userMessage,
    this.botMessage,
    this.status,
    this.bottimestamp,
    this.usertimestamp,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['sessionId'];
    userMessage = json['userMessage'];
    botMessage = json['message'];
    status = json['status'];
    usertimestamp = json['usertimestamp'];
    bottimestamp = json['bottimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    data['sessionId'] = sessionId;
    data['userMessage'] = userMessage;
    data['message'] = botMessage;
    data['status'] = status;
    data['bottimestamp'] = bottimestamp;
    data['usertimestamp'] = usertimestamp;
    return data;
  }
}
