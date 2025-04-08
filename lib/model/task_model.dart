import 'package:taskmgt/model/status.dart';

class TaskModel {
  final String id;
  final String title;
  final String note;
  final String date;
  final String startTime;
  final String endTime;
  final String userId;
  final Status status;

  TaskModel({
    required this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.userId,
    required this.status,
  });

  TaskModel copyWith({String? id, String? title, String? note, String? date, String? startTime, String? endTime, String? userId, Status? status}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      userId: userId ?? this.userId,
      status: status ?? this.status,
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      note: json['note'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      userId: json['userId'],
      status: Status.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => Status.pending, // default fallback
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'userId': userId,
      'status': status.name,
    };
  }

  TaskModel changeStatus() {
    switch (status) {
      case Status.pending:
        return copyWith(status: Status.running);
      case Status.running:
        return copyWith(status: Status.testing);
      case Status.testing:
        return copyWith(status: Status.completed);
      case Status.completed:
        return this;
    }
  }

  @override
  String toString() {
    return 'TaskModel{id: $id, title: $title, note: $note, date: $date, startTime: $startTime, endTime: $endTime ,status:${status.name}';
  }
}
