import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:friends/core/common_bloc/setting_bloc/setting_bloc.dart';
import 'package:friends/core/localization/app_localization.dart';
import 'package:friends/core/log/log.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/core/manager/theme_manager.dart';
import 'package:friends/core/routes/routes.dart';

class App extends StatelessWidget {
  const App._internal();

  static const App instance = App._internal();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingBloc, SettingState>(
      buildWhen: (oldState,newState)=>oldState!=newState,
      listenWhen: (_,__)=>true,
      bloc:BlocProvider.of<SettingBloc>(context),
      listener: (context, state) {
        PrintLog.call(
            tag: "Setting bloc ",
            message: "Rebuild the app listener using setting bloc with ${state
                .props}");
      },
      builder: (context, state) {
        PrintLog.call(
            tag: "Setting bloc ",
            message: "Rebuild the app .... using setting bloc with ${state
                .props}");
        final material =MaterialApp(
          locale: (state is ReBuildTheAppState)?state.locale:null,
          themeMode: ThemeManager.themeMode,
          supportedLocales:  AppLocal.languages().map((e) => Locale(e)).toList(),
          localizationsDelegates: const [
            AppLocal.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: ConstantManager.appTitle,
          routes: RoutesManager.routes(),
          theme: ThemeManager.getAllThemeData(),
        );
        return material;
      },
    );
  }
}
