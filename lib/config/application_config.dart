import 'package:fluro/fluro.dart';
import 'package:get_it/get_it.dart';
import 'package:time_controller/routes/app_router.dart';

void config() {
  GetIt.I.registerSingleton<AppRouter>(AppRouter(FluroRouter()));
}