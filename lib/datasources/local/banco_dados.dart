import 'package:controlealunos/datasources/local/turma_helper.dart';
import 'package:controlealunos/datasources/local/disciplina_helper.dart';
import 'package:controlealunos/datasources/local/professor_helper.dart';
import 'package:controlealunos/datasources/local/aluno_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDados {
  static const String _nomeBanco = 'controle_de_alunos.db';

  static final BancoDados _instancia = BancoDados.internal();
  factory BancoDados() => _instancia;
  BancoDados.internal();

  Database? _db;

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final pathDb = join(path, _nomeBanco);

    return await openDatabase(pathDb, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(sqlCreateTurma);
        await db.execute(sqlCreateDisciplina);
        await db.execute(sqlCreateProfessor);
        await db.execute(sqlCreateAluno);
      }
    );
  }

  void close() async {
    Database meuDb = await db;
    meuDb.close();
  }
}
