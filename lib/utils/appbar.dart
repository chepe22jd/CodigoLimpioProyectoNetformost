import 'package:flutter/material.dart';

//Appbar para aplicacion es llamada para todas las pantallas,
//tambien manda a llamar el drawer.
AppBar appBarCode(BuildContext context, GlobalKey<ScaffoldState> key) => AppBar(
      title: Row(
        children: const [
          SizedBox(
            width: 10,
          ),
          Text('CleanCode NotePad'),
          SizedBox(
            width: 5,
          ),
          Icon(Icons.fact_check),
        ],
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.list),
        onPressed: () {
          //Abre drawer
          key.currentState!.openDrawer();
        },
      ),
      backgroundColor: Colors.greenAccent[400],
    );
