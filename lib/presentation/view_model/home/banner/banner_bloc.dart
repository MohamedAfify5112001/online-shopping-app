import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/banner/banner_repo.dart';
import '../../../../model/banner_model.dart';

part 'banner_event.dart';

part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRepository bannerRepository;

  BannerBloc({required this.bannerRepository}) : super(const BannerState()) {
    on<BannerFetchedEvent>(_onFetchBanners);
  }

  Future<void> _onFetchBanners(
      BannerFetchedEvent event, Emitter<BannerState> emit) async {
    emit(state.copyWith(status: BannerStatus.loading));
    try {
      final List<BannerModel> banners = await bannerRepository.getBanner();
      emit(state.copyWith(status: BannerStatus.success, banners: banners));
    } on FirebaseException catch (error) {
      emit(state.copyWith(
          status: BannerStatus.failure, errorMessage: error.message));
    }
  }
}
