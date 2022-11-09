import 'package:flutter/material.dart';

import 'package:codigolimpionetforemost/utils/appbar.dart';
import 'package:codigolimpionetforemost/utils/drawer_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

//Paguina para la presentacion del Creado por
//
class CreateByPage extends StatelessWidget {
  const CreateByPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Variales de URL y mandar a la funcion lauchURL.
    final Uri urlMyGithub = Uri.parse('https://github.com/chepe22jd');
    final Uri urlInstagram = Uri.parse('https://www.instagram.com/chepe11jd/');
    //Llave para controlar el ScafoldState.
    final GlobalKey<ScaffoldState> key = GlobalKey();
    //Variables para optener los Size Screen.
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: key,
      drawer: drawerAppBarMenu(context), //Drawer desde la caperta de utils.
      appBar: appBarCode(context, key), //Appbar desde la caperta de utils.
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.30,
            ),
            const Text(
              'Creado por: \nJose Daniel Rojas',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            //
            const Text(
              'Ingeniero Electronico',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            //
            Center(
              child: InkWell(
                //Tap para llamar el launchUrl con sus respectivos URL.
                onTap: () => launchUrl(urlMyGithub),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Imagen para la parte de Github.
                    Image.asset(
                      'assets/github.png',
                      width: width * 0.10,
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    //
                    const Text(
                      'My Github',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            //
            Center(
              child: InkWell(
                //Tap para llamar el launchUrl con sus respectivos URL.
                onTap: () => launchUrl(urlInstagram),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Imagen para parte de Instagram.
                    Image.asset(
                      'assets/instagram.png',
                      width: width * 0.10,
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    const Text(
                      'My Instagram',
                      //  textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
