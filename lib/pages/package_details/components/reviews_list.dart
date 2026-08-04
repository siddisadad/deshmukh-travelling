import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../../backend/schema/review_record.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewsList extends StatelessWidget {
  final List<ReviewRecord> reviews;

  const ReviewsList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return Center(child: Text('No reviews yet', style: FlutterFlowTheme.of(context).labelSmall));
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      separatorBuilder: (_, __) => const Divider(height: 32),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(review.userImage.isEmpty ? 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100&q=80' : review.userImage),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review.userName, style: FlutterFlowTheme.of(context).bodyMedium.override(font: GoogleFonts.inter(fontWeight: FontWeight.bold))),
                      Text(dateTimeFormat('d MMM yyyy', review.createdAt), style: FlutterFlowTheme.of(context).labelSmall),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(5, (i) => Icon(
                    Icons.star_rounded,
                    size: 16,
                    color: i < review.rating ? FlutterFlowTheme.of(context).warning : FlutterFlowTheme.of(context).alternate,
                  )),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(review.comment, style: FlutterFlowTheme.of(context).bodySmall),
          ],
        );
      },
    );
  }
}
