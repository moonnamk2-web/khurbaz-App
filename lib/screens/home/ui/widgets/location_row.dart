import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/resources/app_colors.dart';
import '../../../addresses/presentation/cubit/addresses_cubit.dart';
import '../../../addresses/presentation/cubit/addresses_state.dart';
import '../../../addresses/presentation/screens/dialog/addresses_dialog.dart';

class LocationRow extends StatelessWidget {
  const LocationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return AddressesDialog();
            },
          );
        },
        child: ColoredBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: kSubtitleColor,
                ),
                SizedBox(width: 6),
                Expanded(
                  child: BlocBuilder<AddressesCubit, AddressesState>(
                    builder: (context, state) {
                      switch (state.status) {
                        // =========================
                        // Loading
                        // =========================
                        case AddressesStatus.loading:
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: 10,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: 10,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          );

                        // =========================
                        // Loaded
                        // =========================
                        case AddressesStatus.loaded:
                          final address = state.addresses.isNotEmpty
                              ? state.addresses.first
                              : null;

                          return SizedBox(
                            height: 40,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  address == null
                                      ? 'إضافة عنوان'
                                      : address.addressName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                if (address != null)
                                  Text(
                                    address.locationName,
                                    style: const TextStyle(
                                      height: 1,
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                              ],
                            ),
                          );

                        // =========================
                        // Error
                        // =========================
                        case AddressesStatus.error:
                          return const SizedBox.shrink();

                        // =========================
                        // Initial
                        // =========================
                        case AddressesStatus.initial:
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: kSubtitleColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
