part of 'newPost_bloc.dart';

class NewPostEvent extends Equatable{
  const NewPostEvent();

  @override
  List<Object?> get props => [];
}

class NewPostEventLoadBrands extends NewPostEvent{}

class NewPostEventLoadModels extends NewPostEvent{}

class NewPostEventLoadBrandModels extends NewPostEvent{
  List modelsList;
  int brandID;
  NewPostEventLoadBrandModels(this.modelsList,this.brandID);
}
