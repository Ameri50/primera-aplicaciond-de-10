import 'package:flutter/material.dart';

class AiHubApp extends StatelessWidget {
  const AiHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AI Hub - Buscador de IA",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: const Center(
        child: Text("Welcome to AI Hub!"),
      ),
    );
  }
}
