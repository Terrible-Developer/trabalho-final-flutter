import 'package:flutter/material.dart';

class ReprovadoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Text('Este aluno foi reprovado', style: TextStyle(color: Colors.white))
        )
      );
  }
}
