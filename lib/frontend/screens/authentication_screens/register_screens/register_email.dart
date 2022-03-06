part of '../register_screen.dart';

Widget register_email(context, RegisterBloc _registerBloc) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            'Add a email address',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff212121),
            ),
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff272727),
          ),
          child: TextFormField(
            autofillHints: [AutofillHints.email],
            textInputAction: TextInputAction.done,
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            onChanged: (email) {
              _registerBloc.add(RegisterEventEmailChanged(email));
            },
            style: TextStyle(
              color: Colors.white,
            ),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              prefixIcon: Icon(Icons.email_outlined, color: Color(0xffBABABA)),
              hintText: 'Email adress',
              hintStyle: TextStyle(
                color: Color(0xffBABABA),
                fontSize: 15,
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        BlocBuilder<RegisterBloc, RegisterBlocState>(builder: (context, state) {
          if (state is RegisterBlocStateEmailValid) {
            return submite_button(_registerBloc,MediaQuery.of(context).size.width, true);
          }
          if(state is RegisterBlocStateLoading){
            return const CircularProgressIndicator.adaptive();
          }
          return submite_button(_registerBloc,MediaQuery.of(context).size.width, false);
        }),
      ],
    ),
  );
}

Widget submite_button(_registerBloc, screen_width, bool enabled) {
  return TextButton(
      onPressed: enabled
          ? () {
              _registerBloc.add(RegisterEventEmailSubmitted());
            }
          : null,
      style: TextButton.styleFrom(
        primary: Colors.black,
        //backgroundColor: Color(0xff2C528C),
        backgroundColor: enabled ? Color(0xff51A0D5) : Color(0xff2C528C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Container(
        height: 30,
        alignment: Alignment.center,
        width: screen_width,
        child: Text('Register', style: TextStyle(color: Colors.white)),
      ));
}

