class ChatMessage {
  final String text;
  final bool isAi;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isAi,
    required this.timestamp,
  });
}
