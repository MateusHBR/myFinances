import 'package:despesas_app/components/text_field_home.dart';
import 'package:flutter/material.dart';

class ModalDateHome extends StatefulWidget {
  final Function function;

  ModalDateHome({
    // this.monthController,
    // this.yearController,
    // this.salaryController,
    this.function,
  });

  @override
  _ModalDateHomeState createState() => _ModalDateHomeState();
}

class _ModalDateHomeState extends State<ModalDateHome> {
  var monthController = TextEditingController();

  var yearController = TextEditingController();

  var salaryController = TextEditingController();

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
          vertical: size.width * 0.02,
        ),
        child: Column(
          children: <Widget>[
            Text(
              "Adicionar data",
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
                controller: monthController,
                id: 1,
                labelText: "Informe o mês",
                hintText: "Exempo: Janeiro.",
                icon: Icons.date_range,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: size.height * 0.02,
                horizontal: size.width * 0.04,
              ),
              child: TextFieldHome(
                controller: yearController,
                labelText: "Informe o ano",
                hintText: "Exempo: 2020.",
                id: 2,
                keyboardType: TextInputType.number,
                icon: Icons.date_range,
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
                prefixText: "R\$",
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
                  String month = monthController.text;
                  String year = yearController.text;
                  String salary = salaryController.text;
                  print("$month, $year, $salary");
                  widget.function(
                    monthController.text,
                    yearController.text,
                    salaryController.text,
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  "Adicionar",
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