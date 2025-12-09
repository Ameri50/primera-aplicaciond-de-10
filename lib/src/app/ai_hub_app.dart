import 'package:flutter/material.dart';
import 'ui/home/home_screen.dart';  // ← Agregar esta línea

class AiHubApp extends StatelessWidget {
  const AiHubApp({super.key});

@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,  // ← Agrega esta línea
    title: "AI Hub - Buscador de IA",
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
    ),
    home: const HomeScreen(),
  );
  }
}