import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/screens/checkout/success_dialog.dart';
import 'package:moona/utils/resources/app_colors.dart';

import '../../managers/server/cart/cart_api.dart';
import '../../managers/server/checkout_api.dart';
import '../addresses/data/entities/address_entity.dart';
import '../addresses/presentation/cubit/addresses_cubit.dart';
import '../addresses/presentation/cubit/addresses_state.dart';
import '../addresses/presentation/screens/dialog/addresses_dialog.dart';
import '../addresses/presentation/screens/widgets/address_card_shimmer.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedPayment = 0;
  bool checkoutLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<AddressesCubit>().loadAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kScaffoldBackground,
        appBar: AppBar(
          title: const Text(
            'إتمام الطلب',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const _SectionTitle(
                      title: 'ملخص الطلب',
                      icon: Icons.receipt_long,
                    ),
                    FutureBuilder<CartSummury>(
                      future: CartApi.summary(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                            height: 120,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (!snapshot.hasData) {
                          return const SizedBox();
                        }

                        return OrderSummaryCard(summary: snapshot.data!);
                      },
                    ),

                    const SizedBox(height: 20),

                    const _SectionTitle(
                      title: 'عنوان التوصيل',
                      icon: Icons.location_on_outlined,
                    ),

                    BlocBuilder<AddressesCubit, AddressesState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case AddressesStatus.initial:
                            return const SizedBox();

                          case AddressesStatus.loading:
                            return const AddressCardShimmer();

                          case AddressesStatus.error:
                            return _ErrorBox(
                              message: state.errorMessage ?? 'حدث خطأ',
                            );

                          case AddressesStatus.loaded:
                            if (state.addresses.isEmpty) {
                              return _InfoBox(
                                icon: Icons.location_off_outlined,
                                text: 'لا يوجد عناوين مسجلة',
                                actionText: 'إضافة عنوان',
                                onTap: () {},
                              );
                            }

                            /// ✅ نختار الافتراضي
                            final AddressEntity selectedAddress = state
                                .addresses
                                .firstWhere(
                                  (e) => e.isDefault,
                                  orElse: () => state.addresses.first,
                                );

                            return DeliveryLocationCard(
                              address: selectedAddress,
                              onChange: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddressesDialog();
                                  },
                                );
                              },
                            );
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    const _SectionTitle(
                      title: 'طريقة الدفع',
                      icon: Icons.credit_card,
                    ),

                    const PaymentMethods(),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: kMainColor.withOpacity(0.18),
                      blurRadius: 18,
                      offset: const Offset(0, -8),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: checkoutLoading
                        ? null
                        : () async {
                            final state = context.read<AddressesCubit>().state;

                            if (state.status != AddressesStatus.loaded ||
                                state.addresses.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('الرجاء اختيار عنوان'),
                                ),
                              );
                              return;
                            }

                            final selectedAddress = state.addresses.firstWhere(
                              (e) => e.isDefault,
                              orElse: () => state.addresses.first,
                            );

                            setState(() => checkoutLoading = true);

                            try {
                              final orderId = await CheckoutApi.checkout(
                                addressId: selectedAddress.id,
                                paymentMethod: 'moyaser',
                              );

                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                "main",
                                (route) => false,
                              );
                              showDialog(
                                context: context,
                                builder: (_) => SuccessDialog(orderId: orderId),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            } finally {
                              setState(() => checkoutLoading = false);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kMainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: checkoutLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'تأكيد الطلب',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ===================== ORDER SUMMARY =====================

class OrderSummaryCard extends StatelessWidget {
  final CartSummury summary;

  const OrderSummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        children: [
          _SummaryRow('عدد المنتجات', summary.totalItems.toString()),

          const SizedBox(height: 10),

          _SummaryRow('سعر المنتجات', '${summary.productsTotal} ﷼'),

          const SizedBox(height: 10),

          _SummaryRow(
            'رسوم التوصيل',
            summary.deliveryFee == 0
                ? 'توصيل محاني'
                : '${summary.deliveryFee} ﷼',
          ),

          if (summary.discountTotal > 0) ...[
            const SizedBox(height: 10),
            _SummaryRow('الخصم', '- ${summary.discountTotal} ﷼'),
          ],

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),

          _SummaryRow(
            'الإجمالي',
            '${summary.grandTotal} ﷼',
            bold: true,
            highlight: true,
          ),
        ],
      ),
    );
  }
}

/// ===================== DELIVERY LOCATION =====================

class DeliveryLocationCard extends StatelessWidget {
  final AddressEntity address;
  final VoidCallback? onChange;

  const DeliveryLocationCard({super.key, required this.address, this.onChange});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: kMainColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.location_on_outlined, color: kMainColor),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// addressName عندك بدل title
                Text(
                  address.addressName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 4),

                /// نبني عنوان كامل احترافي
                Text(
                  _buildFullAddress(address),
                  style: const TextStyle(fontSize: 13, color: kSubtitleColor),
                ),
              ],
            ),
          ),

          TextButton(
            onPressed: onChange,
            child: const Text('تغيير', style: TextStyle(color: kMainColor)),
          ),
        ],
      ),
    );
  }

  String _buildFullAddress(AddressEntity a) {
    List<String> parts = [];

    parts.add(a.locationName);

    if (a.buildingName != null && a.buildingName!.isNotEmpty) {
      parts.add(a.buildingName!);
    }

    if (a.floor != null && a.floor!.isNotEmpty) {
      parts.add('الدور ${a.floor}');
    }

    return parts.join('، ');
  }
}

/// ===================== PAYMENT METHODS =====================
class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        children: [
          _PaymentGatewayTile(
            title: 'بطاقة ائتمان / خصم',
            subtitle: 'Visa • MasterCard',
            logos: const [
              _PaymentLogo(
                'https://upload.wikimedia.org/wikipedia/commons/4/41/Visa_Logo.png',
              ),
              _PaymentLogo(
                'https://upload.wikimedia.org/wikipedia/commons/2/2a/Mastercard-logo.svg',
                isSvg: true,
              ),
            ],
            selected: selected == 0,
            onTap: () => setState(() => selected = 0),
          ),

          const SizedBox(height: 14),

          _PaymentGatewayTile(
            title: 'Apple Pay / Google Pay',
            subtitle: 'دفع سريع وآمن',
            logos: const [
              _PaymentLogo(
                'https://upload.wikimedia.org/wikipedia/commons/b/b0/Apple_Pay_logo.svg',
                isSvg: true,
              ),
              _PaymentLogo(
                'https://upload.wikimedia.org/wikipedia/commons/f/f2/Google_Pay_Logo.svg',
                isSvg: true,
              ),
            ],
            selected: selected == 1,
            onTap: () => setState(() => selected = 1),
          ),
        ],
      ),
    );
  }
}

class _PaymentGatewayTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<_PaymentLogo> logos;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentGatewayTile({
    required this.title,
    required this.subtitle,
    required this.logos,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? kMainColor : kBorderNeutralColor,
            width: selected ? 1.6 : 1,
          ),
          color: selected ? kMainColor.withOpacity(0.04) : Colors.transparent,
        ),
        child: Row(
          children: [
            // LOGOS
            Row(
              children: logos
                  .map(
                    (logo) => Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: logo,
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(width: 12),

            // TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: kSubtitleColor),
                  ),
                ],
              ),
            ),

            // RADIO
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? kMainColor : kTitleGreyColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentLogo extends StatelessWidget {
  final String url;
  final bool isSvg;

  const _PaymentLogo(this.url, {this.isSvg = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: kBorderOverlayColor),
      ),
      child: isSvg
          ? SvgPicture.network(url)
          : Image.network(url, fit: BoxFit.contain),
    );
  }
}

/// ===================== SHARED UI =====================

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionTitle({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: kMainColor, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: kMainColor.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  final bool highlight;

  const _SummaryRow(
    this.label,
    this.value, {
    this.bold = false,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          value,
          style: TextStyle(
            fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
            color: highlight ? kMainColor : kTitleBodyColor,
            fontSize: highlight ? 16 : 14,
          ),
        ),
      ],
    );
  }
}

class _ErrorBox extends StatelessWidget {
  const _ErrorBox({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: Colors.red.shade700,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({
    required this.icon,
    required this.text,
    required this.onTap,
    required this.actionText,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: kMainColor.withOpacity(0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: kMainColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: kMainColor.withOpacity(0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                actionText,
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  color: kMainColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
