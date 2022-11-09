import 'package:flutter/material.dart';
import 'dart:async';

import 'package:codigolimpionetforemost/services/db.dart';
import 'package:codigolimpionetforemost/models/note.dart';
import 'package:codigolimpionetforemost/screen/newnote_page.dart';

import 'package:codigolimpionetforemost/utils/appbar.dart';
import 'package:codigolimpionetforemost/utils/drawer_appbar.dart';

//Paguina principal
//
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

//Es un contador para esperar el llamado por la funcion de buscar
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
  //Variable que realiza el llamado del contador
  final _debouncer = Debouncer();
  //Se usan 2 List para realizar la busqueda,
  //Lista para ordenar
  static const menuItems = <String>[
    'Nota',
    'Fecha',
  ];

  //Obtener los datos para el DropDowmMenu
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btnSelect = 'Nota';

  //Obtener lista de notas.
  List<Notes> notas = [];
  List<Notes> notasBuscar = [];

//Manda a llamar en el initState la funcion cargaNotas para ver las notas como lista desde
//el inicio
  @override
  void initState() {
    cargaNotas(_btnSelect);
    super.initState();
  }

//Funcion para cargar notas
  cargaNotas(String orderBy) async {
    //Funcion if para validar el tipo de DrownDowm selecionado.
    if (orderBy == 'Nota') {
      List<Notes> auxNotas = await SqliteService.notas('nameNote');
      setState(
        () {
          notas = auxNotas;
          notasBuscar = notas;
        },
      );
    } else if (orderBy == 'Fecha') {
      List<Notes> auxNotas = await SqliteService.notas('date');
      setState(
        () {
          notas = auxNotas;
          notasBuscar = notas;
        },
      );
    }
  }

  //Llave para controlar el ScafoldState.
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  //Controller para el TextFormField.
  final TextEditingController _controllerBuscar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Variables para obtener los Size Screen.
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      //LLave del Scaffold.
      key: _key,
      drawer: drawerAppBarMenu(context), //Drawer desde la caperta de utils.
      appBar: appBarCode(context, _key), //Appbar desde la caperta de utils.
      //Body principal.
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            const Text(
              'Lista de notas',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            //TextFormField para buscar nota.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                //Validador para que usuario escriba nota.
                controller: _controllerBuscar,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Buscar Nota',
                    hintText: 'Buscar Nota'),
                onChanged: ((value) {
                  //Si escriben algo mandar a llamar el contador, y la funcion de buscar por
                  //texto escrito.
                  _debouncer.run(() {
                    setState(() {
                      notas = notasBuscar
                          .where((element) => (element.nameNote
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                          .toList();
                    });
                  });
                }),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            //Seleccion para ordenar por.
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
                  //Valores a selecionar.
                  DropdownButton(
                    value: _btnSelect,
                    onChanged: (String? newValue) {
                      //Manda a llamar la funcion buscar notas para el listview,
                      //actualiza el estado de la pantalla.
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
            //
            SizedBox(
              height: height * 0.6,
              width: width * 0.9,
              //Lista de notas escritas.
              child: ListView.builder(
                itemCount: notas.length,
                itemBuilder: ((context, index) {
                  //Datos a mostar
                  return ListTile(
                    subtitle: Text(notas[index].date),
                    //Botton lado izquierdo para editar nota selecionada o mostrar
                    //datos de la nota.
                    trailing: MaterialButton(
                      color: Colors.green,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewNotePage(
                                id: notas[index].id,
                                nameNote: notas[index].nameNote,
                                date: notas[index].date,
                                note: notas[index].nameNote),
                          ),
                        );
                      },
                      child: const Icon(Icons.edit),
                    ),
                    title: Text(notas[index].nameNote),
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
