import 'package:flutter/material.dart';
import 'package:codigolimpionetforemost/screen/newnote_page.dart';

//Widget para el list title de notas este en particular
//llama a la funcion Navigator.push MaterialPageRoute.
Widget listTitleNote(
    IconData icon, String text, String route, BuildContext context) {
  return ListTile(
    leading: Icon(icon),
    title: Text(text),
    onTap: () {
      //Va a la ruta de new note
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const NewNotePage(id: -1, nameNote: "", date: "", note: ""),
        ),
      );
    },
  );
}
