part of 'banner_bloc.dart';

sealed class BannerEvent extends Equatable {
  const BannerEvent();

  @override
  List<Object> get props => [];
}

final class BannerFetchedEvent extends BannerEvent {
  const BannerFetchedEvent();
}
