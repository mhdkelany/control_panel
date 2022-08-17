import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/layout/home_layout.dart';
import 'package:control_panel/modules/splash_screen.dart';
import 'package:control_panel/shared/components/components.dart';
import 'package:control_panel/shared/network/local/cache_helper/cache_helper.dart';
import 'package:control_panel/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
 await Firebase.initializeApp();


FirebaseMessaging.onMessageOpenedApp.listen((event) {
  print(event.notification);
  if(event.notification!.body!=null)
    {
      print('hello');
    }
});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>ControlPanelCubit()..getOrders()..getUsers()..getWish()..getProduct())
      ],
      child: BlocConsumer<ControlPanelCubit,ControlPanelStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              theme: ThemeData(
                  primaryColor: Colors.cyanAccent,
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: Colors.blue,
                    brightness: Brightness.light,
                  ),
                  appBarTheme: const AppBarTheme(
                    backwardsCompatibility: true,
                    color: Colors.white,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.light,
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    elevation: 0.0,
                  ),
                  scaffoldBackgroundColor: Colors.grey[200],
                  textTheme: const TextTheme(
                    caption: TextStyle
                      (
                        fontSize: 14,
                        color: Colors.grey
                    ),
                  ),
                  fontFamily: 'tajawal-medium'
              ),
              home: SplashScreen()
          );
        },
      ),
    );
  }
}

