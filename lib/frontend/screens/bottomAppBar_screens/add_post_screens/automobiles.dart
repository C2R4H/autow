import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../midend/automobiles_model.dart';
import '../../../../midend/bloc/newPost_bloc/newPost_bloc.dart';

class automobiles extends StatefulWidget {
  int autoID;
  String brandName;
  NewPostBloc _newPostBloc;
  automobiles(this.autoID, this.brandName, this._newPostBloc);
  automobiles_state createState() => automobiles_state();
}

class automobiles_state extends State<automobiles> {
  void initState() {
    super.initState();
  }

  String subtractYear(String modelName) {
    String? year;
    for (int i = modelName.length - 1; i >= 0; i--) {
      if (RegExp(r'^[0-9]+$').hasMatch(modelName[i])) {
        year = modelName.substring(modelName.length - 11, modelName.length);
        break;
      } else if (modelName[i] == "t") {
        year = modelName.substring(modelName.length - 14, modelName.length);
        break;
      }
    }
    return year ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: const Color(0xff212121),
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
        title: Text('Brands'),
        centerTitle: false,
      ),
      body: BlocListener<NewPostBloc, NewPostState>(
        bloc: widget._newPostBloc,
        listener: (context, state) {
          if (state is NewPostStateLoadedData) {
            widget._newPostBloc.add(
                NewPostEventLoadBrandModels(state.modelsList, widget.autoID));
          }
        },
        child:
            BlocBuilder<NewPostBloc, NewPostState>(builder: (context, state) {
          if (state is NewPostStateLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white),
            );
          }
          if (state is NewPostStateLoadedBrandModels) {
            return ListView.builder(
                itemCount: state.brandModelsList.length,
                itemBuilder: (context, index) {
                  String year =
                      subtractYear(state.brandModelsList[index]["name"]);
                  String carname = state.brandModelsList[index]["name"]
                      .substring(widget.brandName.length + 1);
                  carname = carname.substring(0, carname.length - year.length);

                  if (state.brandModelsList[index]["brand_id"] ==
                      widget.autoID) {
                    return Container(
                      child: ListTile(
                        shape: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xff212121)),
                        ),
                        onTap: () {
                          widget._newPostBloc
                              .add(NewPostEventModelChoose(carname));
                          widget._newPostBloc.add(NewPostEventYearChoose(year));
                        },
                        title: Text(carname),
                      ),
                    );
                  }
                  return Container();
                });
          }
          return Container();
        }),
      ),
    );
  }
}
