import 'package:hive_flutter/adapters.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String image;
  @HiveField(1)
  final String introduce;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String createdAt;
  @HiveField(4)
  final String lastActive;
  @HiveField(5)
  final bool isOnline;
  @HiveField(6)
  final String checkId;
  @HiveField(7)
  final String id;
  @HiveField(8)
  final String email;
  @HiveField(9)
  String pushToken;
  @HiveField(10)
  final String phoneNumber;
  @HiveField(12)
  final String gender;
  @HiveField(13)
  List<String> listChatID;

  UserModel({
    required this.image,
    required this.listChatID,
    required this.introduce,
    required this.name,
    required this.createdAt,
    required this.lastActive,
    required this.isOnline,
    required this.id,
    required this.checkId,
    required this.email,
    required this.gender,
    required this.pushToken,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final image = json['image'] ?? '';
    final introduce = json['introduce'] ?? '';
    final name = json['name'] ?? '';
    final createdAt = json['created_at'] ?? '';
    final lastActive = json['last_active'] ?? '';
    final isOnline = json['is_online'] ?? false;
    final id = json['id'] ?? '';
    final email = json['email'] ?? '';
    final pushToken = json['push_token'] ?? '';
    final phoneNumber = json['phone_number'] ?? '';
    final checkId = json['check_id'] ?? '';
    final gender = json['gender'] ?? '';
    final List<String> listChatID = [];
    json['listChatID'].forEach((value) {
      listChatID.add(value);
    });
    return UserModel(
        listChatID: listChatID,
        image: image,
        introduce: introduce,
        name: name,
        createdAt: createdAt,
        lastActive: lastActive,
        isOnline: isOnline,
        id: id,
        email: email,
        gender: gender,
        checkId: checkId,
        pushToken: pushToken,
        phoneNumber: phoneNumber);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['introduce'] = introduce;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['gender'] = gender;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['push_token'] = pushToken;
    data['check_id'] = checkId;
    data['phone_number'] = phoneNumber;
    data['listChatID'] = listChatID;
    return data;
  }
}
