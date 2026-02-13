import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/helper/navigation/push_to.dart';
import '../../../../../utils/resources/app_colors.dart';
import '../../cubit/addresses_cubit.dart';
import '../../cubit/addresses_state.dart';
import '../add_address_screen.dart';
import '../widgets/address_card.dart';
import '../widgets/address_card_shimmer.dart';

class AddressesDialog extends StatefulWidget {
  const AddressesDialog({super.key});

  @override
  State<AddressesDialog> createState() => _AddressesDialogState();
}

class _AddressesDialogState extends State<AddressesDialog> {
  @override
  void initState() {
    super.initState();
    context.read<AddressesCubit>().loadAddresses();
  }

  void _addAddress() {
    pushTo(context, const AddAddressScreen(add: true));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,

        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: const BoxDecoration(
            color: kScaffoldBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              /// HEADER
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  children: [
                    Text(
                      'عناوين التوصيل',
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: _addAddress,
                      icon: const Icon(
                        Icons.add_circle,
                        color: kMainColor,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              /// CONTENT
              Expanded(
                child: BlocBuilder<AddressesCubit, AddressesState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case AddressesStatus.initial:
                        return const SizedBox();

                      case AddressesStatus.loading:
                        return ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: 4,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (_, __) => const AddressCardShimmer(),
                        );

                      case AddressesStatus.error:
                        return _ErrorState(
                          message:
                              state.errorMessage ?? 'حدث خطأ أثناء التحميل',
                          onRetry: () =>
                              context.read<AddressesCubit>().loadAddresses(),
                        );

                      case AddressesStatus.loaded:
                        if (state.addresses.isEmpty) {
                          return Center(
                            child: Text(
                              'لا توجد عناوين محفوظة',
                              style: GoogleFonts.cairo(
                                fontSize: 14,
                                color: kSubtitleColor,
                              ),
                            ),
                          );
                        }

                        return ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.addresses.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return AddressCard(address: state.addresses[index]);
                          },
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ================= ERROR UI =================

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_off_outlined, size: 48, color: kTitleGreyColor),
          const SizedBox(height: 12),
          Text(
            message,
            style: GoogleFonts.cairo(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: kMainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'إعادة المحاولة',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
