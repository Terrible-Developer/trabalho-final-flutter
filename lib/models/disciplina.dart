import 'package:controlealunos/models/turma.dart';

class Disciplina {
  static const tabela = 'TbDisciplina';
  static const codigo_disciplina = 'codigo';
  static const nome_disciplina = 'nome';
  static const turma_disciplina = 'turma';

  int? codigo;
  String nome;
  Turma turma;

  Disciplina({
    this.codigo,
    required this.nome,
    required this.turma
  });

  factory Disciplina.fromMap(Map map, Turma turma) {
    return Disciplina(
      codigo: int.tryParse(map[codigo_disciplina].toString()),
      nome: map[nome_disciplina],
      turma: turma
    );
  }

  Map<String, dynamic> toMap() {
    return {
      codigo_disciplina: codigo,
      nome_disciplina: nome,
      turma_disciplina: turma.codigo
    };
  }
}
