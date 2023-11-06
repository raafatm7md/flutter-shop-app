import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/get_favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/services/service.dart';
import 'package:shop_app/services/shared.dart';
import 'package:shop_app/views/categories_screen.dart';
import 'package:shop_app/views/favorites_screen.dart';
import 'package:shop_app/views/products_screen.dart';
import '../../models/favorites_model.dart';
import '../settings_screen.dart';
part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNav());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeData());
    DioHelper.getData(url: 'home', token: CacheHelper.getData('token'))
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data?.products?.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
      });
      emit(ShopSuccessHomeData());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorHomeData());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(url: 'categories').then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategories());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorCategories());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavorites());
    DioHelper.postData(
            url: 'favorites',
            data: {'product_id': productId},
            token: CacheHelper.getData('token'))
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel?.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavourites();
      }
      emit(ShopSuccessChangeFavorites(changeFavoritesModel!));
    }).catchError((e) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavorites());
    });
  }

  GetFavouritesModel? getFavouritesModel;
  void getFavourites() {
    emit(ShopLoadingGetFavorites());
    DioHelper.getData(url: 'favorites', token: CacheHelper.getData('token'))
        .then((value) {
      getFavouritesModel = GetFavouritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavorites());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorGetFavorites());
    });
  }

  LoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingUserData());
    DioHelper.getData(url: 'profile', token: CacheHelper.getData('token'))
        .then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUserData(userModel!));
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorUserData());
    });
  }

  void updateUserData(
      {required String name, required String email, required String phone}) {
    emit(ShopLoadingUpdateUser());
    DioHelper.putData(
        url: 'update-profile',
        token: CacheHelper.getData('token'),
        data: {
          "name": name,
          "email": email,
          "phone": phone,
        }).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUser(userModel!));
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorUpdateUser());
    });
  }
}
