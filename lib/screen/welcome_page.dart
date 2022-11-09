import 'package:flutter/material.dart';
import 'package:codigolimpionetforemost/screen/home_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
//Paguina inicial de Bienvenida.
  @override
  Widget build(BuildContext context) {
    //Variables para obtener los Size Screen.
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          //Color de fondo para la pantalla.
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.green, Colors.white],
              ),
            ),
          ),
          //
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.20,
                ),
                //Nota de bienvenida.
                const Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    'Bienvenido a CodigoLimpio NotePad',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Imagen demostrativa.
                Image.asset(
                  'assets/lista.png',
                  height: height * 0.40,
                  width: width * 0.50,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                //Boton para pagina principal.
                ElevatedButton(
                  onPressed: () {
                    //Uso de push para no retornar a la pantalla de welcome.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  //Detalles de estilo para button.
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: const Text(
                    'Bienvenido',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
