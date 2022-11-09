import 'package:flutter/material.dart';

//Widget para los list title con la funcion de route
Widget listTitle(
    IconData icon, String text, String route, BuildContext context) {
  return ListTile(
    leading: Icon(icon),
    title: Text(text),
    onTap: () {
      //Va a la ruta de home y de createby.
      Navigator.pushNamed(context, '/$route');
    },
  );
}
