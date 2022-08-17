import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/layout/home_layout.dart';
import 'package:control_panel/modules/get_started_screen.dart';
import 'package:control_panel/shared/components/components.dart';
import 'package:control_panel/shared/components/constants/contants.dart';
import 'package:control_panel/shared/network/local/cache_helper/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
     token=CacheHelper.getCacheData(key: 'token');

    return BlocConsumer<ControlPanelCubit,ControlPanelStates>(
      listener: (context,state)
      {
        if(state is ConnectionErrorState)
          {
            buildDialog(context, state);
          }
      },
      builder: (context,state)
      {
        return AnimatedSplashScreen(
          splash:  Lottie.asset(
              'assets/lottie/sp.json',
              fit: BoxFit.cover,
            onWarning: (d)
              {
                print(d);
              }
          ),
          nextScreen:token==null?GetStartedScreen(): HomeLayout(),
          backgroundColor: Colors.white,
          splashIconSize: 200,
          duration: 5000,
          pageTransitionType: PageTransitionType.leftToRight,
        );
      },
    );
  }
}
