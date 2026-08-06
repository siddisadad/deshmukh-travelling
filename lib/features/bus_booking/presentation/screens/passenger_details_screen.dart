import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/tokens.dart';
import '../../../../core/design_system/components/app_button.dart';
import '../../../../core/design_system/components/app_text_field.dart';
import '../../../../core/design_system/components/app_card.dart';
import '../../../../components/app_header.dart';
import '../../../../backend/schema/booking_record.dart';
import '../providers/booking_providers.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'payment_checkout_screen.dart';

class PassengerDetailsScreen extends ConsumerStatefulWidget {
  const PassengerDetailsScreen({super.key});

  static String routeName = 'PassengerDetails';
  static String routePath = '/passengerDetails';

  @override
  ConsumerState<PassengerDetailsScreen> createState() => _PassengerDetailsScreenState();
}

class _PassengerDetailsScreenState extends ConsumerState<PassengerDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late List<TextEditingController> _nameControllers;
  late List<TextEditingController> _ageControllers;
  late List<String> _genders;

  @override
  void initState() {
    super.initState();
    final bookingState = ref.read(bookingFlowProvider);
    final numSeats = bookingState.selectedSeats.length;
    _nameControllers = List.generate(numSeats, (_) => TextEditingController());
    _ageControllers = List.generate(numSeats, (_) => TextEditingController());
    _genders = List.generate(numSeats, (_) => 'Male');
  }

  @override
  void dispose() {
    for (var c in _nameControllers) {
      c.dispose();
    }
    for (var c in _ageControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingFlowProvider);
    final bus = bookingState.selectedBus;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          AppHeader(
            title: AppLocalizations.of(context)!.passengerDetails,
            onBackPress: () => context.pop(),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  _buildBusSummary(bus, bookingState),
                  const SizedBox(height: AppSpacing.lg),
                  for (int i = 0; i < bookingState.selectedSeats.length; i++) ...[
                    _buildPassengerForm(i, bookingState.selectedSeats[i]),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ],
              ),
            ),
          ),
          _buildBottomBar(context, bookingState),
        ],
      ),
    );
  }

  Widget _buildBusSummary(bus, bookingState) {
    return AppCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${bus.departureCity.split(',').first} → ${bus.arrivalCity.split(',').first}', style: AppTypography.titleMedium),
              Text(bus.name, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          Text('₹${bookingState.totalAmount.toInt()}', style: AppTypography.titleMedium.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }

  Widget _buildPassengerForm(int index, String seat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Passenger ${index + 1} (Seat $seat)', style: AppTypography.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          child: Column(
            children: [
              AppTextField(
                controller: _nameControllers[index],
                label: 'Full Name',
                hintText: 'Enter name',
                validator: (v) => v?.isEmpty ?? true ? 'Name required' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _ageControllers[index],
                      label: 'Age',
                      hintText: 'Age',
                      keyboardType: TextInputType.number,
                      validator: (v) => v?.isEmpty ?? true ? 'Age required' : null,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Gender', style: AppTypography.labelMedium),
                        const SizedBox(height: AppSpacing.xs),
                        DropdownButtonFormField<String>(
                          initialValue: _genders[index],
                          items: ['Male', 'Female', 'Other'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                          onChanged: (val) => setState(() => _genders[index] = val!),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 12),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: const BorderSide(color: AppColors.alternate)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.md), borderSide: const BorderSide(color: AppColors.alternate)),
                            filled: true,
                            fillColor: AppColors.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, bookingState) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(color: AppColors.surface, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: SafeArea(
        child: AppButton(
          text: AppLocalizations.of(context)!.proceedToPayment,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final passengers = List.generate(
                _nameControllers.length,
                (i) => Passenger(
                  name: _nameControllers[i].text,
                  age: int.parse(_ageControllers[i].text),
                  gender: _genders[i],
                ),
              );
              ref.read(bookingFlowProvider.notifier).updatePassengers(passengers);
              context.pushNamed(PaymentCheckoutScreen.routeName);
            }
          },
        ),
      ),
    );
  }
}

