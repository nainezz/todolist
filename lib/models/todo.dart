class TodoModel {
  late String id;
  late String description;
  late bool completed;
  late DateTime createdAt, updatedAt;

  late String owner;

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];

    description = json['description'];
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    owner = json['owner'];
    completed = json['completed'];
  }
}
