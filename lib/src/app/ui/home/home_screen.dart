import 'package:flutter/material.dart';
import '../../data/ai_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_design.dart';
import 'settings_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String search = "";
  String themeMode = 'dark';

  Widget _buildAiList(BuildContext context) {
    final filtered = aiTools.where((tool) {
      final s = search.toLowerCase();
      return tool.name.toLowerCase().contains(s) ||
          tool.description.toLowerCase().contains(s) ||
          tool.tags.any((tag) => tag.toLowerCase().contains(s));
    }).toList();

    if (filtered.isEmpty) return const EmptyState();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filtered.length,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: AiCardModern(
          item: filtered[i],
          onTap: () async {
            final Uri url = Uri.parse(filtered[i].url);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = themeMode == 'light'
        ? ThemeData.light(useMaterial3: true).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
          )
        : themeMode == 'dark'
            ? ThemeData.dark(useMaterial3: true).copyWith(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.blue,
                  brightness: Brightness.dark,
                ),
              )
            : (DateTime.now().hour >= 18 || DateTime.now().hour < 6)
                ? ThemeData.dark(useMaterial3: true).copyWith(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.blue,
                      brightness: Brightness.dark,
                    ),
                  )
                : ThemeData.light(useMaterial3: true).copyWith(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.blue,
                      brightness: Brightness.light,
                    ),
                  );

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: theme.brightness == Brightness.dark
            ? const Color(0xFF0A0E27)
            : Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "AI Hub",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => SettingsDialog(
                    currentThemeMode: themeMode,
                    onThemeModeChanged: (mode) {
                      if (mounted) {
                        setState(() => themeMode = mode);
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const HomeHeader(),
            AiSearchBar(
              search: search,
              onChanged: (value) => setState(() => search = value),
            ),
            Expanded(child: _buildAiList(context)),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => SmartSearchDialog(
                onSearch: (query) {
                  if (mounted) {
                    setState(() => search = query);
                  }
                },
              ),
            );
          },
          icon: const Icon(Icons.auto_awesome_rounded),
          label: const Text("Buscar IA"),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}

// Diálogo de búsqueda inteligente
class SmartSearchDialog extends StatefulWidget {
  final Function(String) onSearch;

  const SmartSearchDialog({super.key, required this.onSearch});

  @override
  State<SmartSearchDialog> createState() => _SmartSearchDialogState();
}

class _SmartSearchDialogState extends State<SmartSearchDialog> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> filteredAis = [];

  void _searchAis(String query) {
    if (query.isEmpty) {
      setState(() => filteredAis = []);
      return;
    }

    final q = query.toLowerCase();
    final programmingKeywords = ['codigo', 'programar', 'desarrollo', 'python', 'javascript', 'code', 'desarrollar', 'programacion'];
    final designKeywords = ['diseño', 'imagen', 'logo', 'arte', 'grafico', 'design', 'image'];
    final writingKeywords = ['texto', 'escribir', 'redaccion', 'articulo', 'contenido', 'essay', 'writing'];
    final researchKeywords = ['investigar', 'buscar', 'informacion', 'datos', 'research', 'aprender'];
    final productivityKeywords = ['productividad', 'organizar', 'tarea', 'proyecto', 'presentacion', 'productivity'];

    int programmingScore = programmingKeywords.where((k) => q.contains(k)).length;
    int designScore = designKeywords.where((k) => q.contains(k)).length;
    int writingScore = writingKeywords.where((k) => q.contains(k)).length;
    int researchScore = researchKeywords.where((k) => q.contains(k)).length;
    int productivityScore = productivityKeywords.where((k) => q.contains(k)).length;

    List<String> targetTags = [];
    if (programmingScore > 0) targetTags.addAll(['programacion', 'codigo']);
    if (designScore > 0) targetTags.addAll(['diseño', 'imagen']);
    if (writingScore > 0) targetTags.addAll(['redaccion', 'texto']);
    if (researchScore > 0) targetTags.add('investigacion');
    if (productivityScore > 0) targetTags.add('productividad');

    setState(() {
      filteredAis = aiTools.where((tool) {
        try {
          final name = tool.name.toLowerCase();
          final description = tool.description.toLowerCase();
          final tags = tool.tags.map((t) => t.toLowerCase()).toList();

          final matchesQuery = name.contains(q) || description.contains(q);
          final matchesTags = targetTags.isEmpty || tags.any((tag) => targetTags.any((t) => tag.contains(t)));

          return matchesQuery || matchesTags;
        } catch (e) {
          return false;
        }
      }).toList();
    });
  }

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      if (mounted) {
        Navigator.pop(context);
      }
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: isDark ? const Color(0xFF1A1F3A) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxHeight: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.search, color: isDark ? Colors.white : Colors.black87),
                const SizedBox(width: 12),
                Text(
                  "Buscar IA Inteligente",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              autofocus: true,
              style: TextStyle(color: isDark ? Colors.white : Colors.black87),
              decoration: InputDecoration(
                hintText: "Ej: codigo, diseño, texto...",
                hintStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
                prefixIcon: Icon(Icons.auto_awesome, color: isDark ? Colors.blue[300] : Colors.blue),
                filled: true,
                fillColor: isDark ? Colors.grey.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: _searchAis,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredAis.isEmpty
                  ? Center(
                      child: Text(
                        _controller.text.isEmpty
                            ? "Escribe lo que necesitas..."
                            : "No se encontraron IAs",
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredAis.length,
                      itemBuilder: (_, i) {
                        final item = filteredAis[i];
                        return ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.auto_awesome_rounded,
                              color: isDark ? Colors.blue[300] : Colors.blue,
                            ),
                          ),
                          title: Text(
                            item.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            item.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isDark ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                          onTap: () => _openUrl(item.url),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}