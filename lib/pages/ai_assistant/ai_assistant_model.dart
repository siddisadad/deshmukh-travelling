import '/flutter_flow/flutter_flow_util.dart';
import 'ai_assistant_widget.dart' show AiAssistantWidget;
import 'package:flutter/material.dart';

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

class AiAssistantModel extends FlutterFlowModel<AiAssistantWidget> {
  ///  State fields for stateful widgets in this page.
  final unfocusNode = FocusNode();

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  List<ChatMessage> messages = [];

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    messages.add(ChatMessage(
      text: text,
      isAi: false,
      timestamp: DateTime.now(),
    ));

    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      messages.add(ChatMessage(
        text: _getAiResponse(text),
        isAi: true,
        timestamp: DateTime.now(),
      ));
      // In a real app, you'd trigger a notifyListeners or similar here.
      // Since this is a model for a widget, the widget will handle safeSetState.
    });
  }

  String _getAiResponse(String input) {
    final lowerInput = input.toLowerCase();
    if (lowerInput.contains('bus')) {
      return "I can help you find the best bus routes! Where would you like to go?";
    } else if (lowerInput.contains('hotel')) {
      return "Looking for a stay? I can suggest premium hotels with great discounts.";
    } else if (lowerInput.contains('taxi') || lowerInput.contains('cab')) {
      return "Need a ride? I can arrange a taxi for your local or outstation travel.";
    } else if (lowerInput.contains('holiday') || lowerInput.contains('package')) {
      return "Planning a vacation? Check out our curated holiday packages for Goa and Manali.";
    } else {
      return "I'm your travel assistant. How can I help you plan your next trip today?";
    }
  }

  @override
  void initState(BuildContext context) {
    messages.add(ChatMessage(
      text: "Hello! I'm your AI Travel Assistant. How can I help you plan your journey today?",
      isAi: true,
      timestamp: DateTime.now(),
    ));
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
