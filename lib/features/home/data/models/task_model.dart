class TaskModel {
  String? title;
  String? content;
  String? date;
  String? image;
  String? status;
  String? importanceLevel;

  TaskModel({
    this.title,
    this.content,
    this.date,
    this.image,
    this.status,
    this.importanceLevel,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json['title'] as String?,
        content: json['content'] as String?,
        date: json['date'] as String?,
        image: json['image'] as String?,
        status: json['status'] as String?,
        importanceLevel: json['importance_level'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'date': date,
        'image': image,
        'status': status,
        'importance_level': importanceLevel,
      };
}
