import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {
  static SharedPreferences prefs;
  static String LOGIN_INFO = "login_info";
  static String ACCOUNT_KEY = "ACCOUNT_KEY";
  static String USER_TOKEN_KEY = "USER_TOKEN_KEY";
  static String LATITUDE_KEY = "LATITUDE_KEY";
  static String LONGITUDE_KEY = "LONGITUDE_KEY";

  static String MODE_KEY = "LONGITUDE_KEY";

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void writeShopName(String name) {
    prefs.setString(LONGITUDE_KEY, name);
  }

  static String readShopName() {
    return prefs.getString(LONGITUDE_KEY);
  }

  static void writeMode(int name) {
    prefs.setString(MODE_KEY, name.toString());
  }

  static String readMode() {
    return prefs.getString(MODE_KEY);
  }
}
