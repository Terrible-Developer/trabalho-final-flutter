import 'package:controlealunos/models/editora.dart';

class Livro {
  static const tabela = 'TbLivro';
  static const codigo_coluna = 'codigo';
  static const nome_coluna = 'nome';
  static const editora_coluna = 'cod_editora';

  int? codigo;
  String nome;
  Editora editora;

  Livro({
    this.codigo,
    required this.nome,
    required this.editora
  });

  factory Livro.fromMap(Map map, Editora editora) {
    return Livro(
      codigo: int.tryParse(map[codigo_coluna].toString()),
      nome: map[nome_coluna],
      editora: editora
    );
  }

  Map<String, dynamic> toMap() {
    return {
      codigo_coluna: codigo,
      nome_coluna: nome,
      editora_coluna: editora.codigo
    };
  }
}
