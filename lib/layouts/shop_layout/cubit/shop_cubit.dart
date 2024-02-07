import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/category_model/category_Model.dart';
import 'package:shop_app/models/fav_model/ChangeFavoritesModel.dart';
import 'package:shop_app/models/home_model/HomeModel.dart';
import 'package:shop_app/models/home_model/Products.dart';
import 'package:shop_app/modules/carts/carts_screen.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/end_points/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  HomeModel? homeModel;
  CategoryModel? categoryModel;
  ChangeFavoritesModel? changeFavoritesModel;

  Map<int , bool> favorites = {};

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const ProductScreen(),
     const CategoriesScreen(),
    const CartsScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];
  int currentIndex = 0;
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.apps,
      ),
      label: 'Category',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.shopping_cart,
      ),
      label: 'Carts',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
      ),
      label: 'Favorite',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];
  void changeBottemNavi(int index) {
    currentIndex = index;
    emit(ChangeBottemNavigationBarState());
  }


  void getHomeData() async {
    emit(ShopLoadingHomeDataState());
    await DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id!:
          element.inFavorites!
        });
      });
      emit(
        ShopSuccessHomeDataState(homeModel!),
      );
    }).catchError((error) {
      print(error.toString());
      emit(
        ShopErrorHomeDataState(
          error.toString(),
        ),
      );
    });
  }

  void getGategories() async {
    await DioHelper.getData(
      url: Categories,
    ).then((value){
      categoryModel = CategoryModel.fromJson(value.data);
      emit(ShopSuccessCategoryState(categoryModel!));
    }).catchError((error){
      emit(ShopErrorCategoryState(error.toString(),),);
    });
  }

  void changeFavorites( int productId)
  async {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavState());
    DioHelper.postData(url: FAVORITES
      , data: {
        'product_id': productId,
      },
      token: token,).then((value){
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status!){
        favorites[productId] = !favorites[productId]!;
      }
      emit(ShopSuccessChangeFavState(changeFavoritesModel!));
    }).catchError((error){
      emit(ShopErrorChangeFavState(error.toString()));
    });
  }
}
