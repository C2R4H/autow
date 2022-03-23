part of 'newPost_bloc.dart';

class NewPostState{
}

class NewPostStateInitialize extends NewPostState{} 

class NewPostStateLoading extends NewPostState{}

class NewPostStateLoadedBrands extends NewPostState{
  List brandsList;
  NewPostStateLoadedBrands(this.brandsList);
}

class NewPostStateLoadedModels extends NewPostState{
  List modelsList;
  NewPostStateLoadedModels(this.modelsList);
}

class NewPostStateLoadedBrandModels extends NewPostState{
  List brandModelsList;
  NewPostStateLoadedBrandModels(this.brandModelsList);
}

class NewPostStateError extends NewPostState{
  String error;
  NewPostStateError(this.error);
}
