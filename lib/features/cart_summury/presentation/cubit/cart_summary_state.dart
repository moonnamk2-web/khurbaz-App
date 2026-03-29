import '../../../../managers/server/cart/cart_api.dart';

class CartSummaryState {
  final bool loading;
  final CartSummury? summary;
  final String? error;

  CartSummaryState({this.loading = false, this.summary, this.error});

  CartSummaryState copyWith({
    bool? loading,
    CartSummury? summary,
    String? error,
  }) {
    return CartSummaryState(
      loading: loading ?? this.loading,
      summary: summary ?? this.summary,
      error: error,
    );
  }
}
