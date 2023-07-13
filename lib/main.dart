import 'package:chatapp/src/di/injection.dart';
import 'package:chatapp/src/service/cache_server.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/features/my_app/page/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // dependency injection initialization
  configureDependencies();

  // check the first time open app
  CacheService.firstTime();

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
