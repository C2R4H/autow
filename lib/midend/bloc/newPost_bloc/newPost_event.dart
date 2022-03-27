part of 'newPost_bloc.dart';

class NewPostEvent {
  const NewPostEvent();
}

class NewPostEventLoadData extends NewPostEvent{}

class NewPostEventLoadBrandModels extends NewPostEvent{
  List modelsList;
  int brandID;
  NewPostEventLoadBrandModels(this.modelsList,this.brandID);
}

class NewPostEventBrandCopyWith extends NewPostEvent{
  final String text;
  const NewPostEventBrandCopyWith(this.text);
}

class NewPostEventBrandChoose extends NewPostEvent{
  final String brand;
  final int brandID;
  const NewPostEventBrandChoose(this.brand,this.brandID);
}

class NewPostEventModelChoose extends NewPostEvent{
  final String model;
  const NewPostEventModelChoose(this.model);
}

class NewPostEventYearChoose extends NewPostEvent{
  final String year;
  const NewPostEventYearChoose(this.year);
}

