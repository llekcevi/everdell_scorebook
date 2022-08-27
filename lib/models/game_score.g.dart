// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_score.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameScoreAdapter extends TypeAdapter<GameScore> {
  @override
  final int typeId = 0;

  @override
  GameScore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameScore(
      (fields[0] as List).cast<dynamic>(),
      (fields[1] as List).map((dynamic e) => (e as List).cast<int>()).toList(),
      fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GameScore obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._names)
      ..writeByte(1)
      ..write(obj._scores)
      ..writeByte(2)
      ..write(obj._timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameScoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
