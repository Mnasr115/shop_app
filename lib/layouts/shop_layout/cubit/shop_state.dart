part of 'shop_cubit.dart';

@immutable
abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {
  final HomeModel homeModel;

  ShopSuccessHomeDataState(this.homeModel);
}

class ShopErrorHomeDataState extends ShopStates {
  final String errorMessage;

  ShopErrorHomeDataState(this.errorMessage);
}

class ChangeBottemNavigationBarState extends ShopStates {}

class ShopSuccessCategoryState extends ShopStates {
  final CategoryModel categoryModel;

  ShopSuccessCategoryState(this.categoryModel);
}

class ShopErrorCategoryState extends ShopStates {
  final String errorMessage;

  ShopErrorCategoryState(this.errorMessage);
}

class ShopSuccessChangeFavState extends ShopStates {
  final ChangeFavoritesModel changeFavoritesModel;

  ShopSuccessChangeFavState(this.changeFavoritesModel);
}

class ShopLoadingChangeFavState extends ShopStates {}

class ShopErrorChangeFavState extends ShopStates {
  final String errorMessage;

  ShopErrorChangeFavState(this.errorMessage);
}

class ShopLoadingGetFavState extends ShopStates {}

class ShopSuccessGetFavState extends ShopStates {}

class ShopErrorGetFavState extends ShopStates {
  final String errorMessage;

  ShopErrorGetFavState(this.errorMessage);
}

class ShopLoadingGetProfileState extends ShopStates {}

class ShopSuccessGetProfileState extends ShopStates {
  final LoginModel userModel;

  ShopSuccessGetProfileState(this.userModel);
}

class ShopErrorGetProfileState extends ShopStates {
  final String errorMessage;

  ShopErrorGetProfileState(this.errorMessage);
}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final LoginModel userModel;

  ShopSuccessUpdateUserState(this.userModel);
}

class ShopErrorUpdateUserState extends ShopStates {
  final String errorMessage;

  ShopErrorUpdateUserState(this.errorMessage);
}

class ShopLoadingAddedToCartState extends ShopStates {}

class ShopSuccessAddedToCartState extends ShopStates {
  final FavoritesModel favoritesModel;

  ShopSuccessAddedToCartState(this.favoritesModel);

}

class ShopErrorAddedToCartState extends ShopStates {
  final String errorMessage;

  ShopErrorAddedToCartState(this.errorMessage);
}

class ShopSuccessChangeCartState extends ShopStates {
  final ChangeFavoritesModel changeFavoritesModel;

  ShopSuccessChangeCartState(this.changeFavoritesModel);
}

class ShopLoadingChangeCartState extends ShopStates {}

class ShopErrorChangeCartState extends ShopStates {
  final String errorMessage;

  ShopErrorChangeCartState(this.errorMessage);
}
