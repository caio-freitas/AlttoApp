import 'package:shared_preferences/shared_preferences.dart' as prefix0;


String getUserName() {
  retrieveSavedData(userTag).then((s) => loginData[0] = s);
  return loginData[0];
}

final List<String> loginData = List();
const String userTag = 'username';
const String passTag = 'senha';

String getPass() {
  retrieveSavedData(passTag).then((s) => loginData[1] = s);
  return loginData[1];
}

Future<String> retrieveSavedData(String tag) async {
  prefix0.SharedPreferences prefs =
  await prefix0.SharedPreferences.getInstance();
  return prefs.getString(tag) ?? ' ';
}