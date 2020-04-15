import 'package:despesas_app/components/icon_aux_home.dart';
import 'package:despesas_app/models/date.dart';
import 'package:flutter/material.dart';

class ItemMesHome extends StatelessWidget {
  final Function(int) functionDelete;
  final Function functionUpdate;
  final Date date;
  ItemMesHome({
    @required this.date,
    @required this.functionDelete,
    @required this.functionUpdate,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Container(
        width: size.width,
        height: size.height * 0.10,
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
            child: Row(
              children: <Widget>[
                Icon(Icons.date_range),
                Container(
                  // width: size.width * 0.3,
                  child: Text(
                    "${date.year}/",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.4485,
                  child: Text(
                    date.month,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      IconAuxHome(
                        icon: Icons.edit,
                        color: Colors.green,
                        function: () {
                          functionUpdate(date);
                        },
                      ),
                      IconAuxHome(
                        icon: Icons.remove_circle,
                        color: Colors.red,
                        function: () {
                          _onDelete(context, date.id);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onDelete(context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Excluir"),
          content: Text(
            "Você deseja excluir esse campo?",
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
              onPressed: () {
                functionDelete(id);
                Navigator.of(context).pop();
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
