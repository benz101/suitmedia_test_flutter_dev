import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_test_flutter_dev/bloc/handle_api/user_bloc.dart';
import 'package:suitmedia_test_flutter_dev/bloc/handle_local/user_choosed_bloc.dart';
import 'package:suitmedia_test_flutter_dev/navigation/routes.dart';
import 'package:suitmedia_test_flutter_dev/ui/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(),
        ),
        BlocProvider<UserChoosedBloc>(
          create: (BuildContext context) => UserChoosedBloc(),
        ),
      ],
      child: const CupertinoApp(
        title: 'Flutter Demo',
        home: LoginPage(),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
