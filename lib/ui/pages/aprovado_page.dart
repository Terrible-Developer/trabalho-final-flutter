import 'package:flutter/material.dart';

class AprovadoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: Text('Este aluno foi aprovado', style: TextStyle(color: Colors.white))
        )
      );
  }
}
