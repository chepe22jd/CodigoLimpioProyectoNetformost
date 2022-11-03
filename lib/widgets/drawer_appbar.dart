import 'package:flutter/material.dart';
import 'package:codigolimpionetforemost/screen/newnote_page.dart';

Drawer drawerAppBarMenu(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.green,
          ),
          child: Text('NotePad Personal'),
        ),
        listTitleNota(Icons.add, 'Nueva nota', 'newnote', context),
        listTitle(Icons.menu, 'Lista de Notas', 'homepage', context),
        listTitle(Icons.person, 'Creado por', 'creadopor', context)
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
