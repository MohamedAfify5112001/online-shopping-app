part of 'checkout_bloc.dart';

enum CheckoutStatus {
  initial,
  loading,
  success,
  failure;
}

final class CheckoutState extends Equatable {
  final CheckoutStatus addNewCardStatus;
  final String addNewCardsErrorMessage;

  final List<CardModel> cards;
  final CheckoutStatus cardsStatus;
  final String cardsErrorMessage;

  final CheckoutStatus addNewShippingAddressStatus;
  final String addNewShippingAddressErrorMessage;

  final List<ShippingAddressModel> shippingAddresses;
  final CheckoutStatus shippingAddressesStatus;
  final String shippingAddressesErrorMessage;

  final CheckoutStatus addNewOrderStatus;
  final String addNewOrdersErrorMessage;

  final List<OrderModel> orders;
  final CheckoutStatus ordersStatus;
  final String ordersErrorMessage;

  const CheckoutState({
    this.addNewCardStatus = CheckoutStatus.initial,
    this.addNewCardsErrorMessage = '',
    this.cardsStatus = CheckoutStatus.initial,
    this.cards = const <CardModel>[],
    this.cardsErrorMessage = '',
    this.addNewShippingAddressStatus = CheckoutStatus.initial,
    this.addNewShippingAddressErrorMessage = '',
    this.shippingAddressesStatus = CheckoutStatus.initial,
    this.shippingAddresses = const <ShippingAddressModel>[],
    this.shippingAddressesErrorMessage = '',
    this.addNewOrderStatus = CheckoutStatus.initial,
    this.addNewOrdersErrorMessage = '',
    this.ordersStatus = CheckoutStatus.initial,
    this.orders = const <OrderModel>[],
    this.ordersErrorMessage = '',
  });

  CheckoutState copyWith({
    CheckoutStatus? addNewCardStatus,
    String? addNewCardsErrorMessage,
    CheckoutStatus? cardsStatus,
    List<CardModel>? cards,
    String? cardsErrorMessage,
    CheckoutStatus? addNewShippingAddressStatus,
    String? addNewShippingAddressErrorMessage,
    CheckoutStatus? shippingAddressesStatus,
    List<ShippingAddressModel>? shippingAddresses,
    String? shippingAddressesErrorMessage,
    CheckoutStatus? addNewOrderStatus,
    String? addNewOrdersErrorMessage,
    CheckoutStatus? ordersStatus,
    List<OrderModel>? orders,
    String? ordersErrorMessage,
  }) =>
      CheckoutState(
        addNewCardStatus: addNewCardStatus ?? this.addNewCardStatus,
        addNewCardsErrorMessage:
            addNewCardsErrorMessage ?? this.addNewCardsErrorMessage,
        cardsStatus: cardsStatus ?? this.cardsStatus,
        cardsErrorMessage: cardsErrorMessage ?? this.cardsErrorMessage,
        cards: cards ?? this.cards,
        addNewShippingAddressStatus:
            addNewShippingAddressStatus ?? this.addNewShippingAddressStatus,
        addNewShippingAddressErrorMessage: addNewShippingAddressErrorMessage ??
            this.addNewShippingAddressErrorMessage,
        shippingAddressesStatus:
            shippingAddressesStatus ?? this.shippingAddressesStatus,
        shippingAddressesErrorMessage:
            shippingAddressesErrorMessage ?? this.shippingAddressesErrorMessage,
        shippingAddresses: shippingAddresses ?? this.shippingAddresses,
        addNewOrderStatus: addNewOrderStatus ?? this.addNewOrderStatus,
        addNewOrdersErrorMessage:
            addNewOrdersErrorMessage ?? this.addNewOrdersErrorMessage,
        ordersStatus: ordersStatus ?? this.ordersStatus,
        ordersErrorMessage: ordersErrorMessage ?? this.ordersErrorMessage,
        orders: orders ?? this.orders,
      );

  @override
  List<Object> get props => [
        addNewCardStatus,
        addNewCardsErrorMessage,
        cardsStatus,
        cards,
        cardsErrorMessage,
        addNewShippingAddressStatus,
        addNewShippingAddressErrorMessage,
        shippingAddresses,
        shippingAddressesErrorMessage,
        shippingAddressesStatus,
        addNewOrderStatus,
        addNewOrdersErrorMessage,
        orders,
        ordersStatus,
        ordersErrorMessage,
      ];
}
