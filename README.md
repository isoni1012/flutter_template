# flutter-template

A Basic Code Structure for Flutter project.

Here we are trying to achieve clean code architecture in flutter by separating UI, business logic,
data structure(database & api calling)
So here are few layers of architecture

1) UI Layer
   In this layer we will deal with UI related code and business logic. For business logic we will
   user BLoc method.
2) Domain Layer
   In this layer we will create model and repo which contain abstract methods for api calling or
   database calling
3) Data Layer
   In this layer we will implement api calling and database calling method

Below are the folder structure

- config folder will contain all configuration related to app like theme, route info
- utils folder will contain app constants, string, number, extensions
- ui folder will contain view pages, widgets and cubits
- data folder container api and data related classes like repos
- models folder will contain all request and response models

Use this command to generate .g classes
flutter pub run build_runner build --delete-conflicting-outputs

To create cubit class you need to add plugin BLoC in IDE then after restart just right click on any
folder and you can see options for create cubit class
You need to create cubit class for all api call response for example when you create api for
AppConfig you need to create cubit for AppConfig api response same for login, register, etc.

- Reference
  https://devmuaz.medium.com/flutter-clean-architecture-series-part-1-d2d4c2e75c47

# Create new screen
- create file in ui/view folder user postfix _screen as we used AutoRoute library it will auto generate file for example when you create file with splash_screen it will auto create SplashRoute
- add @RoutePage() above your class name than run build runner so flutter will create route page
    i.e @RoutePage()
        class SplashScreen extends HookWidget{}
- add route page in config/router/app_router.dart file 

# Android
- Create jks file and set in android/app folder
- edit key.properties file under android folder like this 
  For generating app its recommended to use command
- For generate sign/debug apk or app bundle with product flavor
   flutter build {apk/appbundle} --flavor {flavor name} -t lib/{entry point}.dart --{release/debug}
  (Note : - In above command write apk for generating apk file or for app bundle use appbundle 
          - if you are using product flavor write flavor name like --flavor qa
          - As we created main file for each flavor than enter specific main file for particular flavor as in our case main_dev.dart for dev flavor and main_qa.dart for qa flavor.
          - At the end of command add --release or --debug for generating release or debug build. If you mention release than it will use keystore file which you have mentioned in android/key.properties and it will not use in debug mode)
- For generating sign/debug apk or app bundle without product flavor
  flutter build {apk/appbundle} -t lib/{entry point}.dart --{release/debug}
  (Note : make sure you have not mentions any flavor in build.gradle otherwise it will not create any build)
  