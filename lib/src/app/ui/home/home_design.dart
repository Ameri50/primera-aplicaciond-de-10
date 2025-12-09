import 'package:flutter/material.dart';
import '../../data/ai_model.dart';

// Header de la app con diseño moderno
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Encuentra la IA perfecta",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white.withValues(alpha: 0.7) : Colors.black.withValues(alpha: 0.6),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "para cada tarea",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white.withValues(alpha: 0.7) : Colors.black.withValues(alpha: 0.6),
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// Barra de búsqueda estilo Apple
class AiSearchBar extends StatelessWidget {
  final String search;
  final Function(String) onChanged;

  const AiSearchBar({
    super.key,
    required this.search,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: isDark 
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark 
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.08),
            width: 0.5,
          ),
        ),
        child: TextField(
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.2,
          ),
          decoration: InputDecoration(
            hintText: "Buscar",
            hintStyle: TextStyle(
              color: isDark ? Colors.white.withValues(alpha: 0.4) : Colors.black.withValues(alpha: 0.4),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.2,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: isDark ? Colors.white.withValues(alpha: 0.5) : Colors.black.withValues(alpha: 0.5),
              size: 20,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// Tarjeta de IA estilo Apple
class AiCardModern extends StatefulWidget {
  final AiModel item;
  final VoidCallback onTap;

  const AiCardModern({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  State<AiCardModern> createState() => _AiCardModernState();
}

class _AiCardModernState extends State<AiCardModern> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => isPressed = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: isPressed ? 0.98 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: isDark 
                ? Colors.white.withValues(alpha: isPressed ? 0.08 : 0.06)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark 
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.08),
              width: 0.5,
            ),
            boxShadow: isDark ? [] : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Ícono circular estilo iOS
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: _getGradientColors(widget.item.name),
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: _getGradientColors(widget.item.name)[0].withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: _buildAiIcon(widget.item.name),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _getCategoryLabel(widget.item.tags),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isDark 
                                  ? Colors.white.withValues(alpha: 0.5)
                                  : Colors.black.withValues(alpha: 0.5),
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: isDark 
                          ? Colors.white.withValues(alpha: 0.3)
                          : Colors.black.withValues(alpha: 0.3),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.item.description,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: isDark 
                        ? Colors.white.withValues(alpha: 0.7)
                        : Colors.black.withValues(alpha: 0.7),
                    letterSpacing: -0.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: widget.item.tags
                      .take(3)
                      .map((tag) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: isDark 
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : Colors.black.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isDark 
                                    ? Colors.white.withValues(alpha: 0.1)
                                    : Colors.black.withValues(alpha: 0.08),
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isDark 
                                    ? Colors.white.withValues(alpha: 0.6)
                                    : Colors.black.withValues(alpha: 0.6),
                                letterSpacing: -0.1,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Función para construir el ícono personalizado
  Widget _buildAiIcon(String name) {
    final iconData = {
      'ChatGPT': '💬',
      'GitHub Copilot': '⚡',
      'Claude': '✨',
      'Google Gemini': '💎',
      'Amazon CodeWhisperer': '</>',
      'Midjourney': '🎨',
      'DALL-E': '🖼️',
      'Canva AI': '📐',
      'Stable Diffusion': '🌈',
      'Adobe Firefly': '🔥',
      'Perplexity': '🔍',
      'You.com': '🌐',
      'Jasper': '📝',
      'Copy.ai': '✍️',
      'Grammarly': '✓',
      'Eleven Labs': '🎤',
      'Descript': '🎧',
      'Notion AI': '📓',
      'Microsoft Copilot': '🖥️',
      'Synthesia': '🎬',
      'Runway ML': '🎞️',
      'Khan Academy': '🎓',
    };
    
    final icon = iconData[name] ?? '🤖';
    
    // Si es texto como </>, usar Text
    if (icon == '</>') {
      return const Text(
        '</>',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    
    // Para emojis, usar Text con tamaño mayor
    return Text(
      icon,
      style: const TextStyle(
        fontSize: 28,
      ),
    );
  }

  // Función para obtener gradientes según la IA
  List<Color> _getGradientColors(String name) {
    final gradients = {
      'ChatGPT': [const Color(0xFF10A37F), const Color(0xFF1FB38D)],
      'GitHub Copilot': [const Color(0xFF2088FF), const Color(0xFF4AA4FF)],
      'Claude': [const Color(0xFFD97757), const Color(0xFFE89474)],
      'Google Gemini': [const Color(0xFF4285F4), const Color(0xFF669DF6)],
      'Amazon CodeWhisperer': [const Color(0xFFFF9900), const Color(0xFFFFAD33)],
      'Midjourney': [const Color(0xFF9B59B6), const Color(0xFFAF7AC5)],
      'DALL-E': [const Color(0xFFE74C3C), const Color(0xFFEC7063)],
      'Canva AI': [const Color(0xFF00C4CC), const Color(0xFF33D1D8)],
      'Stable Diffusion': [const Color(0xFF3498DB), const Color(0xFF5DADE2)],
      'Adobe Firefly': [const Color(0xFFFF0050), const Color(0xFFFF3366)],
      'Perplexity': [const Color(0xFF1FB6FF), const Color(0xFF4DC4FF)],
      'You.com': [const Color(0xFF7B68EE), const Color(0xFF9B8AEE)],
      'Jasper': [const Color(0xFFFF6B6B), const Color(0xFFFF8787)],
      'Copy.ai': [const Color(0xFF16A085), const Color(0xFF1ABC9C)],
      'Grammarly': [const Color(0xFF15C39A), const Color(0xFF3BD5AE)],
      'Eleven Labs': [const Color(0xFFE67E22), const Color(0xFFEB984E)],
      'Descript': [const Color(0xFF8E44AD), const Color(0xFFA569BD)],
      'Notion AI': [const Color(0xFF000000), const Color(0xFF2C2C2C)],
      'Microsoft Copilot': [const Color(0xFF0078D4), const Color(0xFF33A3F4)],
      'Synthesia': [const Color(0xFFFF4757), const Color(0xFFFF6B81)],
      'Runway ML': [const Color(0xFF6C5CE7), const Color(0xFF8B7AE7)],
      'Khan Academy': [const Color(0xFF14BF96), const Color(0xFF3DD5B5)],
    };
    
    return gradients[name] ?? [const Color(0xFF667EEA), const Color(0xFF764BA2)];
  }

  // Función para obtener categoría
  String _getCategoryLabel(List<String> tags) {
    if (tags.contains('programacion') || tags.contains('codigo')) {
      return 'Programación';
    } else if (tags.contains('imagenes') || tags.contains('diseno')) {
      return 'Diseño';
    } else if (tags.contains('texto') || tags.contains('redaccion')) {
      return 'Redacción';
    } else if (tags.contains('investigacion')) {
      return 'Investigación';
    } else if (tags.contains('audio') || tags.contains('voz')) {
      return 'Audio';
    } else if (tags.contains('video')) {
      return 'Video';
    } else if (tags.contains('productividad')) {
      return 'Productividad';
    }
    return 'IA General';
  }
}

// Estado vacío estilo Apple
class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required String message});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isDark 
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 40,
              color: isDark 
                  ? Colors.white.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "No se encontraron resultados",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Intenta con otro término de búsqueda",
            style: TextStyle(
              fontSize: 15,
              color: isDark 
                  ? Colors.white.withValues(alpha: 0.5)
                  : Colors.black.withValues(alpha: 0.5),
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}