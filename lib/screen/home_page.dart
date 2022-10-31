import 'package:flutter/material.dart';

import 'package:codigolimpionetforemost/widgets/appbar.dart';

import '../widgets/drawer_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: drawerAppBarMenu(context),
      appBar: appBarCode(context, scaffoldKey),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('tesjt'),
          ],
        ),
      ),
    );
  }
}
