import 'package:controlealunos/datasources/local/turma_helper.dart';
import 'package:controlealunos/models/turma.dart';
import 'package:controlealunos/ui/components/campo_texto.dart';
import 'package:controlealunos/ui/components/mensagem_alerta.dart';
import 'package:flutter/material.dart';

class CadTurmaPage extends StatefulWidget {
  final Turma? turma;

  const CadTurmaPage({this.turma, Key? key}) : super(key: key);

  @override
  State<CadTurmaPage> createState() => _CadTurmaPageState();
}

class _CadTurmaPageState extends State<CadTurmaPage> {
  final _turmaHelper = TurmaHelper();
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.turma != null) {
      _nomeController.text = widget.turma!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro Turma'),),
      body: ListView(
        children: [
          CampoTexto(
            controller: _nomeController,
            texto: 'Nome da turma'
          ),
          ElevatedButton(
            onPressed: _salvarTurma,
            child: const Text('Salvar')
          ),

          Visibility(
            child: ElevatedButton(
                child: const Text('Excluir'),
                onPressed: _excluirTurma
            ),
            visible: widget.turma != null,
          ),
        ],
      ),
    );
  }

  void _excluirTurma() {
    MensagemAlerta.show(
      context: context,
      titulo: 'Atenção',
      texto: 'Deseja excluir essa turma?',
      botoes: [
        TextButton(
            child: const Text('Sim'),
            onPressed: _confirmarExclusao
        ),
        ElevatedButton(
            child: const Text('Não'),
            onPressed: (){ Navigator.pop(context); }
        ),
      ]
    );
  }

  void _confirmarExclusao() {
    if (widget.turma != null) {
      _turmaHelper.apagar(widget.turma!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _salvarTurma() {
    if (_nomeController.text.isEmpty) {
      MensagemAlerta.show(
        context: context,
        titulo: 'Atenção',
        texto: 'Nome da turma é obrigatório!',
        botoes: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () { Navigator.pop(context); }
          ),
        ]
      );
      return;
    }
    if (widget.turma != null) {
      widget.turma!.nome = _nomeController.text;
      _turmaHelper.alterar(widget.turma!);
    }
    else {
      _turmaHelper.inserir(Turma(nome: _nomeController.text));
    }
    Navigator.pop(context);
  }
}
