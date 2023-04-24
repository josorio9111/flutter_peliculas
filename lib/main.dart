import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:ejercicio_api/pages/detail.dart';
import 'package:ejercicio_api/pages/home.dart';
import 'package:ejercicio_api/provides/provide_movies.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider(), lazy: false),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'peliculas',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'details': (_) => const DetailPage(),
        },
        theme: ThemeData(useMaterial3: true));
  }
}
