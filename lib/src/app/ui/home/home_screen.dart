import 'package:flutter/material.dart';
import '../../data/ai_list.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    final filtered = aiTools.where((tool) {
      final s = search.toLowerCase();
      return tool.name.toLowerCase().contains(s) ||
          tool.description.toLowerCase().contains(s) ||
          tool.tags.any((tag) => tag.toLowerCase().contains(s));
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscador de Inteligencias Artificiales"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Buscar IA por trabajo, programación, diseño...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() => search = value);
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final item = filtered[i];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.smart_toy, size: 32),
                    title: Text(item.name),
                    subtitle: Text(item.description),
                    trailing: const Icon(Icons.open_in_new),
                    onTap: () async {
                      final Uri url = Uri.parse(item.url);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      }
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
