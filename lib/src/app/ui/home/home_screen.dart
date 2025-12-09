import 'package:flutter/material.dart';
import '../../data/ai_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_design.dart';
import 'settings_dialog.dart';
import 'ai_utils.dart';

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

    if (filtered.isEmpty) return const EmptyState(message: '');

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: filtered.length,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
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
            scaffoldBackgroundColor: const Color(0xFFF2F2F7),
          )
        : themeMode == 'dark'
            ? ThemeData.dark(useMaterial3: true).copyWith(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.blue,
                  brightness: Brightness.dark,
                ),
                scaffoldBackgroundColor: const Color(0xFF000000),
              )
            : (DateTime.now().hour >= 18 || DateTime.now().hour < 6)
                ? ThemeData.dark(useMaterial3: true).copyWith(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.blue,
                      brightness: Brightness.dark,
                    ),
                    scaffoldBackgroundColor: const Color(0xFF000000),
                  )
                : ThemeData.light(useMaterial3: true).copyWith(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.blue,
                      brightness: Brightness.light,
                    ),
                    scaffoldBackgroundColor: const Color(0xFFF2F2F7),
                  );

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            "AI Hub",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
            ),
          ),
          centerTitle: false,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.settings_rounded,
                  color: theme.brightness == Brightness.dark
                      ? Colors.white.withValues(alpha: 0.8)
                      : Colors.black.withValues(alpha: 0.8),
                ),
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
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 8, right: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: FloatingActionButton.extended(
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
            icon: const Icon(Icons.auto_awesome_rounded, size: 22),
            label: const Text(
              "Buscar IA",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.3,
              ),
            ),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
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
                        final gradient = AiUtils.getGradientForAi(item.name);
                        final initials = AiUtils.getInitialsForAi(item.name);

                        return ListTile(
                          leading: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: gradient,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                initials,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}