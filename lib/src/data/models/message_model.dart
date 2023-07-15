import 'package:hive/hive.dart';
part 'message_model.g.dart';
enum Type { text, image }

@HiveType(typeId: 2)
class MessageModel {
  @HiveField(0)
  final String toId;
  @HiveField(1)
  final String msg;
  @HiveField(2)
  final String read;
  @HiveField(3)
  final String fromId;
  @HiveField(4)
  final String sent;
  @HiveField(5)
  final Type type;

  MessageModel({
    required this.toId,
    required this.msg,
    required this.read,
    required this.type,
    required this.fromId,
    required this.sent,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final toId = json['toId'] ?? '';
    final msg = json['msg'] ?? '';
    final read = json['read'] ?? '';
    final type =
        json['type'].toString() == Type.image.name ? Type.image : Type.text;
    final fromId = json['fromId'];
    final sent = json['sent'];

    return MessageModel(
        toId: toId,
        msg: msg,
        read: read,
        type: type,
        fromId: fromId,
        sent: sent);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['msg'] = msg;
    data['read'] = read;
    data['type'] = type.name;
    data['fromId'] = fromId;
    data['sent'] = sent;
    return data;
  }
}
