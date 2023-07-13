import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/features/dash_board/bloc/dashboard_bloc.dart';
import 'package:chatapp/src/features/edit_profile/bloc/editing_profile_bloc.dart';
import 'package:chatapp/src/features/edit_profile/repositories/edit_profile_repo.dart';
import 'package:chatapp/src/features/my_app/bloc/my_app_bloc.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _languageCode = TextConstant.vi;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => DashboardBloc())),
        BlocProvider(
            create: ((context) => EditingProfileBloc(
                editingProfileRepository: EditingProfileRepository()))),
        BlocProvider(create: ((context) => MyAppBloc())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(369, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocConsumer<MyAppBloc, MyAppState>(
            listener: (context, state) {
              if (state is MyAppGetDefaultLanguageSuccess) {
                _languageCode = state.languageCode;
              }
              if (state is MyAppUpdateLanguageSuccess) {
                _languageCode = state.languageCode;
              }
            },
            builder: (context, state) {
              return _buildMaterialApp(context);
            },
          );
        },
      ),
    );
  }

  MaterialApp _buildMaterialApp(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routeInformationParser: AppRouter.router.routeInformationParser,
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(_languageCode),
      supportedLocales: const [
        Locale(TextConstant.en), // English
        Locale(TextConstant.vi), // Spanish
      ],
      theme: ThemeData.light(),
      title: TextConstant.fChat,
    );
  }
}
