import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/resources/app_colors.dart';
import '../../../data/entities/address_entity.dart';
import '../../cubit/addresses_cubit.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.address});

  final AddressEntity address;

  @override
  Widget build(BuildContext context) {
    final bool isDefault = address.isDefault;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        context.read<AddressesCubit>().setDefault(id: address.id);
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// LEFT INDICATOR
            Container(
              width: 4,
              height: 72,
              decoration: BoxDecoration(
                color: isDefault ? kMainColor : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            const SizedBox(width: 12),

            /// ICON
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: kMainColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_on_outlined,
                color: kMainColor,
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            /// ADDRESS INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE + DEFAULT BADGE
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          address.addressName,
                          style: TextStyle(
                            fontFamily: 'DINNextLT',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// LOCATION
                  Row(
                    children: [
                      Icon(
                        Icons.place_outlined,
                        size: 16,
                        color: kTitleGreyColor,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          address.locationName,
                          style: TextStyle(
                            fontFamily: 'DINNextLT',
                            fontSize: 14,
                            color: kTitleBodyLightColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// RECEIVER
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 16,
                        color: kTitleGreyColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        address.receiverName,
                        style: TextStyle(
                          fontFamily: 'DINNextLT',
                          fontSize: 13,
                          color: kTitleGreyColor,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '• ${address.phoneNumber}',
                        style: TextStyle(
                          fontFamily: 'DINNextLT',
                          fontSize: 13,
                          color: kTitleGreyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// CHECK ICON
            Icon(
              isDefault ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isDefault ? kMainColor : kTitleGreyColor,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
