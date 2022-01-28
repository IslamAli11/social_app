import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/component/constant.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import 'modules/login/login_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
   print(token);

   FirebaseMessaging.onMessage.listen((event) {
     print(event.data.toString());

   });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());

  });



  await CacheHelper.init();
  Widget? widget;



  uId = CacheHelper.getData(key: 'uId');


  if(uId != null){

    widget =  HomeScreen();
  }else
    {
      widget =  LoginScreen();
    }

  BlocOverrides.runZoned(
        () {
      runApp( MyApp(
        startWidget: widget!,
      ));

    },
    blocObserver: SimpleBlocObserver(),
  );



}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>AppCubit()..getUserData()..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.blue,

          ),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,

            ),
          ),
          scaffoldBackgroundColor: Colors.white,

        ),

        home:startWidget,
      ),
    );
  }
}

