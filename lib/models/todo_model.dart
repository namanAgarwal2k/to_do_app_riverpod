class TodoModel {
  int? id;
  String? title;
  String? body;
  DateTime? date;

  TodoModel({this.id, this.body, this.date, this.title});

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "body": body,
      "date": date.toString(),
    });
  }

  factory TodoModel.fromMap(Map<String, Object?> map) {
    return TodoModel(
      id: map["id"] as int?,
      title: map["title"] as String?,
      body: map["body"] as String?,
      date: DateTime.now(),
    );
  }
}
