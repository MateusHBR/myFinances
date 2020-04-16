import 'package:despesas_app/components/text_field_home.dart';
import 'package:despesas_app/models/date.dart';
import 'package:flutter/material.dart';

import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:intl/intl.dart';

class ModalDateHome extends StatefulWidget {
  final Date date;
  final Function functionInsert;
  final bool refresh;

  ModalDateHome({
    this.date,
    this.refresh = false,
    this.functionInsert,
  });

  @override
  _ModalDateHomeState createState() => _ModalDateHomeState();
}

class _ModalDateHomeState extends State<ModalDateHome> {
  var monthController = TextEditingController();
  var yearController = TextEditingController();
  var salaryController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
  );
  DateTime dataInfo;

  monthFormat(dataInfo) {
    initializeDateFormatting("pt_BR", null);
    String dataFormatada = DateFormat('MMMM', 'pt_BR').format(dataInfo);

    return toBeginningOfSentenceCase(dataFormatada);
  }

  yearFormat(dataInfo) {
    initializeDateFormatting("pt_BR", null);
    String dataFormatada = DateFormat('yyyy', 'pt_BR').format(dataInfo);

    return dataFormatada;
  }

  filter(String s) {
    return s.replaceAll('.', '').replaceAll(',', '.');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.01,
          vertical: size.height * 0.02,
        ),
        child: Column(
          children: <Widget>[
            Text(
              widget.refresh ? "Atualizar data" : "Adicionar data",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    dataInfo == null
                        ? "Nenhuma data selecionada!"
                        : "${monthFormat(dataInfo)} de ${yearFormat(dataInfo)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: dataInfo == null
                          ? Colors.black
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: dataInfo == null
                          ? Colors.black
                          : Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      showMonthPicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime(DateTime.now().year + 1),
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            dataInfo = date;
                          });
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: size.width * 0.04,
                right: size.width * 0.04,
                bottom: size.width * 0.04,
              ),
              child: TextFieldHome(
                controller: salaryController,
                labelText: "Informe o seu salário desse mês.",
                hintText: "",
                id: 1,
                keyboardType: TextInputType.number,
                icon: Icons.attach_money,
              ),
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.06,
              margin: EdgeInsets.symmetric(
                vertical: size.height * 0.01,
                horizontal: size.width * 0.04,
              ),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  // String month = monthFormat(dataInfo);
                  // String year = yearFormat(dataInfo);
                  // String filtrado = filter(salaryController.text);
                  if (dataInfo == null || salaryController.text.isEmpty) {
                    return;
                  } else {
                    if (widget.refresh) {
                      widget.functionInsert(
                        Date(
                          id: widget.date.id,
                          month: monthFormat(dataInfo),
                          year: yearFormat(dataInfo),
                          salary: filter(salaryController.text),
                        ),
                      );
                    } else {
                      widget.functionInsert(
                        Date(
                          month: monthFormat(dataInfo),
                          year: yearFormat(dataInfo),
                          salary: filter(salaryController.text),
                        ),
                      );
                    }
                    Navigator.of(context).pop();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  widget.refresh ? "Atualizar" : "Adicionar",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
