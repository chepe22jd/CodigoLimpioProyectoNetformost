import 'package:flutter/material.dart';

import 'package:codigolimpionetforemost/widgets/appbar.dart';
import 'package:codigolimpionetforemost/widgets/drawer_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateByPage extends StatelessWidget {
  const CreateByPage({super.key});

  @override
  Widget build(BuildContext context) {
    //variales de URL y mandar a la funcion lauchURL y ver dicho website
    final Uri urlMyGithub = Uri.parse('https://github.com/chepe22jd');
    final Uri urlInstagram = Uri.parse('https://www.instagram.com/chepe11jd/');
    //llave para controlar el scafoldstate
    final GlobalKey<ScaffoldState> key = GlobalKey();
    //variables para optener los size screen
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: key,
      drawer: drawerAppBarMenu(context), //drawer desde la caperta de widgets
      appBar: appBarCode(context, key), //appbar desde la caperta de widgets
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
            Center(
              child: InkWell(
                //tap para llamar los url
                onTap: () => launchUrl(urlMyGithub),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //imagen para la parte de github
                    Image.asset(
                      'assets/github.png',
                      width: width * 0.10,
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    const Text(
                      'My Github',
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
            SizedBox(
              height: height * 0.03,
            ),
            Center(
                child: InkWell(
              //lanzar url de instagram
              onTap: () => launchUrl(urlInstagram),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //imagen para parte de instagram
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
            ))
          ],
        ),
      ),
    );
  }
}
