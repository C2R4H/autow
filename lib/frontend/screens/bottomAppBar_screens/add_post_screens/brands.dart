import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../midend/brands_model.dart';
import '../../../../midend/automobiles_model.dart';
import '../../../../midend/bloc/newPost_bloc/newPost_bloc.dart';
import '../../../widgets/profilePicture_widget.dart';

import 'automobiles.dart';

class brands extends StatefulWidget {
  NewPostBloc _newPostBloc;
  brands(@required this._newPostBloc);

  brands_state createState() => brands_state();
}

class brands_state extends State<brands> {
  NewPostBloc _newPostBloc = NewPostBloc();
  Automobiles automobiles_model = Automobiles();
  List automobilesList = [];

  @override
  Widget build(BuildContext context) {
      return  Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xff212121),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: TextField(
                onChanged: (value) =>
                    _newPostBloc.add(NewPostEventBrandCopyWith(value)),
                autofocus: true,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusColor: Colors.white,
                    hintText: 'BMW,Audi,Dacia...',
                    prefixIcon: Icon(Icons.search,color: Color(0xff515151))),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            BlocBuilder<NewPostBloc, NewPostState>(
                bloc: widget._newPostBloc,
              builder: (context, state) {
                if (state is NewPostStateLoading) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (state is NewPostStateBrandsSearched) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.searchedList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: ListTile(
                              shape: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xff212121)),
                              ),
                              onTap: () {
                                print('working');
                                _newPostBloc.add(NewPostEventBrandChoose(state.brandsList[index]["name"],state.brandsList[index]["id"]));
                                Navigator.pop(context);
                              },
                              title: Text(state.searchedList[index]["name"]),
                              leading: carLogo(
                                  30, state.searchedList[index]["logo"]),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Color(0xff313131)),
                            ),
                          );
                        }),
                  );
                }
                if (state is NewPostStateLoadedData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.brandsList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: ListTile(
                              shape: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xff212121)),
                              ),
                              onTap: () {
                                _newPostBloc.add(NewPostEventBrandChoose(state.brandsList[index]["name"],state.brandsList[index]["id"]));
                                print('working');
                                print(state.choosedBrand);
                                Navigator.pop(context);
                              },
                              title: Text(state.brandsList[index]["name"]),
                              leading:
                                  carLogo(30, state.brandsList[index]["logo"]),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Color(0xff313131)),
                            ),
                          );
                        }),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
    );
  }
}
