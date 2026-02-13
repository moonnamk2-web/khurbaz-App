import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_states.dart';

class LoadingCubit extends Cubit<LoadingStates> {
  LoadingCubit() : super(NotLoading());

  static LoadingCubit instance(BuildContext context) =>
      BlocProvider.of(context);

  loading() {
    emit(Loading());
  }

  notLoading() {
    emit(NotLoading());
  }
}
