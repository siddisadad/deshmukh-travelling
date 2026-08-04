import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class AiSearchSuggestions extends StatelessWidget {
  final List<String> suggestions;
  final Function(String) onSelected;

  const AiSearchSuggestions({super.key, required this.suggestions, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 8, color: Color(0x1A000000), offset: Offset(0, 4))],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.auto_awesome, color: FlutterFlowTheme.of(context).primary, size: 18),
            title: Text(suggestions[index], style: FlutterFlowTheme.of(context).bodyMedium),
            onTap: () => onSelected(suggestions[index]),
          );
        },
      ),
    );
  }
}
