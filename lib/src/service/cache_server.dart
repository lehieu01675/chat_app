import 'package:chatapp/src/constant/text_cons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static void firstTime() async {
    final SharedPreferences prf = await SharedPreferences.getInstance();
    if (prf.getBool(TextConstant.isFirstTime) != null) {
      prf.setBool(TextConstant.isFirstTime, false);
    } else {
      prf.setBool(TextConstant.isFirstTime, true);
    }
  }
}
