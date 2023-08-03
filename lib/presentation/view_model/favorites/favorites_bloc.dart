import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/cache/caching_comp.dart';
import '../../../domain/product/product_repo.dart';
import '../../../model/product_model.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ProductRepository productRepository;

  FavoritesBloc({required this.productRepository})
      : super(const FavoritesState()) {
    on<FetchFavoritesProductEvent>(_onFetchFavProduct);
  }

  Future<void> _onFetchFavProduct(
      FetchFavoritesProductEvent event, Emitter<FavoritesState> emit) async {
    emit(state.copyWith(favProductStatus: FavoritesStatus.loading));
    try {
      final $Favorites = await productRepository.getFavoritesItems(
        firebaseUserId: CachingStorage.getUId(key: 'uId'),
        collectionName: 'users',
        subCollectionName: 'favorites',
      );
      emit(state.copyWith(
          favProductStatus: FavoritesStatus.success, favProducts: $Favorites));
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          favProductStatus: FavoritesStatus.failure,
          favProductsErrorMessage: error.message));
    }
  }
}
