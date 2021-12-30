import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';

void navigateTo(context, widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false);
}

Widget defaultButton({
  required String text,
  required Function function,
}) {
  return Container(
    width: 200,
    height: 35,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              HexColor('185ADB'),
              HexColor('1597E5'),
            ]),
        color: HexColor('B24080'),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 0.5,
            offset: Offset(0, 1),
          )
        ],
        borderRadius: BorderRadius.circular(8.0)),
    child: MaterialButton(
      onPressed: () {
        function();
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

Widget defaultTextButton({
  required String text,
  required Function function,
  double? size,
  FontWeight? fontWeight,
}) {
  return TextButton(
    onPressed: () {
      function();
    },
    child: Text(text,
        style: TextStyle(
          color: HexColor('1597E5'),
          fontSize: size,
          fontWeight: fontWeight,
        )),
  );
}

Widget defaultTextFormField({
  TextEditingController? controller,
  required String text,
  String? validateText,
  Icon? prefix,
  IconData? suffix,
  Function? suffixFunction,
  obscure = false,
  Color? textColor,
  Color? suffixColor,
  Color? fillColor,
  bool? filled,
}) {
  return SizedBox(
    height: 50.0,
    child: TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: (value) {
        if (value!.isEmpty) {
          return validateText;
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: fillColor,
          filled: filled,
          labelText: text,
          labelStyle: TextStyle(fontSize: 14.0, color: textColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          prefixIcon: prefix,
          suffixIcon: IconButton(
            onPressed: () {
              suffixFunction!();
            },
            icon: Icon(
              suffix,
              color: suffixColor,
            ),
          )),
    ),
  );
}

Widget defaultAddressText({
  required String text,
}) {
  return Text(
    text,
    style: const TextStyle(fontSize: 21.5, fontWeight: FontWeight.w600),
  );
}

Widget defaultOldPriceText({
  required String text,
})
{
  return Text(
    text,
    style: const TextStyle(fontSize: 11,color: Colors.grey,decoration: TextDecoration.lineThrough),
  );
}

Widget clipping({
  String? text,
  String? text2,
}){
  return  ClipPath(
    clipper: ClippingClass(),
    child: Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              HexColor('113CFC'),
              HexColor('1597E5'),
            ]),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(
              text!,
              style: const TextStyle(
                  color: Colors.white, fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Text(
                text2!,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

enum ToastStates {success, error}

void showToast({
  required dynamic text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.black;
      break;
    case ToastStates.error:
      color = Colors.black;
      break;
  }
  return color;
}
