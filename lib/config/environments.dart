import 'package:injectable/injectable.dart';

abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
}

abstract class AppEnvConfig {}

@Environment(Env.dev)
@Singleton(as: AppEnvConfig)
class DevEnv implements AppEnvConfig {}

@Environment(Env.prod)
@Singleton(as: AppEnvConfig)
class ProdEnv implements AppEnvConfig {}
