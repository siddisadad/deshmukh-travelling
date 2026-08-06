import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../providers/hajj_providers.dart';
import '../widgets/timeline_itinerary.dart';

class PackageDetailsScreen extends ConsumerWidget {
  final String packageId;

  const PackageDetailsScreen({super.key, required this.packageId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageAsync = ref.watch(hajjPackageDetailsProvider(packageId));

    return packageAsync.when(
      data: (package) {
        if (package == null) {
          return const Scaffold(body: Center(child: Text('Package not found')));
        }
        return Scaffold(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: FlutterFlowTheme.of(context).primary,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withValues(alpha: 0.2),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(package.title, style: const TextStyle(fontSize: 16, color: Colors.white)),
                  background: Hero(
                    tag: 'package_${package.id}',
                    child: Image.network(
                      package.images.isNotEmpty
                          ? package.images[0]
                          : 'https://images.unsplash.com/photo-1564767609342-620cb19b2357',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              package.duration,
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '\$${package.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD4AF37),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'About Package',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        package.description,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Accommodation',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildHotelCard(context, 'Makkah', package.makkahHotel ?? 'Information not available', Icons.location_on),
                      const SizedBox(height: 12),
                      _buildHotelCard(context, 'Madinah', package.madinahHotel ?? 'Information not available', Icons.location_on),
                      const SizedBox(height: 32),
                      Text(
                        'Itinerary',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TimelineItinerary(itinerary: package.itinerary),
                      const SizedBox(height: 100), // Space for bottom button
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                ref.read(selectedPackageProvider.notifier).state = package;
                context.pushNamed(
                  'HajjBooking',
                  extra: <String, dynamic>{
                    'package': package,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text(
                'BOOK NOW',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
    );
  }

  Widget _buildHotelCard(BuildContext context, String city, String hotelName, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.hotel, color: Color(0xFFD4AF37)),
        ),
        title: Text(city, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(hotelName),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
