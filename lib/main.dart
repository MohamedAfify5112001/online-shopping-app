import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/firebase_options.dart';
import 'package:online_shopping/token/app.dart';
import 'package:online_shopping/token/bloc_observer_app.dart';
import 'package:online_shopping/token/get_dI.dart';

import 'data/cache/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initAppModule();
  await CacheHelper.initPref();
  Bloc.observer = BlocAppObserver();

  runApp(OnlineShoppingApp());
}
