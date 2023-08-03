import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:online_shopping/model/product_model.dart';

import '../../../data/cache/caching_comp.dart';
import '../../../domain/product/product_repo.dart';
import '../../../model/cart.dart';

part 'bag_event.dart';

part 'bag_state.dart';

class BagBloc extends Bloc<BagEvent, BagState> {
  final ProductRepository productRepository;

  BagBloc({required this.productRepository}) : super(const BagState()) {
    on<AddItemInBagEvent>(_onAddProductItemInBag);
    on<FetchBagItemsEvent>(_onFetchProductItemBag);
    on<DeleteItemFromBagList>(_onDeleteItemFromBagList);

    on<AddItemInBagWithQuantityEvent>((event, emit) {
      if (state.carts.products.isNotEmpty) {
        emit(
          state.copyWith(
            bagProductStatus: BagStatus.success,
            carts: Cart(
              products: List.from(state.carts.products)..add(event.product),
            ),
          ),
        );
      }
    });
    on<RemoveItemInBagWithQuantityEvent>((event, emit) {
      if (state.carts.products.isNotEmpty) {
        emit(
          state.copyWith(
            bagProductStatus: BagStatus.success,
            carts: Cart(
              products: List.from(state.carts.products)..remove(event.product),
            ),
          ),
        );
      }
    });
  }

  Future<void> _onAddProductItemInBag(
      AddItemInBagEvent addItemInBagEvent, Emitter<BagState> emit) async {
    emit(state.copyWith(addBagProductStatus: BagStatus.loading));
    try {
      await productRepository.addProductInBag(
          firebaseUserId: CachingStorage.getUId(key: 'uId'),
          collectionName: 'users',
          subCollectionName: 'bag',
          product: addItemInBagEvent.product);
      emit(state.copyWith(addBagProductStatus: BagStatus.success));
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          addBagProductStatus: BagStatus.failure,
          addBagProductsErrorMessage: error.message));
    }
  }

  Future<void> _onFetchProductItemBag(
      FetchBagItemsEvent event, Emitter<BagState> emit) async {
    emit(state.copyWith(bagProductStatus: BagStatus.loading));
    try {
      final Cart $Bag = await productRepository.getBagItems(
        firebaseUserId: CachingStorage.getUId(key: 'uId'),
        collectionName: 'users',
        subCollectionName: 'bag',
      );
      emit(state.copyWith(bagProductStatus: BagStatus.success, carts: $Bag));
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          bagProductStatus: BagStatus.failure,
          bagProductsErrorMessage: error.message));
    }
  }

  Future<void> _onDeleteItemFromBagList(
      DeleteItemFromBagList event, Emitter<BagState> emit) async {
    try {
      await productRepository.deleteProductInBag(
          firebaseUserId: CachingStorage.getUId(key: 'uId'),
          collectionName: 'users',
          subCollectionName: 'bag',
          product: event.product);
      add(FetchBagItemsEvent());
    } on FirebaseException catch (error) {
      log(error.message!);
    }
  }
}
