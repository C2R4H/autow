import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../brands_model.dart';
import '../../automobiles_model.dart';

part 'newPost_state.dart';
part 'newPost_event.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  NewPostBloc() : super(NewPostState()) {
    //List enginesList;
    List autoList;
    Brands brands_list = Brands();
    Automobiles automobiles_list = Automobiles();

    on<NewPostEventLoadBrands>((event, emit) async {
      emit(NewPostStateLoading());

      await brands_list.readBrands().then((brands) async {
        if (brands != []) {
          emit(NewPostStateLoadedBrands(brands));
        } else {
          emit(NewPostStateError('Failed to load list'));
        }
      });
    });

    on<NewPostEventLoadModels>((event, emit) async {
      emit(NewPostStateLoading());
      await automobiles_list.readBrands().then((models) {
        if (models != []) {
          emit(NewPostStateLoadedModels(models));
        } else {
          emit(NewPostStateError('Failed to load list'));
        }
      });
    });

    on<NewPostEventLoadBrandModels>((event, emit) async {
      emit(NewPostStateLoading());
      List brandModelsList = [];
      for(int i = 0;i<event.modelsList.length;i++){
        if(event.modelsList[i]["brand_id"]==event.brandID){
          brandModelsList.add(event.modelsList[i]);
        }
      }
      if(brandModelsList!=[]){
        emit(NewPostStateLoadedBrandModels(brandModelsList));
      }

    });
  }
}
