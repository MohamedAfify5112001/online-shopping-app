import 'package:online_shopping/data/cache/cache_helper.dart';

sealed class CachingStorage {
  CachingStorage._();

  static Future storeUId({required String key, required String val}) async =>
      await CacheHelper.putValue(key: key, val: val);

  static String getUId({required String key}) => CacheHelper.getValue(key: key);

  static Future storeFav({required String key, required bool val}) async =>
      await CacheHelper.putValueBool(key: key, val: val);

  static bool getItemFav({required String key}) =>
      CacheHelper.getValueBool(key: key);
}
