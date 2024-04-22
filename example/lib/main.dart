import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ui_datetime_flutter/ui_datetime_flutter.dart';

import 'screens/app_module.dart';
import 'screens/home_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ModularApp(
      module: AppModule(),
      child: DateTimeToast.setUp(child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        extensions: [DateTimePickerTheme.light()],
      ),
      darkTheme:
          ThemeData.dark().copyWith(extensions: [DateTimePickerTheme.dark()]),
      themeMode: ThemeMode.system,
      localizationsDelegates: const [],
      // Use a BlocProvider to provide the UIThemeModeCubit to the widget tree.
      builder: (context, routerBuilder) => MultiBlocProvider(
        providers: [
          BlocProvider<RadioButtonCubit>(
            create: (context) => RadioButtonCubit(radioButtonContent2),
          ),
        ],
        child: routerBuilder!,
      ),
    );
  }
}
