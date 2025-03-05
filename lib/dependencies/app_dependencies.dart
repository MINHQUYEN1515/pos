import 'package:get_it/get_it.dart';
import 'package:pos/dependencies/bloc_dependencies.dart';
import 'package:pos/dependencies/page_dependencies.dart';
import 'package:pos/dependencies/repositories_dependencies.dart';
import 'package:pos/dependencies/service_dependencies.dart';

class AppDependencies {
  static GetIt get injector => GetIt.I;
  static Future<void> init() async {
    await PageDependencies.setup(injector);
    await RepositoriesDependencies.setup(injector);
    await ServiceDependencies.setup(injector);
    await BlocDependencies.setup(injector);
  }
}
