import 'package:despesas_app/helper/financas_db.dart';
import 'package:despesas_app/models/date.dart';
import 'package:despesas_app/models/gasto.dart';
import 'package:flutter/material.dart';
import '../components/modal_despesa_financas_page.dart';

class MesFinancasPage extends StatefulWidget {
  final Date date;

  MesFinancasPage({
    @required this.date,
  });

  @override
  _MesFinancasPageState createState() => _MesFinancasPageState();
}

class _MesFinancasPageState extends State<MesFinancasPage> {
  List<Gasto> _gasto = List<Gasto>();
  var _db = FinancasHelper();

  void initState() {
    // _listDate();
  }

  _listGasto() {}

  void saveGasto(Gasto gasto) async {
    if (gasto.title.isEmpty || gasto.value.isEmpty || gasto.idDate == null) {
      return;
    }
    await _db.insertGasto(gasto);

    _listGasto();
  }

  _addGasto(context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ModalDespesaFinancasPage(
          function: saveGasto,
          id: widget.date.id,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.date.month,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.money_off,
        ),
        onPressed: () {
          _addGasto(context);
        },
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
                  "Meu Salário:  R\$${double.parse(widget.date.salary).toStringAsFixed(2)}",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            " • Mercado: R\$ 10,00",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            " • Loja: R\$ 10,00",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            " • Mercado: R\$ 10,00",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Divider(),
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
