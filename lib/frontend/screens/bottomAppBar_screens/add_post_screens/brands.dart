import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../midend/brands_model.dart';
import '../../../../midend/automobiles_model.dart';
import '../../../../midend/bloc/newPost_bloc/newPost_bloc.dart';
import '../../../widgets/profilePicture_widget.dart';

import 'automobiles.dart';

class brands extends StatefulWidget {
  brands_state createState() => brands_state();
}

class brands_state extends State<brands> {
  NewPostBloc _newPostBloc = NewPostBloc();
  Automobiles automobiles_model = Automobiles();
  List automobilesList = [];

  void initState() {
    _newPostBloc.add(NewPostEventLoadBrands());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _newPostBloc,
      child: Scaffold(
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => automobiles(
                                            state.searchedList[index]["id"],
                                            state.searchedList[index]["name"],
                                          )),
                                );
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
                if (state is NewPostStateLoadedBrands) {
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => automobiles(
                                            state.brandsList[index]["id"],
                                            state.brandsList[index]["name"],
                                          )),
                                );
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
      ),
    );
  }
}
