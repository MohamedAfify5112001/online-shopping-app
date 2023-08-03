import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:online_shopping/model/product_model.dart';

import '../../../data/cache/caching_comp.dart';
import '../../../domain/product/product_repo.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(const ProductState()) {
    on<FetchNewProductEvent>(_fetchNewProductEvent);
    on<FetchShoesProductEvent>(_fetchShoesProductEvent);
    on<FetchAccessoriesProductEvent>(_fetchAccessoriesProductEvent);
    on<AddProductInFavEvent>(_addProductInFavEvent);
    on<DeleteProductInFavEvent>(_deleteProductInFavEvent);
  }

  Future<void> _fetchNewProductEvent(
      FetchNewProductEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(newProductStatus: ProductStatus.loading));
    try {
      List<Product> newProduct = await productRepository.getNewProductItems();
      emit(state.copyWith(
          newProductStatus: ProductStatus.success, newProducts: newProduct));
      log(newProduct[0].uId.toString());
      log(newProduct[0].name.toString());
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          newProductStatus: ProductStatus.failure,
          newProductErrorMessage: error.message));
    }
  }

  Future<void> _fetchShoesProductEvent(
      FetchShoesProductEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(shoesProductStatus: ProductStatus.loading));
    try {
      List<Product> shoesProducts =
          await productRepository.getShoesProductItems();
      emit(state.copyWith(
          shoesProductStatus: ProductStatus.success,
          shoesProducts: shoesProducts));
      log(shoesProducts[0].uId.toString());
      log(shoesProducts[0].name.toString());
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          shoesProductStatus: ProductStatus.failure,
          shoesErrorMessage: error.message));
    }
  }

  Future<void> _fetchAccessoriesProductEvent(
      FetchAccessoriesProductEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(accessoriesProductStatus: ProductStatus.loading));
    try {
      List<Product> accessoriesProducts =
          await productRepository.getAccessoriesProductItems();
      emit(state.copyWith(
          accessoriesProductStatus: ProductStatus.success,
          accessoriesProducts: accessoriesProducts));
      log(accessoriesProducts[0].uId.toString());
      log(accessoriesProducts[0].name.toString());
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          accessoriesProductStatus: ProductStatus.failure,
          accessoriesErrorMessage: error.message));
    }
  }

  Future<void> _addProductInFavEvent(
      AddProductInFavEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(addProductInFavStatus: ProductStatus.loading));
    try {
      await productRepository.addProductInFav(
          firebaseUserId: CachingStorage.getUId(key: 'uId'),
          collectionName: 'users',
          subCollectionName: 'favorites',
          product: event.product);
      emit(state.copyWith(addProductInFavStatus: ProductStatus.success));
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          addProductInFavStatus: ProductStatus.failure,
          addProductInFavErrorMessage: error.message));
    }
  }

  Future<void> _deleteProductInFavEvent(
      DeleteProductInFavEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(deleteProductInFavStatus: ProductStatus.loading));
    try {
      await productRepository.deleteProductInFav(
          firebaseUserId: CachingStorage.getUId(key: 'uId'),
          collectionName: 'users',
          subCollectionName: 'favorites',
          product: event.product);
      emit(state.copyWith(deleteProductInFavStatus: ProductStatus.success));
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          deleteProductInFavStatus: ProductStatus.failure,
          deleteProductInFavErrorMessage: error.message));
    }
  }
}
