import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suitmedia_test_flutter_dev/ui/home_page.dart';
import 'package:suitmedia_test_flutter_dev/ui/login_page.dart';
import 'package:suitmedia_test_flutter_dev/ui/user_list_page.dart';
import 'package:suitmedia_test_flutter_dev/ui/webview_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.routeName:
        return CupertinoPageRoute(builder: (_) => const LoginPage());
      case HomePage.routeName:
         var argsName = settings.arguments as String;
        return CupertinoPageRoute(builder: (_) =>  HomePage(name: argsName,));
       case UserListPage.routeName:
        return CupertinoPageRoute(builder: (_) => const UserListPage());
      case WebViewPage.routeName:
        return CupertinoPageRoute(builder: (_) => const WebViewPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text('Error page')),
      );
    });
  }
}
