const editoraTabela = 'TbEditora';
const editoraCodigo = 'codigo';
const editoraNome = 'nome';

class Editora {
  int? codigo;
  String nome;

  Editora({this.codigo, required this.nome});

  factory Editora.fromMap(Map map) {
    return Editora(
      codigo: int.tryParse(map[editoraCodigo].toString()),
      nome: map[editoraNome]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      editoraCodigo: codigo,
      editoraNome: nome
    };
  }
}