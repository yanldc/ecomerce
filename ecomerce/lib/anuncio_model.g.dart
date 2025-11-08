// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anuncio_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnuncioAdapter extends TypeAdapter<Anuncio> {
  @override
  final int typeId = 0;

  @override
  Anuncio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Anuncio(
      titulo: fields[0] as String,
      descricao: fields[1] as String,
      preco: fields[2] as double,
      imagemPath: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Anuncio obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.titulo)
      ..writeByte(1)
      ..write(obj.descricao)
      ..writeByte(2)
      ..write(obj.preco)
      ..writeByte(3)
      ..write(obj.imagemPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnuncioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
