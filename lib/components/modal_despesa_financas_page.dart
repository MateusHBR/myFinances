import 'package:despesas_app/components/text_field_home.dart';
import 'package:flutter/material.dart';
import 'package:despesas_app/models/gasto.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class ModalDespesaFinancasPage extends StatefulWidget {
  final Function function;
  final int id;

  ModalDespesaFinancasPage({
    this.function,
    this.id,
  });

  @override
  _ModalDespesaFinancasPageState createState() =>
      _ModalDespesaFinancasPageState();
}

class _ModalDespesaFinancasPageState extends State<ModalDespesaFinancasPage> {
  var titleController = TextEditingController();
  var valueController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
  );

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
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.01,
          vertical: size.height * 0.02,
        ),
        child: Column(
          children: <Widget>[
            Text(
              "Inserir despesa",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: size.height * 0.02,
                horizontal: size.width * 0.04,
              ),
              child: TextFieldHome(
                controller: titleController,
                id: 1,
                labelText: "Informe o título da despesa",
                hintText: "Exempo: Mercado.",
                icon: Icons.format_align_justify,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: size.height * 0.02,
                horizontal: size.width * 0.04,
              ),
              child: TextFieldHome(
                controller: valueController,
                prefixText: "R\$",
                labelText: "Informe o valor da despesa",
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Adicionar despesa",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      valueController.text.isNotEmpty) {
                    widget.function(
                      Gasto(
                        title: titleController.text,
                        value: filter(valueController.text),
                        idDate: widget.id,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
