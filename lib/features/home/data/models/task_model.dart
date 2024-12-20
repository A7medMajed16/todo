class TaskModel {
  String? id;
  String? title;
  String? content;
  String? date;
  String? image;
  String? status;
  String? importanceLevel;

  TaskModel({
    this.id,
    this.title,
    this.content,
    this.date,
    this.image,
    this.status,
    this.importanceLevel,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'] as String?,
        title: json['title'] as String?,
        content: json['content'] as String?,
        date: json['date'] as String?,
        image: json['image'] as String?,
        status: json['status'] as String?,
        importanceLevel: json['importance_level'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'date': date,
        'image': image,
        'status': status,
        'importance_level': importanceLevel,
      };
}
