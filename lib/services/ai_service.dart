abstract class AiService {
  Future<String> send(String prompt);
}

class MockAiService implements AiService {
  @override
  Future<String> send(String prompt) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return "🔧 Modo demo (sin API):\n\nTu mensaje fue:\n“$prompt”\n\nSugerencia: conecta tu OPENAI_API_KEY en .env para respuestas reales.";
  }
}
