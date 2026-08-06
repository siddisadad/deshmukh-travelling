import 'package:google_generative_ai/google_generative_ai.dart';
import '../domain/ai_repository.dart';
import '../domain/chat_message.dart';

class AiRepositoryImpl implements AiRepository {
  final GenerativeModel _model;

  AiRepositoryImpl(String apiKey)
      : _model = GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: apiKey,
          generationConfig: GenerationConfig(
            temperature: 0.7,
            topK: 40,
            topP: 0.95,
            maxOutputTokens: 1024,
          ),
        );

  @override
  Future<String> getAiResponse(String message, List<ChatMessage> history) async {
    final chat = _model.startChat(
      history: history.map((m) {
        return m.isAi
            ? Content.model([TextPart(m.text)])
            : Content('user', [TextPart(m.text)]);
      }).toList(),
    );

    final response = await chat.sendMessage(Content.text(message));
    return response.text ?? "I'm sorry, I couldn't process that request.";
  }
}
