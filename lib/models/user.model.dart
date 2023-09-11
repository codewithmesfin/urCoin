class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final int? id;
  final String? token;
  final int? createdAt;
  final int? updatedAt;

  UserModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.password,
      this.id,
      this.token,
      this.createdAt,
      this.updatedAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        email: json['email'] as String,
        phoneNumber: json['phoneNumber'] as String,
        password: json['password'] as String,
        id: json['id'],
        token: json['token'] as String,
        updatedAt: json['updatedAt'],
        createdAt: json['createdAt']);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'id': id,
      'token': token,
      'updated': updatedAt,
      'createdAt': createdAt
    };
  }
}
