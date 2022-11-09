import 'dart:async';

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

//es un contador para esperar el llamdo
class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _HomePageState extends State<HomePage> {
  //variable que realiza el llamdo
  final _debouncer = Debouncer();
  //se usan dos list para realizar la busqueda,
  //lista para ordenar
  static const menuItems = <String>[
    'Nota',
    'Fecha',
  ];

  //optener
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btnSelect = 'Nota';

  //get lista de notas
  List<Notas> notas = [];
  List<Notas> notasBuscar = [];

  @override
  void initState() {
    cargaNotas(_btnSelect);
    super.initState();
  }

  cargaNotas(String orderBy) async {
    //funcion para ordenar todo
    if (orderBy == 'Nota') {
      List<Notas> auxNotas = await SqliteService.notas('nombreNota');
      setState(() {
        notas = auxNotas;
        notasBuscar = notas;
      });
    } else {
      List<Notas> auxNotas = await SqliteService.notas(orderBy);
      setState(() {
        notas = auxNotas;
        notasBuscar = notas;
      });
    }
  }

  //llave para controlar el scafoldstate
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
            //texfil para buscar nota
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
                onChanged: ((value) {
                  _debouncer.run(() {
                    setState(() {
                      notas = notasBuscar
                          .where((element) => (element.nombreNota
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                          .toList();
                    });
                  });
                }),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            //selecc ordenar por
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'Ordernar por: ',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                    value: _btnSelect,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _btnSelect = newValue;
                          cargaNotas(newValue.toString());
                        });
                      }
                    },
                    items: _dropDownMenuItems,
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  const Icon(Icons.list),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.6,
              width: width * 0.9,
              child: ListView.builder(
                itemCount: notas.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    //leading: Text(notas[index].id.toString()),
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
