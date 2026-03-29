import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moona/managers/server/cart/cart_api.dart';
import 'cart_summary_state.dart';

class CartSummaryCubit extends Cubit<CartSummaryState> {
  CartSummaryCubit() : super(CartSummaryState());

  Future<void> loadSummary() async {
    emit(state.copyWith(loading: true));

    final summary = await CartApi.summary();

    emit(state.copyWith(loading: false, summary: summary));
  }
}
