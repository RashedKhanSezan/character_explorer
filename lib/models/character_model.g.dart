// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterModelAdapter extends TypeAdapter<CharacterModel> {
  @override
  final int typeId = 0;

  @override
  CharacterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterModel(
      id: fields[0] as int,
      name: fields[1] as String,
      gender: fields[2] as Gender,
      species: fields[3] as String,
      status: fields[4] as Status,
      type: fields[5] as String,
      imagePath: fields[6] as String,
      origin: (fields[7] as Map).cast<String, dynamic>(),
      location: (fields[8] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, CharacterModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.species)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.imagePath)
      ..writeByte(7)
      ..write(obj.origin)
      ..writeByte(8)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatusAdapter extends TypeAdapter<Status> {
  @override
  final int typeId = 1;

  @override
  Status read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Status.alive;
      case 1:
        return Status.dead;
      case 2:
        return Status.unknown;
      default:
        return Status.alive;
    }
  }

  @override
  void write(BinaryWriter writer, Status obj) {
    switch (obj) {
      case Status.alive:
        writer.writeByte(0);
        break;
      case Status.dead:
        writer.writeByte(1);
        break;
      case Status.unknown:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GenderAdapter extends TypeAdapter<Gender> {
  @override
  final int typeId = 2;

  @override
  Gender read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Gender.male;
      case 1:
        return Gender.female;
      case 2:
        return Gender.genderless;
      case 3:
        return Gender.unknown;
      default:
        return Gender.male;
    }
  }

  @override
  void write(BinaryWriter writer, Gender obj) {
    switch (obj) {
      case Gender.male:
        writer.writeByte(0);
        break;
      case Gender.female:
        writer.writeByte(1);
        break;
      case Gender.genderless:
        writer.writeByte(2);
        break;
      case Gender.unknown:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
