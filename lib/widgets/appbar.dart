import 'package:flutter/material.dart';

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
          key.currentState!.openDrawer();
        },
      ),
      backgroundColor: Colors.greenAccent[400],
    );
