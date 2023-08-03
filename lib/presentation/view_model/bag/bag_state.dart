part of '../../view_model/bag/bag_bloc.dart';

enum BagStatus {
  initial,
  loading,
  success,
  failure;
}

final class BagState extends Equatable {
  final Cart carts;
  final BagStatus bagProductStatus;
  final String bagProductsErrorMessage;

  final BagStatus addBagProductStatus;
  final String addBagProductsErrorMessage;

  final BagStatus incrementBagProductStatus;
  final BagStatus decrementBagProductStatus;
  final int count;

  const BagState({
    this.bagProductStatus = BagStatus.initial,
    this.carts = const Cart(),
    this.bagProductsErrorMessage = "",
    this.addBagProductStatus = BagStatus.initial,
    this.addBagProductsErrorMessage = '',
    this.incrementBagProductStatus = BagStatus.initial,
    this.decrementBagProductStatus = BagStatus.initial,
    this.count = 1,
  });

  @override
  List<Object> get props => [
        carts,
        bagProductStatus,
        bagProductsErrorMessage,
        addBagProductStatus,
        addBagProductsErrorMessage
      ];
  BagState copyWith({
    BagStatus? bagProductStatus,
    Cart? carts,
    String? bagProductsErrorMessage,
    BagStatus? addBagProductStatus,
    String? addBagProductsErrorMessage,
    BagStatus? incrementBagProductStatus,
    BagStatus? decrementBagProductStatus,
    int? count,
  }) =>
      BagState(
        bagProductStatus: bagProductStatus ?? this.bagProductStatus,
        carts: carts ?? this.carts,
        bagProductsErrorMessage:
            bagProductsErrorMessage ?? this.bagProductsErrorMessage,
        addBagProductStatus: addBagProductStatus ?? this.addBagProductStatus,
        addBagProductsErrorMessage:
            addBagProductsErrorMessage ?? this.addBagProductsErrorMessage,
        incrementBagProductStatus:
            incrementBagProductStatus ?? this.incrementBagProductStatus,
        decrementBagProductStatus:
            decrementBagProductStatus ?? this.decrementBagProductStatus,
        count: count ?? this.count,
      );
}
