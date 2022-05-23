import 'package:controlealunos/models/professor.dart';

class Aluno {
  static const tabela = 'TbAluno';
  static const alunoRa = 'ra';
  static const alunoNome = 'nome';
  static const notaAluno = 'nota';
  static const frequenciaAluno = 'frequencia';
  static const alunoProfessor = 'professor';

  int? ra;
  String nome;
  int nota;
  int frequencia;
  Professor professor;

  Aluno({
      this.ra,
      required this.nome,
      required this.nota,
      required this.frequencia,
      required this.professor
  });

  factory Aluno.fromMap(Map map, Professor professor) {
    return Aluno(
      ra: int.tryParse(map[alunoRa].toString()),
      nome: map[alunoNome],
      nota: map[notaAluno],
      frequencia: map[frequenciaAluno],
      professor: professor
    );
  }

  Map<String, dynamic> toMap() {
    return {
      alunoRa: ra,
      alunoNome: nome,
      notaAluno: nota,
      frequenciaAluno: frequencia,
      alunoProfessor: professor.ra
    };
  }
}
