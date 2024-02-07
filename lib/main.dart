import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/layouts/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/layouts/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/Auth/login_screen/login_screen.dart';
import 'package:shop_app/modules/onboarding_screen/onboarding_screen.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/local/Cache_helper.dart';
import 'package:shop_app/shared/network/remote/bloc_observer.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp({
    required this.startWidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData()..getGategories(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    selectedItemColor: kPrimaryColor,
                    unselectedItemColor: Colors.black),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                      statusBarIconBrightness: Brightness.light),
                  titleTextStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Janna',
                  ),
                )),
            home: startWidget,
          );
        },
      ),
    );
  }
}
