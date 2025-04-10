class UserModel {
  final String userId;
  final String fullName;

  UserModel({required this.userId, required this.fullName});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(userId: json['userId'], fullName: json['fullName']);
  }
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'fullName': fullName};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.userId == userId && other.fullName == fullName;
  }

  @override
  int get hashCode => userId.hashCode ^ fullName.hashCode;
}
