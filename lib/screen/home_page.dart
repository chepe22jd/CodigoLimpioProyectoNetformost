import 'package:flutter/material.dart';

import 'package:codigolimpionetforemost/models/note.dart';
import 'package:codigolimpionetforemost/screen/newnote_page.dart';
import 'package:codigolimpionetforemost/services/db.dart';

import 'package:codigolimpionetforemost/widgets/appbar.dart';
import 'package:codigolimpionetforemost/widgets/drawer_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get lista de notas
  List<Notas> notas = [];

  @override
  void initState() {
    cargaAnimales();
    super.initState();
  }

  cargaAnimales() async {
    List<Notas> auxAnimal = await SqliteService.notas();

    setState(() {
      notas = auxAnimal;
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  //nombre nota controller
  final TextEditingController _controllerBuscar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //variables para optener los size screen
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                //validador para que user escriba nota
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
            SizedBox(
              height: height * 0.7,
              width: width * 0.9,
              child: ListView.builder(
                itemCount: notas.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: Text("$index"),
                    subtitle: Text(notas[index].fecha),
                    trailing: MaterialButton(
                      color: Colors.green,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewNotePage(
                                id: notas[index].id,
                                nombreNota: notas[index].nombreNota,
                                fecha: notas[index].fecha,
                                nota: notas[index].nota),
                          ),
                        );
                      },
                      child: const Icon(Icons.edit),
                    ),
                    title: Text(notas[index].nombreNota),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
