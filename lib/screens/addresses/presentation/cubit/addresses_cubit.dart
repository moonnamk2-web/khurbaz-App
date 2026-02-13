import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entities/address_entity.dart';
import '../../data/sources/address_remote_data_source.dart';
import 'addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  AddressesCubit() : super(const AddressesState());

  final _remoteSource = AddressRemoteSource();

  // --------------------------
  // LOAD ADDRESSES
  // --------------------------
  Future<void> loadAddresses() async {
    emit(state.copyWith(status: AddressesStatus.loading));

    try {
      final addresses = await _remoteSource.getAddresses();

      emit(
        state.copyWith(status: AddressesStatus.loaded, addresses: addresses),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AddressesStatus.error,
          errorMessage: 'فشل تحميل العناوين',
        ),
      );
    }
  }

  // --------------------------
  // ADD ADDRESS
  // --------------------------
  Future<void> addAddress({required AddressEntity address}) async {
    emit(state.copyWith(status: AddressesStatus.loading));

    try {
      await _remoteSource.addAddress(body: address.toJson());

      // reload list after add
      final addresses = await _remoteSource.getAddresses();

      emit(
        state.copyWith(status: AddressesStatus.loaded, addresses: addresses),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AddressesStatus.error,
          errorMessage: 'فشل إضافة العنوان',
        ),
      );
    }
  }

  // --------------------------
  // DELETE ADDRESS
  // --------------------------
  Future<void> deleteAddress({required int id}) async {
    emit(state.copyWith(status: AddressesStatus.loading));

    try {
      await _remoteSource.deleteAddress(id: id);

      final addresses = await _remoteSource.getAddresses();

      emit(
        state.copyWith(status: AddressesStatus.loaded, addresses: addresses),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AddressesStatus.error,
          errorMessage: 'فشل حذف العنوان',
        ),
      );
    }
  }

  // --------------------------
  // SET DEFAULT ADDRESS
  // --------------------------
  Future<void> setDefault({required int id}) async {
    emit(state.copyWith(status: AddressesStatus.loading));

    try {
      await _remoteSource.setDefaultAddress(id: id);

      final addresses = await _remoteSource.getAddresses();

      emit(
        state.copyWith(status: AddressesStatus.loaded, addresses: addresses),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AddressesStatus.error,
          errorMessage: 'فشل تعيين العنوان الافتراضي',
        ),
      );
    }
  }
}
