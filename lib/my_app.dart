import 'package:chatapp/src/constant/text_cons.dart';
import 'package:chatapp/src/features/dash_board/bloc/dashboard_bloc.dart';
import 'package:chatapp/src/features/edit_profile/bloc/editing_profile_bloc.dart';
import 'package:chatapp/src/features/edit_profile/repositories/edit_profile_repo.dart';
import 'package:chatapp/src/l10n/app_localizations.dart';
import 'package:chatapp/src/router/app_router.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => DashboardBloc())),
        BlocProvider(
            create: ((context) => EditingProfileBloc(
                editingProfileRepository: EditingProfileRepository()))),
      ],
      child: ScreenUtilInit(
        designSize: const Size(369, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return _buildMaterialApp(context);
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
      locale: const Locale(TextConstant.en),
      supportedLocales: const [
        Locale(TextConstant.en), // English
        Locale(TextConstant.vi), // Spanish
      ],
      theme: ThemeData.light(),
      title: TextConstant.fChat,
    );
  }
}
