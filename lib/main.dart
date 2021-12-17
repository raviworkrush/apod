import 'dart:io';

import 'package:apod/logic/cubit/todays_picture_cubit.dart';
import 'package:apod/view/pages/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TodaysPictureCubit>(
            create: (context) => TodaysPictureCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Astronomy Picture of the Day',
          theme: ThemeData(
            primarySwatch: Colors.orange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Poppins',
          ),
          home: const MyHomePage(),
        ));
  }
}

//CERTIFICATE_VERIFY_FAILED
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
