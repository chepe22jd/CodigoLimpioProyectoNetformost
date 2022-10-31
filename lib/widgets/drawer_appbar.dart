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
        listTitle(Icons.menu, 'Lista de Notas', 'homepage', context)
      ],
    ),
  );
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
