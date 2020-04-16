import 'package:despesas_app/components/alert_delete.dart';
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
    _listGasto(widget.date.id);
  }

  void _listGasto(int id) async {
    List gastosRecovered = await _db.listGastos(id);
    List<Gasto> temporary = List<Gasto>();

    for (var item in gastosRecovered) {
      Gasto gt = Gasto.fromJson(item);
      temporary.add(gt);
    }
    setState(() {
      _gasto = temporary;
    });
    temporary = null;
    print(_gasto);
  }

  saveGasto(Gasto gasto) async {
    Navigator.of(context).pop();
    if (gasto.title.isEmpty || gasto.value.isEmpty || gasto.idDate == null) {
      return;
    }
    await _db.insertGasto(gasto);

    _listGasto(widget.date.id);
  }

  _addGasto(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return ModalDespesaFinancasPage(
          function: saveGasto,
          id: widget.date.id,
        );
      },
    );
  }

  void deleteGasto(int id) async {
    await _db.deleteGasto(id);
    _listGasto(widget.date.id);
  }

  void deleteGastos(int id) async {
    await _db.deleteGastos(id);
    _listGasto(widget.date.id);
  }

  _onDelete(context, int id, {bool aux = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDelete(
          multiplos: aux,
          functionDelete: aux ? deleteGastos : deleteGasto,
          id: id,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double myMoney = double.parse(widget.date.salary);
    double value = 0.0;
    for (int i = 0; i < _gasto.length; i++) {
      value += double.parse(_gasto[i].value);
    }
    myMoney -= value;

    filter(String aux) {
      return aux.replaceAll('.', ',');
    }

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
      body: SingleChildScrollView(
        child: Container(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "  Meu Salário:  R\$${filter(widget.date.salary)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _onDelete(context, widget.date.id, aux: true);
                        },
                      ),
                    ],
                  ),
                ),
                Divider(),
                SingleChildScrollView(
                  child: Container(
                    height: size.height * 0.45,
                    width: double.infinity,
                    // padding:
                    //     EdgeInsetsDirectional.only(start: size.width * 0.04),
                    child: ListView.builder(
                      itemCount: _gasto.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: size.width * 0.75,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: size.width * 0.5,
                                        child: Text(
                                          " • ${_gasto[index].title}",
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: size.width * 0.25,
                                        child: Text(
                                          " R\$${filter(_gasto[index].value)}",
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _onDelete(
                                      context,
                                      _gasto[index].id,
                                      aux: false,
                                    );
                                  },
                                ),
                              ],
                            ),
                            Divider(),
                          ],
                        );
                      },
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
                        "Total de despesas: R\$ -${filter(value.toStringAsFixed(2).toString())}",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      myMoney >= 0
                          ? Text(
                              "Valor restante na carteira: R\$${filter(myMoney.toStringAsFixed(2).toString())}",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              "Valor restante na carteira: R\$${filter(myMoney.toStringAsFixed(2).toString())}",
                              style: TextStyle(
                                color: Colors.red,
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
      ),
    );
  }
}
