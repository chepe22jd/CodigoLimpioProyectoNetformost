import 'package:flutter/material.dart';

import 'package:codigolimpionetforemost/screen/home_page.dart';

import 'package:codigolimpionetforemost/widgets/backgroundcolor.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //variables para optener los size screen
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          //color de fondo
          const BackGroundColor(),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.20,
                ),
                //Nota de bienvenida
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
                //imagen demostrativa
                Image.asset(
                  'assets/lista.png',
                  width: width * 0.50,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                //boton para paguina principal
                ElevatedButton(
                  onPressed: () {
                    //uso de push para no retorno
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
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
          )
        ],
      ),
    );
  }
}
