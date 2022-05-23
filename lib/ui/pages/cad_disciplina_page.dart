import 'package:controlealunos/datasources/local/turma_helper.dart';
import 'package:controlealunos/datasources/local/disciplina_helper.dart';
import 'package:controlealunos/models/turma.dart';
import 'package:controlealunos/models/disciplina.dart';
import 'package:controlealunos/ui/components/campo_texto.dart';
import 'package:flutter/material.dart';

class CadDisciplinaPage extends StatefulWidget {
  final Turma turma;
  final Disciplina? disciplina;

  const CadDisciplinaPage(this.turma, {this.disciplina, Key? key}) : super(key: key);

  @override
  State<CadDisciplinaPage> createState() => _CadDisciplinaPageState();
}

class _CadDisciplinaPageState extends State<CadDisciplinaPage> {
  final _disciplinaHelper = DisciplinaHelper();
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.disciplina != null) {
      _nomeController.text = widget.disciplina!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro Disciplina - ${widget.turma.nome}')),
      body: ListView(
        children: [
          CampoTexto(
            controller: _nomeController,
            texto: 'Nome do disciplina'
          ),
          ElevatedButton(
            onPressed: _salvarDisciplina,
            child: const Text('Salvar')
          ),
          _criarBotaoExcluir(),
        ],
      ),
    );
  }

  Widget _criarBotaoExcluir() {
    if (widget.disciplina != null) {
      return ElevatedButton(
          onPressed: _excluirDisciplina,
          child: const Text('Excluir')
      );
    }
    return Container();
  }

  void _excluirDisciplina() {
    _disciplinaHelper.apagar(widget.disciplina!);
    Navigator.pop(context);
  }

  void _salvarDisciplina() {
    if (widget.disciplina != null) {
      widget.disciplina!.nome = _nomeController.text;
      _disciplinaHelper.alterar(widget.disciplina!);
    }
    else {
      _disciplinaHelper.inserir(Disciplina(
          nome: _nomeController.text,
          turma: widget.turma
      ));
    }
    Navigator.pop(context);
  }
}
