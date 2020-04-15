import 'package:despesas_app/components/item_mes_home.dart';
import 'package:despesas_app/components/modal_date_home.dart';
import 'package:despesas_app/helper/financas_db.dart';
import 'package:despesas_app/models/date.dart';
import 'package:despesas_app/pages/mes_financas_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Date> _date = List<Date>();
  var _db = FinancasHelper();

  void initState() {
    _listDate();
  }

  void _listDate() async {
    List dateRecoreved = await _db.listMonth();
    List<Date> temporary = List<Date>();

    for (var item in dateRecoreved) {
      Date dt = Date.fromJson(item);
      temporary.add(dt);
    }
    setState(() {
      _date = temporary;
    });
    temporary = null;
    print(_date);
  }

  void saveDate(Date date) async {
    if (date.month.isEmpty || date.year.isEmpty || date.salary == null) {
      return;
    }
    await _db.insertDate(date);
    _listDate();
  }

  _addMonth() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ModalDateHome(
          functionInsert: saveDate,
        );
      },
    );
  }

  _deleteDate(int id) async {
    await _db.deleteDate(id);
    _listDate();
  }

  _updateDate(Date date) async {
    await _db.updateDate(date);
    _listDate();
  }

  _updateScreen(Date date) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ModalDateHome(
          refresh: true,
          functionInsert: _updateDate,
          date: date,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas finanças"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: size.height * 0.02,
          bottom: size.height * 0.01,
          left: size.height * 0.01,
          right: size.height * 0.01,
        ),
        child: ListView.builder(
          itemCount: _date.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MesFinancasPage(
                      title: _date[index].month,
                      salary: _date[index].salary,
                    ),
                  ),
                );
              },
              child: ItemMesHome(
                date: Date(
                  id: _date[index].id,
                  month: _date[index].month,
                  year: _date[index].year,
                  salary: _date[index].salary,
                ),
                functionDelete: _deleteDate,
                functionUpdate: _updateScreen,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addMonth();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
