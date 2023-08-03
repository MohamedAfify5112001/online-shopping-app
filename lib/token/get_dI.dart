import 'package:get_it/get_it.dart';
import 'package:online_shopping/data/network/services/auth_services/auth.dart';
import 'package:online_shopping/data/network/services/crud_data/crud_services.dart';
import 'package:online_shopping/domain/auth-repo/auth_repo.dart';
import 'package:online_shopping/domain/banner/banner_repo.dart';
import 'package:online_shopping/domain/payment/payment_repo.dart';
import 'package:online_shopping/domain/product/product_repo.dart';
import 'package:online_shopping/presentation/view_model/auth/authentication_bloc.dart';
import 'package:online_shopping/presentation/view_model/bag/bag_bloc.dart';
import 'package:online_shopping/presentation/view_model/bag/bag_bloc.dart';
import 'package:online_shopping/presentation/view_model/checkout/checkout_bloc.dart';
import 'package:online_shopping/presentation/view_model/checkout/checkout_bloc.dart';
import 'package:online_shopping/presentation/view_model/checkout/checkout_bloc.dart';
import 'package:online_shopping/presentation/view_model/favorites/favorites_bloc.dart';
import 'package:online_shopping/presentation/view_model/home/banner/banner_bloc.dart';
import 'package:online_shopping/presentation/view_model/home/banner/banner_bloc.dart';
import 'package:online_shopping/presentation/view_model/layout/layout_bloc.dart';
import 'package:online_shopping/presentation/view_model/product/product_bloc.dart';
import 'package:online_shopping/presentation/view_model/product/product_bloc.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  //Auth
  instance.registerLazySingleton<AuthenticationServices>(
      () => AuthenticationServicesImplement());
  instance.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImplement(
          authenticationServices: instance<AuthenticationServices>()));

  // Crud Operation
  instance
      .registerLazySingleton<CrudServices>(() => CrudServicesImplementation());

  // Repo
  instance.registerLazySingleton<BannerRepository>(() =>
      BannerRepositroyImplementation(crudServices: instance<CrudServices>()));

  instance.registerLazySingleton<ProductRepository>(() =>
      ProductRepositoryImplementation(crudServices: instance<CrudServices>()));

  instance.registerLazySingleton<PaymentRepository>(() =>
      PaymentRepositoryImplemntation(crudServices: instance<CrudServices>()));
  // Bloc

  if (!GetIt.I.isRegistered<AuthenticationBloc>()) {
    instance.registerFactory<AuthenticationBloc>(
        () => AuthenticationBloc(authenticationRepository: instance()));
  }

  if (!GetIt.I.isRegistered<LayoutBloc>()) {
    instance.registerFactory<LayoutBloc>(() => LayoutBloc());
  }

  if (!GetIt.I.isRegistered<BannerBloc>()) {
    instance.registerFactory<BannerBloc>(
        () => BannerBloc(bannerRepository: instance()));
  }

  if (!GetIt.I.isRegistered<ProductBloc>()) {
    instance.registerFactory<ProductBloc>(
        () => ProductBloc(productRepository: instance()));
  }
  if (!GetIt.I.isRegistered<FavoritesBloc>()) {
    instance.registerFactory<FavoritesBloc>(
        () => FavoritesBloc(productRepository: instance()));
  }
  if (!GetIt.I.isRegistered<BagBloc>()) {
    instance
        .registerFactory<BagBloc>(() => BagBloc(productRepository: instance()));
  }
  if (!GetIt.I.isRegistered<CheckoutBloc>()) {
    instance.registerFactory<CheckoutBloc>(
        () => CheckoutBloc(paymentRepository: instance()));
  }
}
