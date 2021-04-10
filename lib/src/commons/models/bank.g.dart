// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BankAdapter extends TypeAdapter<Bank> {
  @override
  final int typeId = 4;

  @override
  Bank read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bank(
      abbr: fields[0] as String,
      id: fields[1] as int,
      name: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Bank obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.abbr)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bank _$BankFromJson(Map<String, dynamic> json) {
  return Bank(
    abbr: json['abbr'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
      'abbr': instance.abbr,
      'id': instance.id,
      'name': instance.name,
    };
