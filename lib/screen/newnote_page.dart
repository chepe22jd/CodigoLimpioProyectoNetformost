import 'package:flutter/material.dart';

import 'package:codigolimpionetforemost/widgets/appbar.dart';
import 'package:codigolimpionetforemost/widgets/drawer_appbar.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({super.key});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  //fecha controller
  final dateController = TextEditingController();
  //nombre nota controller
  final TextEditingController _controllerNombreNota = TextEditingController();
  //nota controller
  final TextEditingController _controllerNota = TextEditingController();

  //formato inicial
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //variables para optener los size screen
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //formato de fecha
    dateController.text = selectedDate.toString().substring(0, 10);

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
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Ingrese el nombre de la nota';
                  }
                  if (text.length < 2) {
                    return 'Favor mayor a 2 caracteres';
                  }
                  return null;
                },
                controller: _controllerNombreNota,
                keyboardType: TextInputType.text,
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
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Seleccione una fecha';
                  }

                  return null;
                },
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
                maxLines: 15,

                keyboardType: TextInputType.multiline,
                controller: _controllerNota,
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
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
