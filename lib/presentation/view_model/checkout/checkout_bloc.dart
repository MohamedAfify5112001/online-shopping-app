import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:online_shopping/data/cache/cache_helper.dart';
import 'package:online_shopping/model/card_model.dart';
import 'package:online_shopping/model/order_model.dart';
import 'package:online_shopping/model/shipping_address_model.dart';

import '../../../data/cache/caching_comp.dart';
import '../../../domain/payment/payment_repo.dart';

part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final PaymentRepository paymentRepository;

  CheckoutBloc({required this.paymentRepository})
      : super(const CheckoutState()) {
    on<AddNewCardEvent>(_onAddNewCard);
    on<FetchCardsEvent>(_onFetchNewCards);

    on<AddNewShippingAddress>(_onAddNewShippingAddress);
    on<FetchShippingAddressEvent>(_onFetchNewShippingAddresses);

    on<AddNewOrder>(_onAddNewOrder);
    on<FetchOrdersEvent>(_onFetchOrders);
  }

  Future<void> _onAddNewCard(
      AddNewCardEvent addNewCardEvent, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(addNewCardStatus: CheckoutStatus.loading));
    try {
      await paymentRepository.addPaymentMethod(
        firebaseUserId: CachingStorage.getUId(key: 'uId'),
        collectionName: 'users',
        subCollectionName: 'cards',
        cardModel: addNewCardEvent.cardModel,
      );
      final cards = await paymentRepository.getPaymentMethod(
        firebaseUserId: CachingStorage.getUId(key: 'uId'),
        collectionName: 'users',
        subCollectionName: 'cards',
      );
      emit(state.copyWith(
          addNewCardStatus: CheckoutStatus.success, cards: cards));
      // add(const FetchCardsEvent());
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          addNewCardStatus: CheckoutStatus.failure,
          addNewCardsErrorMessage: error.message));
    }
  }

  Future<void> _onFetchNewCards(
      FetchCardsEvent event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(cardsStatus: CheckoutStatus.loading));
    try {
      final cards = await paymentRepository.getPaymentMethod(
        firebaseUserId: CachingStorage.getUId(key: 'uId'),
        collectionName: 'users',
        subCollectionName: 'cards',
      );
      emit(state.copyWith(cardsStatus: CheckoutStatus.success, cards: cards));
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          cardsStatus: CheckoutStatus.failure,
          cardsErrorMessage: error.message));
    }
  }

  Future<void> _onAddNewShippingAddress(
      AddNewShippingAddress addNewShippingAddress,
      Emitter<CheckoutState> emit) async {
    emit(state.copyWith(addNewShippingAddressStatus: CheckoutStatus.loading));
    try {
      await paymentRepository.addShippingAddress(
        firebaseUserId: CachingStorage.getUId(key: 'uId'),
        collectionName: 'users',
        subCollectionName: 'shippingAddresses',
        shippingAddressModel: addNewShippingAddress.shippingAddressModel,
      );
      final shippingAddresses = await paymentRepository.getShippingAddress(
        firebaseUserId: CachingStorage.getUId(key: 'uId'),
        collectionName: 'users',
        subCollectionName: 'shippingAddresses',
      );
      await CacheHelper.putValue(
          key: 'shipping', val: shippingAddresses.length.toString());
      emit(state.copyWith(
        addNewShippingAddressStatus: CheckoutStatus.success,
        shippingAddresses: shippingAddresses,
      ));
      // add(const FetchCardsEvent());
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          addNewShippingAddressStatus: CheckoutStatus.failure,
          addNewShippingAddressErrorMessage: error.message));
    }
  }

  Future<void> _onFetchNewShippingAddresses(
      FetchShippingAddressEvent event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(shippingAddressesStatus: CheckoutStatus.loading));
    try {
      final shippingAddresses = await paymentRepository.getShippingAddress(
        firebaseUserId: CachingStorage.getUId(key: 'uId'),
        collectionName: 'users',
        subCollectionName: 'shippingAddresses',
      );
      emit(state.copyWith(
          shippingAddressesStatus: CheckoutStatus.success,
          shippingAddresses: shippingAddresses));
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          shippingAddressesStatus: CheckoutStatus.failure,
          shippingAddressesErrorMessage: error.message));
    }
  }

  Future<void> _onAddNewOrder(
      AddNewOrder addNewOrder, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(addNewOrderStatus: CheckoutStatus.loading));
    try {
      await paymentRepository.addOrder(
        firebaseUserId: CachingStorage.getUId(key: 'uId'),
        collectionName: 'users',
        subCollectionName: 'orders',
        orderModel: addNewOrder.orderModel,
      );
      emit(state.copyWith(addNewOrderStatus: CheckoutStatus.success));
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          addNewOrderStatus: CheckoutStatus.failure,
          addNewOrdersErrorMessage: error.message));
    }
  }

  Future<void> _onFetchOrders(
      FetchOrdersEvent event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(ordersStatus: CheckoutStatus.loading));
    try {
      final orders = await paymentRepository.getOrders(
        firebaseUserId: CachingStorage.getUId(key: 'uId'),
        collectionName: 'users',
        subCollectionName: 'orders',
      );
      await CacheHelper.putValue(key: 'order', val: orders.length.toString());
      emit(
          state.copyWith(ordersStatus: CheckoutStatus.success, orders: orders));
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          ordersStatus: CheckoutStatus.failure,
          ordersErrorMessage: error.message));
    }
  }
}
