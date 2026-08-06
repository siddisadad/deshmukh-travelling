import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../backend/schema/review_record.dart';

class ReviewsList extends StatelessWidget {
  final List<ReviewRecord> reviews;

  const ReviewsList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return Center(
        child: Text(
          'No reviews yet',
          style: AppTypography.labelSmall,
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      separatorBuilder: (_, __) => const Divider(height: AppSpacing.xl),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(review.userImage.isEmpty
                      ? 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100&q=80'
                      : review.userImage),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: AppTypography.titleSmall,
                      ),
                      Text(
                        DateFormat('d MMM yyyy').format(review.createdAt),
                        style: AppTypography.labelSmall,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: i < review.rating
                          ? AppColors.warning
                          : AppColors.alternate,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              review.comment,
              style: AppTypography.bodySmall,
            ),
          ],
        );
      },
    );
  }
}
