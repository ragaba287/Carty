abstract class HomeStates {}

class HomeInitState extends HomeStates {}

class HomeChangeNavState extends HomeStates {}

class HomeAutoPlayBannerState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {}

class HomeErrorState extends HomeStates {}

class CateogriesSuccessState extends HomeStates {}

class CateogriesErrorState extends HomeStates {}

class AddToCartSuccessState extends HomeStates {
  final String? message;
  AddToCartSuccessState({this.message});
}

class AddToCartErrorState extends HomeStates {}

class CartChangedSuccessState extends HomeStates {}

class CartChangedErrorState extends HomeStates {}
