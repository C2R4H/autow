import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../brands_model.dart';
import '../../automobiles_model.dart';
import '../../newPost_model.dart';

part 'newPost_state.dart';
part 'newPost_event.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  NewPostBloc() : super(NewPostState()) {
    NewPost_model newPost_model = NewPost_model();
    //List enginesList;
    Brands brands_list = Brands();
    Automobiles automobiles_list = Automobiles();

    List brandList = [];
    List modelsList = [];

    on<NewPostEventLoadData>((event, emit) async {
      emit(NewPostStateLoading());
      await brands_list.readBrands().then((brands) async {
        if (brands != []) {
          brandList = brands;
          await automobiles_list.readBrands().then((models) {
            if (models != []) {
              emit(NewPostStateLoadedData(brands, models));
              modelsList = [];
            } else {
              emit(NewPostStateError('Failed to load models list'));
            }
          });
        } else {
          emit(NewPostStateError('Failed to load brands list'));
        }
      });
    });

    on<NewPostEventLoadBrandModels>((event, emit) async {
      emit(NewPostStateLoading());
      List brandModelsList = [];
      for (int i = 0; i < event.modelsList.length; i++) {
        if (event.modelsList[i]["brand_id"] == event.brandID) {
          brandModelsList.add(event.modelsList[i]);
        }
      }
      if (brandModelsList != []) {
        emit(NewPostStateLoadedBrandModels(brandModelsList));
      }
    });

    on<NewPostEventBrandCopyWith>((event, emit) async {
      List searchResults = [];
      emit(NewPostStateLoading());
      if (event.text != "") {
        for (int i = 0; i < brandList.length; i++) {
          if (brandList[i]["name"].toLowerCase().contains(event.text)) {
            searchResults.add(brandList[i]);
          }
          emit(NewPostStateBrandsSearched(searchResults));
        }
      } else {
        searchResults = brandList;
        emit(NewPostStateLoadedData(searchResults, modelsList));
      }
    });

    on<NewPostEventBrandChoose>((event, emit) {
      print(event.brandID);
      print(event.brand);
      emit(NewPostStateAddData(choosedBrand: event.brandID,choosedBrandName: event.brand));
    });
    on<NewPostEventModelChoose>((event, emit) {
      newPost_model.model = event.model;
    });
    on<NewPostEventYearChoose>((event, emit) {
      newPost_model.year = event.year;
    });
  }
}
