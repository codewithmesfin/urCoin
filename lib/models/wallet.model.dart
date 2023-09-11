class WalletModel {
  int id;
  int userId;
  String key;
  String address;
  String name;
  int createdAt;
  int updatedAt;

  WalletModel({
    required this.id,
    required this.userId,
    required this.key,
    required this.address,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'],
      userId: json['userId'],
      key: json['key'],
      address: json['address'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'key': key,
      'address': address,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
