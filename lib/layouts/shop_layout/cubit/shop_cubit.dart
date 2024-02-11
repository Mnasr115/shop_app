import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model/category_Model.dart';
import 'package:shop_app/models/change_fav_model/ChangeFavoritesModel.dart';
import 'package:shop_app/models/favorites_model/favorites_model.dart';
import 'package:shop_app/models/home_model/HomeModel.dart';
import 'package:shop_app/models/login_model/LoginModel.dart';
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
  static ShopCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  CategoryModel? categoryModel;
  ChangeFavoritesModel? changeFavoritesModel;
  FavoritesModel? favoritesModel;
  LoginModel? userModel;

  Map<int, bool> favorites = {};
  Map<int, bool> carts = {};

  List<Widget> screens = [
    const ProductScreen(),
    const CategoriesScreen(),
    //const CartsScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
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
    /*const BottomNavigationBarItem(
      icon: Icon(
        Icons.shopping_cart,
      ),
      label: 'Carts',
    ),*/
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
        favorites.addAll({element.id: element.inFavorites!});
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
      url: CATEGORIES,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(ShopSuccessCategoryState(categoryModel!));
    }).catchError((error) {
      emit(
        ShopErrorCategoryState(
          error.toString(),
        ),
      );
    });
  }

  void changeFavorites(int productId) async {
    favorites[productId] = !favorites[productId]!;
    emit(ShopLoadingChangeFavState());
    await DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      }
      else
        {
          getFavorites();
        }
      emit(ShopSuccessChangeFavState(changeFavoritesModel!));
    }).catchError((error) {
       favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavState(error.toString()));
    });
  }

  void getFavorites() async {

    emit(ShopLoadingGetFavState());
    await DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavState());
    }).catchError((error) {
      emit(
        ShopErrorGetFavState(
          error.toString(),
        ),
      );
    });
  }

  /*void changeCarts(int productId) async {
    carts[productId] = !carts[productId]!;
    emit(ShopLoadingChangeCartState());
    await DioHelper.postData(
      url: CART,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status!) {
        carts[productId] = !carts[productId]!;
      }
      else
      {
        getCarts();
      }
      emit(ShopSuccessChangeFavState(changeFavoritesModel!));
    }).catchError((error) {
      carts[productId] = !carts[productId]!;
      emit(ShopErrorChangeFavState(error.toString()));
    });
  }


  void getCarts() async {

    emit(ShopLoadingAddedToCartState());
    await DioHelper.getData(
      url: CART,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessAddedToCartState(favoritesModel!));
    }).catchError((error) {
      emit(
        ShopErrorAddedToCartState(
          error.toString(),
        ),
      );
    });
  }*/

  void getUserData() async {
    await DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      //print(userModel?.data.name);
      //print(userModel?.data!.phone!);
      emit(ShopSuccessGetProfileState(userModel!));
    }).catchError((error) {
      emit(
        ShopErrorGetProfileState(
          error.toString(),
        ),
      );
    });
  }

  void updateUser({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(ShopLoadingUpdateUserState());
    await DioHelper.putData(
      url: UPDATE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(
        ShopSuccessUpdateUserState(userModel!),
      );
    }).catchError((error) {
      emit(
        ShopErrorUpdateUserState(
          error.toString(),
        ),
      );
    });
  }
}
