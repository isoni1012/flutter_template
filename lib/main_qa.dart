import 'package:flutter_base_project/main.dart';

import 'di/app_config.dart';

void main(){
  AppConfig.create(
    appName: "Prod Flavor Example",
    baseUrl: "https://newsapi.org/v2",
    flavor: Flavor.qa,
  );
  mainCommon();
}