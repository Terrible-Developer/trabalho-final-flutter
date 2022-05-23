import 'package:controlealunos/datasources/local/editora_helper.dart';
import 'package:controlealunos/models/editora.dart';
import 'package:controlealunos/ui/components/campo_texto.dart';
import 'package:controlealunos/ui/components/mensagem_alerta.dart';
import 'package:flutter/material.dart';

class CadEditoraPage extends StatefulWidget {
  final Editora? editora;

  const CadEditoraPage({this.editora, Key? key}) : super(key: key);

  @override
  State<CadEditoraPage> createState() => _CadEditoraPageState();
}

class _CadEditoraPageState extends State<CadEditoraPage> {
  final _editoraHelper = EditoraHelper();
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.editora != null) {
      _nomeController.text = widget.editora!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro Editora'),),
      body: ListView(
        children: [
          CampoTexto(
            controller: _nomeController,
            texto: 'Nome da editora'
          ),
          ElevatedButton(
            onPressed: _salvarEditora,
            child: const Text('Salvar')
          ),

          Visibility(
            child: ElevatedButton(
                child: const Text('Excluir'),
                onPressed: _excluirEditora
            ),
            visible: widget.editora != null,
          ),
        ],
      ),
    );
  }

  void _excluirEditora() {
    MensagemAlerta.show(
      context: context,
      titulo: 'Atenção',
      texto: 'Deseja excluir essa editora?',
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
    if (widget.editora != null) {
      _editoraHelper.apagar(widget.editora!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _salvarEditora() {
    if (_nomeController.text.isEmpty) {
      MensagemAlerta.show(
        context: context,
        titulo: 'Atenção',
        texto: 'Nome da editora é obrigatório!',
        botoes: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () { Navigator.pop(context); }
          ),
        ]
      );
      return;
    }
    if (widget.editora != null) {
      widget.editora!.nome = _nomeController.text;
      _editoraHelper.alterar(widget.editora!);
    }
    else {
      _editoraHelper.inserir(Editora(nome: _nomeController.text));
    }
    Navigator.pop(context);
  }
}
