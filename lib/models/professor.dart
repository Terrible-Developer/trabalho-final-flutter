import 'package:controlealunos/models/disciplina.dart';


class Professor {
  static const tabela = 'TbProfessor';
  static const professor_ra = 'ra';
  static const professor_nome = 'nome';
  static const professor_disciplina = 'disciplina';

  int? ra;
  String nome;
  Disciplina disciplina;

  Professor({this.ra, required this.nome, required this.disciplina});

  factory Professor.fromMap(Map map, Disciplina disciplina) {
    return Professor(
      ra: int.tryParse(map[professor_ra].toString()),
      nome: map[professor_nome],
      disciplina: disciplina
    );
  }

  Map<String, dynamic> toMap() {
    return {
      professor_ra: ra,
      professor_nome: nome,
      professor_disciplina: disciplina.codigo
    };
  }
}
