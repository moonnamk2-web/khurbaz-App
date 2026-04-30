import 'package:flutter/material.dart';
import 'package:moona/screens/checkout/success_dialog.dart';
import 'package:moyasar/moyasar.dart';

import '../../managers/server/payment_service.dart';
import '../addresses/data/entities/address_entity.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog({
    super.key,
    required this.amount,
    required this.selectedAddress,
    required this.executionTime,
  });

  final double amount;
  final DateTime? executionTime;
  final AddressEntity selectedAddress;

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  late final paymentConfig = PaymentConfig(
    publishableApiKey: 'pk_live_8eupn7AcS3FneiZkE9SWNXmVgjH3684FNhUZEuNY',
    amount: (widget.amount * 100).toInt(),
    description: 'khurbaz Order',
    creditCard: CreditCardConfig(saveCard: true, manual: false),
    applePay: ApplePayConfig(
      merchantId: 'merchant.com.khurbaz',
      label: 'khurbaz',
      manual: false,
      saveCard: true,
    ),
  );

  void showFail(String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: Text(text)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void onPaid(PaymentResponse result) async {
    String moyasarId = result.id;
    String paymentMethod = "";

    try {
      paymentMethod = result.source.company ?? "online";
    } catch (e) {
      paymentMethod = "online";
    }
    final paymentService = PaymentService();

    final response = await paymentService.checkout(
      executionTime: widget.executionTime,
      moyasarId: moyasarId,
      paymentMethod: paymentMethod,
      addressId: widget.selectedAddress.id.toString(),
    );
    if (!response['success']) {
      showFail(response.toString());
    } else {
      Navigator.pushNamedAndRemoveUntil(context, "main", (route) => false);

      showDialog(
        context: context,
        builder: (_) => SuccessDialog(orderId: response['order_id']),
      );
    }
    print("Checkout Response: $response");
  }

  void onPaymentResult(dynamic result) async {
    if (result is PaymentResponse) {
      if (result.status == PaymentStatus.paid) {
        onPaid(result);
      } else if (result.status == PaymentStatus.failed) {
        print("❌ Payment FAILED");
        showFail('❌ Payment FAILED');
      } else if (result.status == PaymentStatus.initiated) {
        print("⏳ Payment INITIATED");
        showFail("🔐 Payment AUTHORIZED }");
      } else if (result.status == PaymentStatus.authorized) {
        print("🔐 Payment AUTHORIZED");
        showFail("🔐 Payment AUTHORIZED }");
      } else {
        print("⚠️ Unknown Status: ${result.status}");
        showFail("⚠️ Unknown Status: ${result.status}");
      }
    } else if (result is PaymentCanceledError) {
      print("🔥 Unexpected result: message ${result.message}");
      showFail('🔥 Unexpected result: ${result.message}');
    } else {
      print("🔥 Unexpected result: $result");
      showFail('🔥 Unexpected result: $result');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "اختر طريقة الدفع",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              CreditCard(
                config: paymentConfig,
                onPaymentResult: onPaymentResult,
                locale: Localization.ar(),
              ),
              ApplePay(config: paymentConfig, onPaymentResult: onPaymentResult),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("إلغاء"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
