import 'package:flutter/material.dart';

import 'package:codigolimpionetforemost/widgets/appbar.dart';
import 'package:codigolimpionetforemost/widgets/drawer_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  //nombre nota controller
  final TextEditingController _controllerBuscar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //variables para optener los size screen
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //formato de fecha

    return Scaffold(
      key: _key,
      drawer: drawerAppBarMenu(context),
      appBar: appBarCode(context, _key),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                //validador para que user escriba not
                controller: _controllerBuscar,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Buscar Nota',
                    hintText: 'Buscar Nota'),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
