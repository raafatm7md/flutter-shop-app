part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopChangeBottomNav extends ShopState {}

class ShopLoadingHomeData extends ShopState {}

class ShopSuccessHomeData extends ShopState {}

class ShopErrorHomeData extends ShopState {}

class ShopSuccessCategories extends ShopState {}

class ShopErrorCategories extends ShopState {}

class ShopChangeFavorites extends ShopState {}

class ShopSuccessChangeFavorites extends ShopState {
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavorites(this.model);
}

class ShopErrorChangeFavorites extends ShopState {}

class ShopLoadingGetFavorites extends ShopState {}

class ShopSuccessGetFavorites extends ShopState {}

class ShopErrorGetFavorites extends ShopState {}

class ShopLoadingUserData extends ShopState {}

class ShopSuccessUserData extends ShopState {
  final LoginModel userModel;
  ShopSuccessUserData(this.userModel);
}

class ShopErrorUserData extends ShopState {}

class ShopLoadingUpdateUser extends ShopState {}

class ShopSuccessUpdateUser extends ShopState {
  final LoginModel userModel;
  ShopSuccessUpdateUser(this.userModel);
}

class ShopErrorUpdateUser extends ShopState {}