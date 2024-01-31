import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/config/router/app_router.dart';
import 'package:flutter_base_project/data/datasources/local/prefs.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class WelcomeScreen extends HookWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(Prefs.getBool("isEntered"));
    return Scaffold(
      key: key,
      body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome to flutter base project",
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                ),
                ElevatedButton(
                    onPressed: () {
                      // context.go("/news_list");
                      Prefs.setBool("isEntered", true);
                      context.router.push(NewsListRoute());
                    },
                    child: const Text("Enter"))
              ],
            ),
          )),
    );
  }
}
