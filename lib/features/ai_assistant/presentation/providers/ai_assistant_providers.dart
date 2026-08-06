import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/chat_message.dart';
import '../../domain/ai_repository.dart';
import '../../data/ai_repository_impl.dart';

part 'ai_assistant_providers.g.dart';

@riverpod
AiRepository aiRepository(AiRepositoryRef ref) {
  /// The Gemini API Key is passed via --dart-define=GEMINI_API_KEY=your_key
  const apiKey = String.fromEnvironment('GEMINI_API_KEY');
  return AiRepositoryImpl(apiKey);
}

@riverpod
class ChatHistory extends _$ChatHistory {
  @override
  List<ChatMessage> build() {
    return [
      ChatMessage(
        text: "Hello! I'm your AI Travel Assistant. How can I help you plan your journey today?",
        isAi: true,
        timestamp: DateTime.now(),
      ),
    ];
  }

  void addMessage(String text, bool isAi) {
    state = [
      ...state,
      ChatMessage(
        text: text,
        isAi: isAi,
        timestamp: DateTime.now(),
      ),
    ];
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    addMessage(text, false);

    try {
      final repository = ref.read(aiRepositoryProvider);
      final response = await repository.getAiResponse(text, state.sublist(0, state.length - 1));
      addMessage(response, true);
    } catch (e) {
      addMessage("Sorry, I encountered an error: $e", true);
    }
  }
}
