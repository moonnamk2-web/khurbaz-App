import '../../data/entities/address_entity.dart';

enum AddressesStatus { initial, loading, loaded, error }

class AddressesState {
  final AddressesStatus status;
  final List<AddressEntity> addresses;
  final String? errorMessage;

  const AddressesState({
    this.status = AddressesStatus.initial,
    this.addresses = const [],
    this.errorMessage,
  });

  AddressesState copyWith({
    AddressesStatus? status,
    List<AddressEntity>? addresses,
    String? errorMessage,
  }) {
    return AddressesState(
      status: status ?? this.status,
      addresses: addresses ?? this.addresses,
      errorMessage: errorMessage,
    );
  }
}
