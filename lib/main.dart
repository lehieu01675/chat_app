import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/di/injection.dart';
import 'package:chatapp/src/service/cache_server.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'src/features/my_app/page/my_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // dependency injection initialization
  configureDependencies();

  // check the first time open app
  CacheService.firstTime();

  // hive initialization
  await Hive.initFlutter();

  // Register Adapter
  Hive.registerAdapter(UserModelAdapter());

  /// open box user-lc
  await Hive.openBox(TextConstant.currentUserPath);

  await dotenv.load(fileName: ".env");

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) async {
    // firebase initialization
    await Firebase.initializeApp();
    runApp(const MyApp());
    // runApp(
    //   DevicePreview(
    //     enabled: !kReleaseMode,
    //     builder: (context) => const MyApp(), // Wrap your app
    //   ),
    // );
  });
}
