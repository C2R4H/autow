import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../midend/automobiles_model.dart';
import '../../../../midend/bloc/newPost_bloc/newPost_bloc.dart';

class automobiles extends StatefulWidget {
  int autoID;
  String brandName;
  automobiles(this.autoID, this.brandName);
  automobiles_state createState() => automobiles_state();
}

class automobiles_state extends State<automobiles> {
  NewPostBloc _newPostBloc = NewPostBloc();
  void initState() {
    _newPostBloc.add(NewPostEventLoadModels());
    super.initState();
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
      body: BlocProvider(
          create: (context) => _newPostBloc,
          child: BlocListener<NewPostBloc, NewPostState>(
        listener: (context, state) {
          if(state is NewPostStateLoadedModels){
            _newPostBloc.add(NewPostEventLoadBrandModels(state.modelsList,widget.autoID));
          }
        },
        child: 
              BlocBuilder<NewPostBloc, NewPostState>(builder: (context, state) {
            if (state is NewPostStateLoading) {
              return Center(
                child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white),
              );
            }
            if (state is NewPostStateLoadedBrandModels) {
              return ListView.builder(
                  itemCount: state.brandModelsList.length,
                  itemBuilder: (context, index) {
                    String carname = state.brandModelsList[index]["name"]
                        .substring(widget.brandName.length);
                    if (state.brandModelsList[index]["brand_id"] == widget.autoID) {
                      return Container(
                        child: ListTile(
                          shape: Border(
                            bottom:
                                BorderSide(width: 1, color: Color(0xff212121)),
                          ),
                          onTap: () {},
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
      ),
      /*body: Container(
        child: widget.automobilesList.isNotEmpty
            ? ListView.builder(
                itemCount: widget.automobilesList.length,
                itemBuilder: (context, index) {
                  String carname = widget.automobilesList[index]["name"].substring(widget.brandName.length);
                  if (widget.automobilesList[index]["brand_id"] == widget.autoID) {
                    start = true;
                    return Container(
                      child: ListTile(
                        shape: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xff212121)),
                        ),
                        onTap: () {},
                        title: Text(carname),
                      ),
                    );
                  }
                  return Container();
                })
            : Container(),
      ),*/
    );
  }
}
