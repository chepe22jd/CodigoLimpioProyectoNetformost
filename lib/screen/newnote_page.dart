import 'package:flutter/material.dart';

import 'package:codigolimpionetforemost/models/note.dart';
import 'package:codigolimpionetforemost/services/db.dart';

import 'package:codigolimpionetforemost/utils/appbar.dart';
import 'package:codigolimpionetforemost/utils/drawer_appbar.dart';

//Paguina para agregar o actualizar notas.
//
class NewNotePage extends StatefulWidget {
  //Obtener datos para paguina de edicion.
  const NewNotePage(
      {super.key,
      this.id,
      required this.nameNote,
      required this.date,
      required this.note});

  final int? id;
  final String nameNote;
  final String date;
  final String note;

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  //Llave para ScaffoldState
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  //Controller para TextForm Date.
  final dateController = TextEditingController();
  //Controller para TextForm Nombre Nota
  final controllerNombreNota = TextEditingController();
  //Controller para TextForm Nota
  final controllerNota = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

//Inicio estado para los TextFrom
  @override
  void initState() {
    controllerNombreNota.text = widget.nameNote;
    controllerNota.text = widget.note;
    dateController.text = widget.date;
    super.initState();
  }

  //Selecionar fecha
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

  //Validator de Form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Variables para obtener los Size Screen.
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      //LLave del Scaffold.
      key: _key,
      drawer: drawerAppBarMenu(context), //Drawer desde la caperta de utils.
      appBar: appBarCode(context, _key), //Appbar desde la caperta de utils.
      //Body principal.
      body: SingleChildScrollView(
        child: Form(
          //Llave para vlidador del Form.
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),

              Text(
                widget.nameNote == '' ? 'Nueva Nota' : 'Actualizar Nota',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  //Validador para que Usuario escriba nota.
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
              //
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  showCursor: true,
                  readOnly: true,
                  //Validador de fechas.
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Seleccione una fecha';
                    }
                    return null;
                  },
                  //Seleciona el widget para fecha.
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
              //
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  //Validador para que Usuario escriba nota.
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Ingrese su nota porfavor';
                    }
                    if (text.length < 2) {
                      return 'Favor mayor a 2 caracteres';
                    }
                    return null;
                  },
                  //Aumenta el tamaño del text.
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
              //Boton para guarda nota.
              ElevatedButton(
                onPressed: () async {
                  //Validar datos no vacios.
                  if (_formKey.currentState!.validate()) {
                    if (widget.id! > -1) {
                      //Actializa datos.
                      SqliteService.update(
                        Notes(
                            id: widget.id,
                            nameNote: controllerNombreNota.text,
                            date: selectedDate.toString().substring(0, 10),
                            note: controllerNota.text),
                      );
                      //Nota para validar actualización.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Nota actualizada"),
                        ),
                      );
                      //Limpia textos.
                      cleanTextfield();
                      //Ir a paguina principal.
                      Navigator.pushNamed(context, '/homepage');
                    }
                    //Guarda un nuevo dato.
                    else {
                      SqliteService.insert(
                        Notes(
                            nameNote: controllerNombreNota.text,
                            date: selectedDate.toString().substring(0, 10),
                            note: controllerNota.text),
                      );
                      //Nota para validar nueva nota.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Nota agreada"),
                        ),
                      );
                      //Limpia textos.
                      cleanTextfield();
                      //Ir a paguina principal.
                      Navigator.pushNamed(context, '/homepage');
                    }
                  } else {
                    //retornar nada para que valide
                    return;
                  }
                },
                //Estilo para el botton.
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[400],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child: Text(
                  widget.nameNote == '' ? 'Guardar Nota' : 'Actualizar Nota',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }

//Funcion para limpiar texto.
  void cleanTextfield() {
    controllerNombreNota.clear();
    controllerNota.clear();
    dateController.clear();
  }
}
