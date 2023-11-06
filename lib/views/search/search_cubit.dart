import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/services/service.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void search(String text){
    emit(SearchLoading());
    DioHelper.postData(url: 'products/search', data: {
      "text": text
}).then((value) {
  model = SearchModel.fromJson(value.data);
  emit(SearchSuccess());
}).catchError((error){
  print(error.toString());
  emit(SearchError());
});
}
}
