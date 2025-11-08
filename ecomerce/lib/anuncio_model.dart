import 'package:hive/hive.dart';

part 'anuncio_model.g.dart';

@HiveType(typeId: 0)
class Anuncio extends HiveObject {
  @HiveField(0)
  String titulo;

  @HiveField(1)
  String descricao;

  @HiveField(2)
  double preco;

  @HiveField(3)
  String? imagemPath;

  Anuncio({
    required this.titulo,
    required this.descricao,
    required this.preco,
    this.imagemPath,
  });
}
