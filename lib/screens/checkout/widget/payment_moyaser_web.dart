import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../managers/server/payment_service.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String checkoutUrl;
  final int paymentId;
  final DateTime? executionTime;

  const PaymentWebViewScreen({
    super.key,
    required this.executionTime,
    required this.checkoutUrl,
    required this.paymentId,
  });

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late InAppWebViewController webViewController;
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.cancel_outlined),
          ),
          centerTitle: true,
          title: Text("إتمام الدفع", style: GoogleFonts.cairo(fontSize: 20)),
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.checkoutUrl)),
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                final uri = navigationAction.request.url;
                final url = uri?.toString() ?? '';

                print("========= NAVIGATION: $url");

                if (url.contains("payment-success")) {
                  final parsed = Uri.parse(url);

                  final paymentMoyasarId = parsed.queryParameters['id'];
                  final paymentLocalId = widget.paymentId;

                  Map<String, dynamic> result;
                  result = await PaymentService().verifyPayment(
                    executionTime: widget.executionTime,
                    paymentLocalId: paymentLocalId,
                    paymentMoyasarId: paymentMoyasarId!,
                  );
                  if (!result['success']) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            Center(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Center(child: Text(result.toString())),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "main",
                      (route) => false,
                    );
                  }

                  if (!mounted) return NavigationActionPolicy.CANCEL;

                  return NavigationActionPolicy.CANCEL;
                }

                return NavigationActionPolicy.ALLOW;
              },

              onLoadStop: (controller, url) {
                print("onLoadStop: $url");
              },
            ),

            //  if (loading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
