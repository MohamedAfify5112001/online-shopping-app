part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();
}

final class AddNewCardEvent extends CheckoutEvent {
  final CardModel cardModel;
  const AddNewCardEvent({required this.cardModel});

  @override
  List<Object> get props => [cardModel];
}

final class FetchCardsEvent extends CheckoutEvent {
  const FetchCardsEvent();
  @override
  List<Object> get props => [];
}

final class AddNewShippingAddress extends CheckoutEvent {
  final ShippingAddressModel shippingAddressModel;
  const AddNewShippingAddress({required this.shippingAddressModel});

  @override
  List<Object> get props => [shippingAddressModel];
}

final class FetchShippingAddressEvent extends CheckoutEvent {
  const FetchShippingAddressEvent();
  @override
  List<Object> get props => [];
}

final class AddNewOrder extends CheckoutEvent {
  final OrderModel orderModel;
  const AddNewOrder({required this.orderModel});

  @override
  List<Object> get props => [orderModel];
}

final class FetchOrdersEvent extends CheckoutEvent {
  const FetchOrdersEvent();
  @override
  List<Object> get props => [];
}
