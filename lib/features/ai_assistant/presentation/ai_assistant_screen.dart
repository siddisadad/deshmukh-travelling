import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import 'providers/ai_assistant_providers.dart';

class AiAssistantScreen extends ConsumerStatefulWidget {
  const AiAssistantScreen({super.key});

  static String routeName = 'AiAssistant';
  static String routePath = '/aiAssistant';

  @override
  ConsumerState<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends ConsumerState<AiAssistantScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _textFieldFocusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatHistoryProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'AI Travel Assistant',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.plusJakartaSans(),
                  color: Colors.white,
                  fontSize: 22,
                ),
          ),
          elevation: 2,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: messages.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Align(
                        alignment: message.isAi
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: message.isAi
                                ? FlutterFlowTheme.of(context).secondaryBackground
                                : FlutterFlowTheme.of(context).primary,
                            borderRadius: BorderRadius.circular(16).copyWith(
                              bottomLeft: message.isAi ? const Radius.circular(0) : null,
                              bottomRight: !message.isAi ? const Radius.circular(0) : null,
                            ),
                            boxShadow: [
                              FlutterFlowTheme.of(context).designToken.shadow.xs
                            ],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.text,
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.inter(),
                                      color: message.isAi
                                          ? FlutterFlowTheme.of(context).primaryText
                                          : Colors.white,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                dateTimeFormat('jm', message.timestamp),
                                style: FlutterFlowTheme.of(context).labelSmall.override(
                                      font: GoogleFonts.inter(),
                                      fontSize: 10,
                                      color: message.isAi
                                          ? FlutterFlowTheme.of(context).secondaryText
                                          : Colors.white.withValues(alpha: 0.7),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              _buildInputArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          const BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, -2),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _textController,
                focusNode: _textFieldFocusNode,
                decoration: InputDecoration(
                  hintText: 'Ask me anything...',
                  hintStyle: FlutterFlowTheme.of(context).labelMedium,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                style: FlutterFlowTheme.of(context).bodyMedium,
                maxLines: null,
              ),
            ),
            const SizedBox(width: 8),
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 50,
              fillColor: FlutterFlowTheme.of(context).primary,
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () async {
                final text = _textController.text;
                if (text.isNotEmpty) {
                  _textController.clear();
                  await ref.read(chatHistoryProvider.notifier).sendMessage(text);
                  _scrollToBottom();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
