import 'ai_model.dart';

final List<AiModel> aiTools = [
  // Programación
  AiModel(
    name: "ChatGPT",
    description: "Modelo avanzado ideal para programación, redacción y asistencia general.",
    url: "https://chat.openai.com",
    tags: ["programacion", "codigo", "desarrollo", "texto", "trabajos", "ayuda", "general"],
  ),

  AiModel(
    name: "GitHub Copilot",
    description: "IA especializada en autocompletar código y ayudarte a programar más rápido.",
    url: "https://github.com/features/copilot",
    tags: ["programacion", "codigo", "github", "desarrollo"],
  ),

  AiModel(
    name: "Claude",
    description: "Gran modelo de lenguaje para tareas largas, análisis y resúmenes extensos.",
    url: "https://claude.ai",
    tags: ["texto", "resumenes", "trabajos", "programacion", "codigo"],
  ),

  AiModel(
    name: "Google Gemini",
    description: "IA de Google multimodal para texto, código, imágenes y análisis avanzado.",
    url: "https://gemini.google.com",
    tags: ["programacion", "codigo", "desarrollo", "texto", "imagenes", "general"],
  ),

  AiModel(
    name: "Amazon CodeWhisperer",
    description: "Herramienta de autocompletar código impulsada por IA de Amazon.",
    url: "https://aws.amazon.com/codewhisperer",
    tags: ["programacion", "codigo", "desarrollo"],
  ),

  // Diseño e Imágenes
  AiModel(
    name: "Midjourney",
    description: "Inteligencia artificial para generar imágenes artísticas y realistas.",
    url: "https://www.midjourney.com",
    tags: ["imagenes", "diseno", "arte", "creatividad"],
  ),

  AiModel(
    name: "DALL-E",
    description: "Generador de imágenes de OpenAI que crea imágenes desde descripciones de texto.",
    url: "https://openai.com/dall-e-3",
    tags: ["imagenes", "diseno", "arte", "creatividad"],
  ),

  AiModel(
    name: "Canva AI",
    description: "Generador de imágenes, textos, presentaciones y contenido automático.",
    url: "https://www.canva.com",
    tags: ["diseno", "presentaciones", "texto", "trabajos", "imagenes"],
  ),

  AiModel(
    name: "Stable Diffusion",
    description: "Modelo de difusión de texto a imagen de código abierto y gratuito.",
    url: "https://stablediffusionweb.com",
    tags: ["imagenes", "diseno", "arte", "creatividad"],
  ),

  AiModel(
    name: "Adobe Firefly",
    description: "Generador de imágenes y edición creativa integrado en Adobe Creative Cloud.",
    url: "https://www.adobe.com/products/firefly.html",
    tags: ["imagenes", "diseno", "arte", "creatividad"],
  ),

  // Investigación y Búsqueda
  AiModel(
    name: "Perplexity",
    description: "Buscador IA que responde con fuentes verificables para trabajos y estudios.",
    url: "https://www.perplexity.ai",
    tags: ["investigacion", "buscador", "trabajos", "aprendizaje"],
  ),

  AiModel(
    name: "You.com",
    description: "Buscador IA con privacidad y resultados personalizados.",
    url: "https://you.com",
    tags: ["investigacion", "buscador", "aprendizaje"],
  ),

  // Redacción y Contenido
  AiModel(
    name: "Jasper",
    description: "IA para crear contenido de marketing, blogs y artículos profesionales.",
    url: "https://www.jasper.ai",
    tags: ["texto", "redaccion", "trabajos", "contenido"],
  ),

  AiModel(
    name: "Copy.ai",
    description: "Generador de texto para copywriting, anuncios y contenido creativo.",
    url: "https://www.copy.ai",
    tags: ["texto", "redaccion", "trabajos", "contenido"],
  ),

  AiModel(
    name: "Grammarly",
    description: "Asistente de redacción que corrige gramática, ortografía y estilo.",
    url: "https://www.grammarly.com",
    tags: ["texto", "redaccion", "correccion"],
  ),

  // Audio y Voz
  AiModel(
    name: "Eleven Labs",
    description: "Generador de voz IA con múltiples idiomas y voces realistas.",
    url: "https://elevenlabs.io",
    tags: ["audio", "voz", "musica"],
  ),

  AiModel(
    name: "Descript",
    description: "Editor de video y podcast con transcripción y edición IA.",
    url: "https://www.descript.com",
    tags: ["audio", "video", "edicion"],
  ),

  // Productividad
  AiModel(
    name: "Notion AI",
    description: "IA integrada en Notion para ayudarte a escribir, resumir y organizar.",
    url: "https://www.notion.so",
    tags: ["trabajos", "productividad", "organizacion", "texto"],
  ),

  AiModel(
    name: "Microsoft Copilot",
    description: "Asistente IA integrado en Windows, Office y navegadores Microsoft.",
    url: "https://copilot.microsoft.com",
    tags: ["general", "trabajos", "productividad", "codigo"],
  ),

  // Video
  AiModel(
    name: "Synthesia",
    description: "Generador de videos con avatares IA y voces sintéticas.",
    url: "https://www.synthesia.io",
    tags: ["video", "creatividad", "presentaciones"],
  ),

  AiModel(
    name: "Runway ML",
    description: "Herramienta de edición de video con efectos IA y generación de contenido.",
    url: "https://runwayml.com",
    tags: ["video", "creatividad", "edicion"],
  ),

  // Aprendizaje
  AiModel(
    name: "Khan Academy",
    description: "Plataforma educativa con IA para aprendizaje personalizado.",
    url: "https://www.khanacademy.org",
    tags: ["aprendizaje", "educacion", "investigacion"],
  ),
];