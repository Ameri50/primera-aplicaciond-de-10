import 'package:flutter/material.dart';

class AiUtils {
  static List<Color> getGradientForAi(String name) {
    final lowerName = name.toLowerCase().trim();
    
    final gradients = {
      'chatgpt': [const Color(0xFF10A37F), const Color(0xFF0D8C6F)],
      'github copilot': [const Color(0xFF1F6FEB), const Color(0xFF0D47A1)],
      'claude': [const Color(0xFFD4A574), const Color(0xFFA67C52)],
      'google gemini': [const Color(0xFF9C27B0), const Color(0xFF6A1B9A)],
      'amazon codewhisperer': [const Color(0xFFFF9900), const Color(0xFFE68B00)],
      'midjourney': [const Color(0xFF5B21B6), const Color(0xFF3730A3)],
      'dall-e': [const Color(0xFF00BCD4), const Color(0xFF0097A7)],
      'canva': [const Color(0xFF00D4FF), const Color(0xFF0099CC)],
      'stable diffusion': [const Color(0xFFFF6B6B), const Color(0xFFEE5A6F)],
      'adobe firefly': [const Color(0xFFFF0000), const Color(0xFFCC0000)],
      'perplexity': [const Color(0xFF3B82F6), const Color(0xFF1E40AF)],
      'you.com': [const Color(0xFFFF6B35), const Color(0xFFE63946)],
      'jasper': [const Color(0xFF6D28D9), const Color(0xFF4C1D95)],
      'copy.ai': [const Color(0xFF14B8A6), const Color(0xFF0D9488)],
      'grammarly': [const Color(0xFF15C784), const Color(0xFF0BA156)],
      'eleven labs': [const Color(0xFF8B5CF6), const Color(0xFF6D28D9)],
      'descript': [const Color(0xFFFBBF24), const Color(0xFFF59E0B)],
      'notion': [const Color(0xFF000000), const Color(0xFF404040)],
      'microsoft copilot': [const Color(0xFF0078D4), const Color(0xFF005A9E)],
      'synthesia': [const Color(0xFF00D4FF), const Color(0xFF0099FF)],
      'runway': [const Color(0xFF00FF88), const Color(0xFF00CC66)],
      'khan academy': [const Color(0xFF14BF96), const Color(0xFF0F9470)],
    };

    // Busca coincidencia exacta primero
    if (gradients.containsKey(lowerName)) {
      return gradients[lowerName]!;
    }

    // Si no encuentra, busca por palabras clave
    for (var key in gradients.keys) {
      if (lowerName.contains(key) || key.contains(lowerName)) {
        return gradients[key]!;
      }
    }

    // Por defecto, genera un color basado en el nombre
    return _generateGradientFromName(name);
  }

  static List<Color> _generateGradientFromName(String name) {
    final colors = [
      [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      [const Color(0xFFF093FB), const Color(0xFFF5576C)],
      [const Color(0xFF4FACFE), const Color(0xFF00F2FE)],
      [const Color(0xFFFA709A), const Color(0xFFFECE34)],
      [const Color(0xFF30CFD0), const Color(0xFF330867)],
      [const Color(0xFFA8EDEA), const Color(0xFFFED6E3)],
      [const Color(0xFF9890E3), const Color(0xFFB1F83B)],
      [const Color(0xFFFF9A56), const Color(0xFFFF6A88)],
    ];
    
    final hash = name.hashCode.abs();
    return colors[hash % colors.length];
  }

  static String getInitialsForAi(String name) {
    final lowerName = name.toLowerCase().trim();
    
    const initials = {
      'chatgpt': 'GP',
      'github copilot': 'CP',
      'claude': 'CL',
      'google gemini': 'GM',
      'amazon codewhisperer': 'CW',
      'midjourney': 'MJ',
      'dall-e': 'DE',
      'canva': 'CA',
      'stable diffusion': 'SD',
      'adobe firefly': 'AF',
      'perplexity': 'PX',
      'you.com': 'YC',
      'jasper': 'JS',
      'copy.ai': 'CP',
      'grammarly': 'GM',
      'eleven labs': 'EL',
      'descript': 'DS',
      'notion': 'NA',
      'microsoft copilot': 'MC',
      'synthesia': 'SY',
      'runway': 'RM',
      'khan academy': 'KA',
    };

    // Busca coincidencia exacta
    if (initials.containsKey(lowerName)) {
      return initials[lowerName]!;
    }

    // Si no encuentra, busca por palabras clave
    for (var key in initials.keys) {
      if (lowerName.contains(key) || key.contains(lowerName)) {
        return initials[key]!;
      }
    }

    // Por defecto, toma las 2 primeras letras
    if (name.length >= 2) {
      return name.substring(0, 2).toUpperCase();
    }
    return name.toUpperCase();
  }
}