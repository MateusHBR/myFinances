import 'package:despesas_app/components/icon_aux_home.dart';
import 'package:flutter/material.dart';

class ItemMesHome extends StatelessWidget {
  final String title;
  final String year;

  ItemMesHome({
    @required this.title,
    @required this.year,
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
                    "$year/",
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
                    title,
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
                        function: () {},
                      ),
                      IconAuxHome(
                        icon: Icons.remove_circle,
                        color: Colors.red,
                        function: () {},
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
}
