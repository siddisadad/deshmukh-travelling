import 'chat_message.dart';

abstract class AiRepository {
  Future<String> getAiResponse(String message, List<ChatMessage> history);
}
