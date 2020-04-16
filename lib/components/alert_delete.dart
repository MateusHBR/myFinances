import 'package:flutter/material.dart';

class AlertDelete extends StatelessWidget {
  final Function functionDelete;
  final int id;
  final bool multiplos;

  AlertDelete({
    @required this.functionDelete,
    @required this.id,
    this.multiplos = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Excluir"),
      content: Text(
        multiplos
            ? "Você deseja excluir todos os campos?"
            : "Você deseja excluir esse campo?",
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Ok"),
          onPressed: () {
            functionDelete(id);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
