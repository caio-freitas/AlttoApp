import 'package:flutter/material.dart';
import 'package:altto_app/components/appbarlogo.dart';
import 'package:altto_app/components/button.dart';
import 'package:altto_app/components/label.dart';
import 'package:altto_app/scripts/basicfunctions.dart';
import '../scripts/sendcommand.dart';
import 'package:altto_app/screens/DiscoveryPage.dart';
import 'package:altto_app/components/globals.dart' as globals;

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({this.title}) {
    if (loginData.length == 0) {
      loginData.add(' ');
      loginData.add(' ');
    }
    getUserName();
    getPass();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).buttonTheme.colorScheme.primary,
        child: SafeArea(
          child: Scaffold(
            backgroundColor:
            Theme.of(context).buttonTheme.colorScheme.primaryVariant,
            appBar: getAppBar(context), // barra superior
            body: getBody(context),
          ),
        ),
      ),
    );
  }
}

Widget getAppBar(BuildContext context) {
  return AppBar(
    title: Row(
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: AppBarLogo(),
        ),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Controle Manual',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: FittedBox(
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                if (globals.using_bluetooth == false) {
                  Navigator.pushNamed(context, '/config');
                }
                else {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {return DiscoveryPage();})
                  );
                }
              },
            ),
          ),
        )
      ],
    ),
  );
}

Widget getBody(BuildContext context) {
  return SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          flex: 0,
          child: Image.asset(
            'images/transp.png',
            scale: 1.5,
            //color: Theme.of(context).primaryIconTheme.color,
          ),
        ), //imagem
        Expanded(
          flex: 1,
          child: TextLabel('Guincho (vertical)', context),
        ), //label --portao de ferro
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: BasicButton(
                    imgSrc: 'images/subir.png',
                    text: 'Subir',
                    onPressed: () {
                      if (globals.using_bluetooth) {
                        sendBluetoothCommand(up, context);
                      }
                      else {
                        sendCommand(getUserName(), getPass(), up, context);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: BasicButton(
                    imgSrc: 'images/pause.png',
                    text: 'Parar',
                    onPressed: () {
                      if (globals.using_bluetooth) {
                        sendBluetoothCommand(stop, context);
                      }
                      else {
                        sendCommand(getUserName(), getPass(), stop, context);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: BasicButton(
                    imgSrc: 'images/descer.png',
                    text: 'Descer',
                    onPressed: () {
                      if (globals.using_bluetooth) {
                        sendBluetoothCommand(down, context);
                      }
                      else {
                        sendCommand(getUserName(), getPass(), down, context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ), //buttom row 1
        Expanded(
          flex: 1,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 2, 30, 2),
                child: TextLabel('Mover', context)),
          ),
        ), //Label --portao externo
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: BasicButton(
                    imgSrc: 'images/tras.png',
                    text: 'Trás',
                    onPressed: () {
                      // Faz os jutsu
                      if (globals.using_bluetooth) {
                       sendBluetoothCommand(backward, context);
                      }
                      else {
                        sendCommand(getUserName(), getPass(), backward, context);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: BasicButton(
                    imgSrc: 'images/pause.png',
                    text: 'Parar',
                    onPressed: () {
                      // Faz os jutsu
                      if (globals.using_bluetooth) {
                        sendBluetoothCommand(stop, context);
                      }
                      else {
                        sendCommand(getUserName(), getPass(), stop, context);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: BasicButton(
                    imgSrc: 'images/frente.png',
                    text: 'Frente',
                    onPressed: () {
                      // Faz os jutsu
                      if (globals.using_bluetooth) {
                        sendBluetoothCommand(forward, context);
                      }
                      else {
                        sendCommand(getUserName(), getPass(), forward, context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ) //buttom row 2
      ],
    ),
  );
}