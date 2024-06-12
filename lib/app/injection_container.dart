import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection_container.config.dart';

final getIt = GetIt.instance;
@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @Named("BaseUrl")
  String get baseUrl =>
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyCJtDbYQPyMOXIdSD_jm7NQHRb2pI3tyEA";

  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) => Dio(BaseOptions(baseUrl: url));
}
