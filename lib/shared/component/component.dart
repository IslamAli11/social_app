 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/layout/home_screen.dart';

Widget defaultTextFormField({
   required String label,
 required IconData prefixIcon,
  IconData? suffixIcon,
  double radius = 10.0,
 required TextInputType keyboard,
  bool obscure = false,
 required Function onTap,
  Function? suffixPress,
  required String?  Function(String?)? validate,
  required TextEditingController controller,
 })=> TextFormField(

  decoration:  InputDecoration(
    labelText:label ,
    prefixIcon:Icon(prefixIcon),
    suffixIcon: IconButton(
      onPressed:(){
        suffixPress!();
      } ,
      icon: Icon(suffixIcon,),
    ),
    border:OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),

    ),
  ),
  keyboardType:keyboard ,
  obscureText: obscure,
  onTap:(){
    onTap;
  } ,
  validator:validate,
  controller:controller ,
);



 Widget defaultTextButton({
   required Function? onPress,
   required String text,
   double? fontSize ,
   FontWeight? fontWeight,
 })=>TextButton(
   onPressed: (){
     onPress!();
   },
   child: Text(
     text,
     style: TextStyle(
       fontSize:fontSize,
       fontWeight:fontWeight,
     ),
   ),
 );

 navigateTo(Widget widget ,context )=>Navigator.push(
      context,
       MaterialPageRoute(builder:(context)=>widget),
  );

 navigateAndRemove(Widget widget , context)=>Navigator.pushAndRemoveUntil(
     context,
     MaterialPageRoute(builder:(context)=>widget),
         (route) => false
 );



 Widget defaultButton({
   required String text,
    required Function? onPress,
    double radius = 5.0,
 })=> Container(
    height: 40.0,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: TextButton(
      onPressed:(){
        onPress!();
      },
      child:  Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
    ),
  );