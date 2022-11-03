import 'package:flutter/material.dart';

import 'package:codigolimpionetforemost/widgets/appbar.dart';
import 'package:codigolimpionetforemost/widgets/drawer_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class CreadoPorPage extends StatelessWidget {
  const CreadoPorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri _urlMyGithub = Uri.parse('https://github.com/chepe22jd');

    final Uri _urlInstagram = Uri.parse('https://www.instagram.com/chepe11jd/');

    final GlobalKey<ScaffoldState> _key = GlobalKey();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _key,
      drawer: drawerAppBarMenu(context),
      appBar: appBarCode(context, _key),
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
                onTap: () => launchUrl(_urlMyGithub),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
              onTap: () => launchUrl(_urlInstagram),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
