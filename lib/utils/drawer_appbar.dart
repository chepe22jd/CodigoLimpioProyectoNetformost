import 'package:flutter/material.dart';

import '../widgets/list_title.dart';
import '../widgets/list_title_note.dart';

//Drawer para la apliacion
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
        //Manda a llamar los widgets para los titles del drawer,
        listTitleNote(Icons.add, 'Nueva nota', 'newnote', context),
        listTitle(Icons.menu, 'Lista de Notas', 'homepage', context),
        listTitle(Icons.person, 'Creado por', 'createby', context),
        //Button para regresar pantalla.
        ListTile(
          leading: const Icon(Icons.arrow_back),
          title: const Text("Regresar"),
          onTap: () {
            //Va a la ruta de home y de createby.
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
