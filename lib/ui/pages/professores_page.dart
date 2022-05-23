import 'package:controlealunos/datasources/local/professor_helper.dart';
import 'package:controlealunos/models/professor.dart';
import 'package:controlealunos/models/disciplina.dart';
import 'package:controlealunos/ui/pages/cad_professor_page.dart';
import 'package:controlealunos/ui/pages/alunos_page.dart';
import 'package:flutter/material.dart';

class ProfessoresPage extends StatefulWidget {
  final Disciplina disciplina;

  const ProfessoresPage(this.disciplina, {Key? key}) : super(key: key);

  @override
  State<ProfessoresPage> createState() => _ProfessoresPageState();
}

class _ProfessoresPageState extends State<ProfessoresPage> {
  final _professorHelper = ProfessorHelper();

  @override
  Widget build(BuildContext context) {
    //print('CONTEXT: ${context}\n\n\n\n');
    return Scaffold(
      appBar: AppBar(title: Text(widget.disciplina.nome)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _cadastrarProfessor,
      ),
      body: FutureBuilder(
        future: _professorHelper.getByDisciplina(widget.disciplina.codigo ?? 0),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _criarLista(snapshot.data as List<Professor>);
          }
        },
      ),
    );
  }

  Widget _criarLista(List<Professor> listaDados) {
    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: listaDados.length,
      itemBuilder: (context, index) {
        return _criarItemLista(listaDados[index]);
      }
    );
  }

  Widget _criarItemLista(Professor professor) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(professor.nome, style: const TextStyle(fontSize: 28),),
        ),
      ),
      onTap: () => _abrirListaAlunos(professor),
      onLongPress: () => _cadastrarProfessor(professor: professor),
    );
  }

  void _abrirListaAlunos(Professor professor) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => AlunosPage(professor)
    ));
  }

  void _cadastrarProfessor({Professor? professor}) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) => CadProfessorPage(widget.disciplina, professor: professor,)
    ));

    setState(() { });
  }
}
