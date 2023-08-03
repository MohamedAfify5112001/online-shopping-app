part of 'banner_bloc.dart';

enum BannerStatus {
  initial,
  loading,
  success,
  failure;
}

final class BannerState extends Equatable {
  final List<BannerModel> banners;
  final BannerStatus status;

  final String errorMessage;
  const BannerState({
    this.status = BannerStatus.initial,
    this.banners = const <BannerModel>[],
    this.errorMessage = "",
  });

  BannerState copyWith({
    BannerStatus? status,
    List<BannerModel>? banners,
    String? errorMessage,
  }) {
    return BannerState(
      status: status ?? this.status,
      banners: banners ?? this.banners,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, banners, errorMessage];
}
