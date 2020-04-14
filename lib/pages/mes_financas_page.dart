import 'package:flutter/material.dart';

class MesFinancasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Janeiro",
          overflow: TextOverflow.ellipsis,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.money_off,
        ),
        onPressed: () {},
      ),
      body: Container(
        width: size.width,
        height: size.height * 0.8,
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.02,
          horizontal: size.width * 0.01,
        ),
        child: Card(
          color: Colors.yellow[100],
          elevation: 5,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                ),
                child: Text(
                  "Meu Salário:  R\$500,00",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              Divider(),
              Container(
                height: size.height * 0.45,
                width: double.infinity,
                padding: EdgeInsetsDirectional.only(start: size.width * 0.04),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(" • Mercado: R\$ 10,00"),
                      Text(" • Conveniencia: R\$ 10,00"),
                      Text(" • Mercado: R\$ 10,00"),
                    ],
                  ),
                ),
              ),
              Divider(),
              Container(
                height: size.height * 0.15,
                padding: EdgeInsets.only(top: size.height * 0.01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Total de despesas: R\$ - 30,00",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Valor restante na carteira: R\$470,00",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
