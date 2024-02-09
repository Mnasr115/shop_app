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

class ShopChangeFavState extends ShopStates {}

class ShopErrorChangeFavState extends ShopStates {
  final String errorMessage;

  ShopErrorChangeFavState(this.errorMessage);
}

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
