import 'package:controlealunos/datasources/local/banco_dados.dart';
import 'package:controlealunos/models/disciplina.dart';
import 'package:controlealunos/models/professor.dart';
import 'package:controlealunos/datasources/local/disciplina_helper.dart';
import 'package:sqflite/sqflite.dart';


const sqlCreateProfessor = '''
  CREATE TABLE TbProfessor (
    ${Professor.professor_ra} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Professor.professor_nome} TEXT,
    ${Professor.professor_disciplina} INTEGER,
    FOREIGN KEY(${Professor.professor_disciplina}) REFERENCES ${Disciplina.tabela}(codigo)
  )
''';

class ProfessorHelper {
  Future<Professor> inserir(Professor professor) async {
    Database db = await BancoDados().db;
    professor.ra = await db.insert(Professor.tabela, professor.toMap());
    return professor;
  }

  Future<int> alterar(Professor professor) async {
    Database db = await BancoDados().db;

    return db.update(
      Professor.tabela,
      professor.toMap(),
      where: '${Professor.professor_ra} = ?',
      whereArgs: [professor.ra]
    );
  }

  Future<int> apagar(Professor professor) async {
    Database db = await BancoDados().db;

    return await db.delete(Professor.tabela,
      where: '${Professor.professor_ra} = ?',
      whereArgs: [professor.ra]
    );
  }

  Future<List<Professor>> getByDisciplina(int codDisciplina) async {
    Disciplina? disciplina = await DisciplinaHelper().getDisciplina(codDisciplina);

    if (disciplina != null) {
      Database db = await BancoDados().db;
      List dados = await db.query(
        Professor.tabela,
        where: '${Professor.professor_disciplina} = ?',
        whereArgs: [codDisciplina],
        orderBy: Professor.professor_nome
      );


      return dados.map((e) => Professor.fromMap(e, disciplina)).toList();
    }

    return [];
  }

  Future<Professor?> getProfessor(int codProfessor) async {
    Database db = await BancoDados().db;

    List dados = await db.query(
      Professor.tabela,
      where: '${Professor.professor_ra} = ?',
      whereArgs: [codProfessor]
    );

    if (dados.isNotEmpty) {
      int codDisciplina = int.parse(dados.first[Professor.professor_disciplina].toString());
      Disciplina disciplina = (await DisciplinaHelper().getDisciplina(codDisciplina))!;
      return Professor.fromMap(dados.first, disciplina);
    }
    return null;
  }
}
