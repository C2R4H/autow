part of 'newPost_bloc.dart';

class NewPostState{

  List brandsList = [];
  List modelsList = [];

  int choosedBrand = 0;
  String choosedBrandName = "";
}

class NewPostStateLoading extends NewPostState{}

class NewPostStateAddData extends NewPostState{
  NewPostStateAddData({choosedBrand,choosedBrandName});
}

class NewPostStateLoadedData extends NewPostState{
  List brandsList = [];
  List modelsList = [];
  NewPostStateLoadedData(this.brandsList,this.modelsList);
}

class NewPostStateError extends NewPostState{
  String message;
  NewPostStateError(this.message);
}

class NewPostStateLoadedBrandModels extends NewPostState{
  List brandModelsList = [];
  NewPostStateLoadedBrandModels(this.brandModelsList);
}

class NewPostStateBrandsSearched extends NewPostState{
  List searchedList;
  NewPostStateBrandsSearched(this.searchedList);
}

class NewPostStateLoadedSearchedBrands extends NewPostState{
  List searchedList;
  NewPostStateLoadedSearchedBrands(this.searchedList);
}



