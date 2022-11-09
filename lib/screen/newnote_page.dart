import 'package:flutter/material.dart';

import 'package:codigolimpionetforemost/models/note.dart';
import 'package:codigolimpionetforemost/services/db.dart';

import 'package:codigolimpionetforemost/widgets/appbar.dart';
import 'package:codigolimpionetforemost/widgets/drawer_appbar.dart';

class NewNotePage extends StatefulWidget {
  //Obtener datos para paguina de edicion.
  const NewNotePage(
      {super.key,
      this.id,
      required this.nombreNota,
      required this.fecha,
      required this.nota});

  final int? id;
  final String nombreNota;
  final String fecha;
  final String nota;

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

//paguina para añadir nuevas notas
class _NewNotePageState extends State<NewNotePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  //fecha controller
  final dateController = TextEditingController();
  //nombre nota controller
  final controllerNombreNota = TextEditingController();
  //nota controller
  final controllerNota = TextEditingController();

  //formato inicial

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

//inicio estado para los text
  @override
  void initState() {
    controllerNombreNota.text = widget.nombreNota;
    controllerNota.text = widget.nota;
    dateController.text = widget.fecha;
    super.initState();
  }

  //selecionar fecha
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = selectedDate.toString().substring(0, 10);
      });
    }
  }

  //validator forem key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //variables para optener los size screen
//    double width = MediaQuery.of(context).size.width;
// ancho no se usa
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _key,
      //drawer barr y app bar desde carpeta de widgets
      drawer: drawerAppBarMenu(context),
      appBar: appBarCode(context, _key),
      //body principal
      body: SingleChildScrollView(
        child: Form(
          //llave para vlidador del Form
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  //validador para que user escriba nota
                  controller: controllerNombreNota,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Ingrese el nombre de la nota';
                    }
                    if (text.length < 2) {
                      return 'Favor mayor a 2 caracteres';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Nombre de Nota',
                      hintText: 'Nombre de Nota'),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  //oculta teclado
                  showCursor: true,
                  readOnly: true,
                  //validador de fechas
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Seleccione una fecha';
                    }
                    return null;
                  },
                  //seleciona el widget de fecha
                  onTap: () async {
                    _selectDate(context);
                  },
                  controller: dateController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Selecione fecha',
                      hintText: 'Selecione fecha'),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  //validador para que user escriba nota
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Ingrese su nota porfavor';
                    }
                    if (text.length < 2) {
                      return 'Favor mayor a 2 caracteres';
                    }
                    return null;
                  },
                  //aumentar el tamaño del text
                  maxLines: 15,
                  keyboardType: TextInputType.multiline,
                  controller: controllerNota,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Su Nota',
                      hintText: 'Su Nota'),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              //boton guarda nota
              ElevatedButton(
                onPressed: () async {
                  //validar datos no basios
                  if (_formKey.currentState!.validate()) {
                    if (widget.id! > -1) {
                      ///actializa datos
                      SqliteService.update(
                        Notas(
                            id: widget.id,
                            nombreNota: controllerNombreNota.text,
                            fecha: selectedDate.toString().substring(0, 10),
                            nota: controllerNota.text),
                      );
                      //nota para validar actualizacion
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Nota actualizada"),
                        ),
                      );
                      //limpia textos
                      cleanTextfield();
                      //Ir a paguina principal
                      Navigator.pushNamed(context, '/homepage');
                    }
                    //guarda un nuevo dato
                    else {
                      SqliteService.insert(
                        Notas(
                            nombreNota: controllerNombreNota.text,
                            fecha: selectedDate.toString().substring(0, 10),
                            nota: controllerNota.text),
                      );
                      //nota para validar nueva nota
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Nota agreada"),
                        ),
                      );
                      //limpia textos
                      cleanTextfield();
                      //Ir a paguina principal
                      Navigator.pushNamed(context, '/homepage');
                    }
                  } else {
                    //retornar nada para que valide
                    return;
                  }
                },
                //estilo de botton
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[400],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child: const Text(
                  'Guardar nota',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void cleanTextfield() {
    controllerNombreNota.clear();
    controllerNota.clear();
    dateController.clear();
  }
}
