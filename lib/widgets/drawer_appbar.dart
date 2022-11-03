import 'package:codigolimpionetforemost/models/note.dart';
import 'package:codigolimpionetforemost/screen/newnote_page.dart';
import 'package:flutter/material.dart';

Drawer drawerAppBarMenu(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        listTitleNota(Icons.add, 'Nueva nota', 'newnote', context),
        listTitle(Icons.menu, 'Lista de Notas', 'homepage', context),
        listTitle(Icons.person, 'Creado por', 'homepage', context)
      ],
    ),
  );
}

Widget listTitleNota(
    IconData icon, String text, String route, BuildContext context) {
  return ListTile(
    leading: Icon(icon),
    title: Text(text),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const NewNotePage(id: -1, nombreNota: "", fecha: "", nota: ""),
        ),
      );
    },
  );

  //Notas(id: -1, nombreNota: "", fecha: "", nota: "")
}

Widget listTitle(
    IconData icon, String text, String route, BuildContext context) {
  return ListTile(
    leading: Icon(icon),
    title: Text(text),
    onTap: () {
      Navigator.pushNamed(context, '/$route');
    },
  );
}
