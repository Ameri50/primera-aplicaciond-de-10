import 'package:flutter/material.dart';

class AiUtils {
  // Colores brillantes para los gradientes
  static const List<List<Color>> brightGradients = [
    [Color(0xFF10A37F), Color(0xFF1FB38D)], // ChatGPT - Verde
    [Color(0xFF2088FF), Color(0xFF4AA4FF)], // GitHub - Azul
    [Color(0xFFD97757), Color(0xFFE89474)], // Claude - Marrón
    [Color(0xFF4285F4), Color(0xFF669DF6)], // Google - Azul claro
    [Color(0xFFFF9900), Color(0xFFFFAD33)], // Amazon - Naranja
    [Color(0xFF9B59B6), Color(0xFFAF7AC5)], // Midjourney - Púrpura
    [Color(0xFFE74C3C), Color(0xFFEC7063)], // DALL-E - Rojo
    [Color(0xFF00C4CC), Color(0xFF33D1D8)], // Canva - Cyan
    [Color(0xFF3498DB), Color(0xFF5DADE2)], // Stable - Azul
    [Color(0xFFFF0050), Color(0xFFFF3366)], // Adobe - Rosa
    [Color(0xFF1FB6FF), Color(0xFF4DC4FF)], // Perplexity - Cyan
    [Color(0xFF7B68EE), Color(0xFF9B8AEE)], // You.com - Púrpura
    [Color(0xFFFF6B6B), Color(0xFFFF8787)], // Jasper - Rojo
    [Color(0xFF16A085), Color(0xFF1ABC9C)], // Copy.ai - Verde
    [Color(0xFF15C39A), Color(0xFF3BD5AE)], // Grammarly - Verde azul
    [Color(0xFFE67E22), Color(0xFFEB984E)], // Eleven Labs - Naranja
    [Color(0xFF8E44AD), Color(0xFFA569BD)], // Descript - Púrpura
    [Color(0xFF34495E), Color(0xFF5D6D7B)], // Notion - Gris oscuro
    [Color(0xFF0078D4), Color(0xFF33A3F4)], // Microsoft - Azul
    [Color(0xFFFF4757), Color(0xFFFF6B81)], // Synthesia - Rosa
    [Color(0xFF6C5CE7), Color(0xFF8B7AE7)], // Runway - Púrpura
    [Color(0xFF14BF96), Color(0xFF3DD5B5)], // Khan - Verde
  ];

  static List<Color> getGradientForAi(String name) {
    final lowerName = name.toLowerCase().trim();
    
    // Mapa de nombres a índices de colores
    final nameToIndex = {
      'chatgpt': 0,
      'github copilot': 1,
      'github': 1,
      'claude': 2,
      'google gemini': 3,
      'gemini': 3,
      'amazon codewhisperer': 4,
      'amazon': 4,
      'midjourney': 5,
      'dall-e': 6,
      'dalle': 6,
      'canva ai': 7,
      'canva': 7,
      'stable diffusion': 8,
      'stable': 8,
      'adobe firefly': 9,
      'adobe': 9,
      'firefly': 9,
      'perplexity': 10,
      'you.com': 11,
      'you': 11,
      'jasper': 12,
      'copy.ai': 13,
      'copy': 13,
      'grammarly': 14,
      'eleven labs': 15,
      'eleven': 15,
      'descript': 16,
      'notion ai': 17,
      'notion': 17,
      'microsoft copilot': 18,
      'microsoft': 18,
      'synthesia': 19,
      'runway ml': 20,
      'runway': 20,
      'khan academy': 21,
      'khan': 21,
    };

    // Busca coincidencia exacta primero
    if (nameToIndex.containsKey(lowerName)) {
      return brightGradients[nameToIndex[lowerName]!];
    }

    // Busca por palabras clave
    for (var key in nameToIndex.keys) {
      if (lowerName.contains(key) || key.contains(lowerName)) {
        return brightGradients[nameToIndex[key]!];
      }
    }

    // Por defecto, genera un color basado en el nombre
    return _generateGradientFromName(name);
  }

  static List<Color> _generateGradientFromName(String name) {
    final hash = name.hashCode.abs();
    return brightGradients[hash % brightGradients.length];
  }

  static String getInitialsForAi(String name) {
    const initials = {
      'chatgpt': 'GP',
      'github copilot': 'CP',
      'github': 'GH',
      'claude': 'CL',
      'google gemini': 'GM',
      'gemini': 'GM',
      'amazon codewhisperer': 'CW',
      'amazon': 'AZ',
      'midjourney': 'MJ',
      'dall-e': 'DE',
      'dalle': 'DE',
      'canva ai': 'CA',
      'canva': 'CA',
      'stable diffusion': 'SD',
      'stable': 'SD',
      'adobe firefly': 'AF',
      'adobe': 'AB',
      'firefly': 'FF',
      'perplexity': 'PX',
      'you.com': 'YC',
      'you': 'YO',
      'jasper': 'JS',
      'copy.ai': 'CP',
      'copy': 'CP',
      'grammarly': 'GR',
      'eleven labs': 'EL',
      'eleven': 'EL',
      'descript': 'DS',
      'notion ai': 'NA',
      'notion': 'NO',
      'microsoft copilot': 'MC',
      'microsoft': 'MS',
      'synthesia': 'SY',
      'runway ml': 'RM',
      'runway': 'RW',
      'khan academy': 'KA',
      'khan': 'KH',
    };

    final lowerName = name.toLowerCase().trim();
    
    // Busca coincidencia exacta
    if (initials.containsKey(lowerName)) {
      return initials[lowerName]!;
    }

    // Busca por palabras clave
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