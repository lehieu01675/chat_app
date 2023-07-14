// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      image: fields[0] as String,
      listChatID: (fields[13] as List).cast<String>(),
      introduce: fields[1] as String,
      name: fields[2] as String,
      createdAt: fields[3] as String,
      lastActive: fields[4] as String,
      isOnline: fields[5] as bool,
      id: fields[7] as String,
      checkId: fields[6] as String,
      email: fields[8] as String,
      gender: fields[12] as String,
      pushToken: fields[9] as String,
      phoneNumber: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.introduce)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.lastActive)
      ..writeByte(5)
      ..write(obj.isOnline)
      ..writeByte(6)
      ..write(obj.checkId)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.email)
      ..writeByte(9)
      ..write(obj.pushToken)
      ..writeByte(10)
      ..write(obj.phoneNumber)
      ..writeByte(12)
      ..write(obj.gender)
      ..writeByte(13)
      ..write(obj.listChatID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
