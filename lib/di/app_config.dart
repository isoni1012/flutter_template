/*
import 'package:injectable/injectable.dart';

import 'raw_config.dart';

*/
/*
  This will create singleton class of AppConfig to get base url from env files
*//*


@singleton
class AppConfig {
  final RawConfig _config;

  AppConfig(this._config);

  String get apiUrl => _config['API_URL']!;
}*/
import 'package:flutter/material.dart';

enum Flavor { prod, dev, qa }

class AppConfig {
  String appName = "";
  String baseUrl = "";
  Flavor flavor = Flavor.dev;

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    String appName = "",
    String baseUrl = "",
    MaterialColor primaryColor = Colors.blue,
    Flavor flavor = Flavor.dev,
  }) {
    return shared = AppConfig(appName, baseUrl, flavor);
  }

  AppConfig(this.appName, this.baseUrl, this.flavor);
}