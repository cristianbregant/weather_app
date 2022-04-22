// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherHistoryAdapter extends TypeAdapter<WeatherHistory> {
  @override
  final int typeId = 0;

  @override
  WeatherHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherHistory(
      forecast: fields[0] as WeatherForecast,
      date: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherHistory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.forecast)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
