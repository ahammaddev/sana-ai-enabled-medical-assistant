class ConsultationModel {
  String id;
  String title;
  String createdAt;
  String updatedAt;
  String? lastMessage;

  ConsultationModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessage,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> json) {
    return ConsultationModel(
      id: json['id'] as String,
      title: json['title'] as String? ?? 'New Consultation',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      lastMessage: json['lastMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'lastMessage': lastMessage,
    };
  }
}
