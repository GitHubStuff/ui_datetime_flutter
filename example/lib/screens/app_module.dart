import 'package:flutter_modular/flutter_modular.dart';

import 'home_scaffold.dart';

/// The main application module.
class AppModule extends Module {
  // Provide a list of dependencies to inject into your project

  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const HomeScaffold());
  }
}
