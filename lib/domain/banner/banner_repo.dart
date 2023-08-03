import '../../data/network/services/crud_data/crud_services.dart';
import '../../model/banner_model.dart';

abstract interface class BannerRepository {
  Future<List<BannerModel>> getBanner();
}

final class BannerRepositroyImplementation implements BannerRepository {
  final CrudServices crudServices;

  BannerRepositroyImplementation({required this.crudServices});

  @override
  Future<List<BannerModel>> getBanner() async => await crudServices.getBanner();
}
