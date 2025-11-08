import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';
import 'home_page.dart';
import 'anuncio_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Hive.initFlutter('ecomerce_hive_db');
  } else {
    await Hive.initFlutter();
  }

  Hive.registerAdapter(AnuncioAdapter());
  await Hive.openBox<Anuncio>('anuncios');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Mercado',
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
