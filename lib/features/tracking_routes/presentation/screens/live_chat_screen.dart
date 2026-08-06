import 'package:flutter/material.dart';
import '../../../../components/app_header.dart';
import '../../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';

class Message {
  final String text;
  final bool isMe;
  Message(this.text, this.isMe);
}

class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen({super.key});

  static String routeName = 'LiveChat';
  static String routePath = '/liveChat';

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  final List<Message> _messages = [
    Message("Hello, I'm at the pickup point.", true),
    Message("Okay, I'll be there in 5 minutes.", false),
  ];
  final TextEditingController _textController = TextEditingController();

  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _messages.add(Message(_textController.text, true));
        _textController.clear();
      });

      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _messages.add(Message("Understood, I'll take care of that.", false));
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          AppHeader(
            title: 'Suresh Patil',
            bottom: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
              child: Row(
                children: [
                  Icon(Icons.directions_bus_rounded, size: 14, color: FlutterFlowTheme.of(context).secondaryText),
                  const SizedBox(width: 8),
                  Text(
                    'Bus Captain • MH-12-AS-1234',
                    style: FlutterFlowTheme.of(context).bodySmall,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      reverse: true,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[_messages.length - 1 - index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              Container(
                                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: message.isMe ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).secondaryBackground,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  message.text,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Outfit',
                                    color: message.isMe ? Colors.white : FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _textController,
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0), borderSide: BorderSide.none),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context).primaryBackground,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            onFieldSubmitted: (_) => _sendMessage(),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          buttonSize: 48.0,
                          fillColor: FlutterFlowTheme.of(context).primary,
                          icon: const Icon(Icons.send_rounded, color: Colors.white, size: 24.0),
                          onPressed: _sendMessage,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
