const turmaTabela = "TbTurma";
const turmaCodigo = 'codigo';
const turmaNome = 'nome';

class Turma {
  int? codigo;
  String nome;

  Turma({this.codigo, required this.nome});

  factory Turma.fromMap(Map map) {
    return Turma(
      codigo: int.tryParse(map[turmaCodigo].toString()),
      nome: map[turmaNome]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      turmaCodigo: codigo,
      turmaNome: nome
    };
  }
}
