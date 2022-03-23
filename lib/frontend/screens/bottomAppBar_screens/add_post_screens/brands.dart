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

  /*void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }*/

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
        child: Column(
            children: [
              TextField(
              onChanged: (value) => print(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            BlocBuilder<NewPostBloc, NewPostState>(
          builder: (context, state) {
            print(state);
            if (state is NewPostStateLoading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
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
                          bottom:
                              BorderSide(width: 1, color: Color(0xff212121)),
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
                        leading: carLogo(30, state.brandsList[index]["logo"]),
                        trailing: Icon(Icons.arrow_forward_ios,color: Color(0xff313131)),
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
      /*
      body: Container(
        child: brandsList.isNotEmpty
            ? ListView.builder(
                itemCount: brandsList.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: ListTile(
                      shape: Border(
                        bottom: BorderSide(width: 1, color: Color(0xff212121)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => automobiles(
                                  brandsList[index]["id"],
                                  brandsList[index]["name"],
                                  automobilesList)),
                        );
                      },
                      title: Text(brandsList[index]["name"]),
                      leading: carLogo(30, brandsList[index]["logo"]),
                    ),
                  );
                })
            : Container(),
      ),
      */
    );
  }
}
