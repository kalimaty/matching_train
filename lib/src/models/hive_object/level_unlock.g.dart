// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_unlock.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LevelUnlockAdapter extends TypeAdapter<LevelUnlock> {
  @override
  final int typeId = 0;

  @override
  LevelUnlock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LevelUnlock(
      level: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LevelUnlock obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.level);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelUnlockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
