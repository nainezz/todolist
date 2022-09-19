class UserModel {
  late String name;
  late String email;
  late DateTime createdAt, updatedAt;
  late String token;

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['user']['name'];
    email = json['user']['email'];
    createdAt = DateTime.parse(json['user']['createdAt']);
    updatedAt = DateTime.parse(json['user']['updatedAt']);
    token = json['token'];
  }
}
