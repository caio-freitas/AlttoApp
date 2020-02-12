import 'package:altto_app/scripts/sendcommand.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart' as prefix0;
import 'package:toast/toast.dart';
import 'package:altto_app/components/globals.dart' as globals;
import 'package:altto_app/screens/DiscoveryPage.dart';

class Config extends StatefulWidget {
  State<Config> myState = new _ConfigState();

  @override
  _ConfigState createState() => myState;
}

class _ConfigState extends State<Config> {
  _ConfigState() {
/// If login data is necessary
//    if (loginData.length == 0) {
//      loginData.add(' ');
//      loginData.add(' ');
//    }
//    getUserName();
//    getPass();
  }
/// If login data is necessary
//  final TextEditingController textControlName = TextEditingController();
//
//  final TextEditingController textControlPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor:
        Theme.of(context).buttonTheme.colorScheme.primaryVariant,
        appBar: AppBar(
          title: Text('Configurações'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /// If login data is necessary
//              Text(
//                'Dados de Login',
//                style:
//                TextStyle(color: Theme.of(context).primaryIconTheme.color),
//              ),
//              SizedBox(
//                height: 15,
//              ),
//              TextField(
//                textAlign: TextAlign.center,
//                style:
//                TextStyle(color: Theme.of(context).primaryIconTheme.color),
//                decoration: InputDecoration(
//                  hintText: 'Nome',
//                  enabledBorder: UnderlineInputBorder(
//                    borderSide: BorderSide(
//                      color: Theme.of(context).primaryColor,
//                    ),
//                  ),
//                  focusedBorder: UnderlineInputBorder(
//                    borderSide: BorderSide(
//                      color: Theme.of(context).primaryIconTheme.color,
//                    ),
//                  ),
//                ),
//                controller: textControlName,
//              ),
//              SizedBox(
//                height: 15,
//              ),
//              TextField(
//                  style: TextStyle(
//                      color: Theme.of(context).primaryIconTheme.color),
//                  obscureText: true,
//                  keyboardType: TextInputType.number,
//                  textAlign: TextAlign.center,
//                  decoration: InputDecoration(
//                    hintText: 'Senha',
//                    enabledBorder: UnderlineInputBorder(
//                      borderSide: BorderSide(
//                        color: Theme.of(context).primaryColor,
//                      ),
//                    ),
//                    focusedBorder: UnderlineInputBorder(
//                      borderSide: BorderSide(
//                        color: Theme.of(context).primaryIconTheme.color,
//                      ),
//                    ),
//                  ),
//                  controller: textControlPass),
//              SizedBox(
//                height: 10,
//              ),
//              RaisedButton(
//                  child: Text(
//                    'Salvar',
//                    style: TextStyle(
//                        color: Theme.of(context).primaryIconTheme.color),
//                  ),
//                  color: Theme.of(context).primaryColor,
//                  onPressed: () {
//                    if (textControlName.text != '' &&
//                        textControlPass.text != '') {
//                      loginData[0] = textControlName.text;
//                      loginData[1] = textControlPass.text;
//
//                      saveData(userTag, textControlName.text);
//                      saveData(passTag, textControlPass.text);
//                      Toast.show('Usuário salvo com sucesso', context,
//                          duration: Toast.LENGTH_LONG);
//                    }
//                  }),
                Row(
                  children:  [
                    Text("Comunicação: "),
                    Text(""),
                    Text("Wi-Fi"),
                    Switch(
                      value: globals.using_bluetooth,
                      onChanged: (value) {
                        globals.using_bluetooth = value;
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {return DiscoveryPage();})
                        );
                      },
                    ),
                    Text("Bluetooth"),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
          ]
        ),
      ),
      );
  }
}

/// If login data is necessary
//final List<String> loginData = List();
//const String userTag = 'name';
//const String passTag = 'pass';

//String getPass() {
//  if (loginData[1] == ' ') {
//    retrieveSavedData(userTag).then((s) => loginData[1] = s);
//  }
//  return loginData[1];
//}

//Future<String> retrieveSavedData(String tag) async {
//  prefix0.SharedPreferences prefs =
//  await prefix0.SharedPreferences.getInstance();
//  return prefs.getString(tag) ?? ' ';
//}
//
//void saveData(String tag, String value) async {
//  prefix0.SharedPreferences prefs =
//  await prefix0.SharedPreferences.getInstance();
//
//  await prefs.setString(tag, value);
//}

/// If login data is necessary
//String getUserName() {
//  if (loginData[0] == ' ') {
//    retrieveSavedData(userTag).then((s) => loginData[0] = s);
//  }
//  return loginData[0];
//}