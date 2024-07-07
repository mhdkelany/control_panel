import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/layout/home_layout.dart';
import 'package:control_panel/shared/components/components.dart';
import 'package:control_panel/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ControlPanelCubit,ControlPanelStates>(
      listener: (context,state)
      {
        if(state is CheckSocketState)
          {
            ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('لا يوجد اتصال باﻷنترنت'), Colors.amber, Duration(seconds: 5)));

          }
        if(state is AddTokenSuccessState)
          {
            navigateToEnd(context, HomeLayout());
          }
      },
      builder: (context,state)
      {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Lottie.asset('assets/lottie/get2.json' ),
                      Text(
                          'اهلاً وسهلاً بك في لوحة التحكم',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16
                          )
                      ),

                     // Spacer(),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*0.09,
                        child: ElevatedButton(
                            onPressed:state is AddTokenLoadingState?null: ()
                            {
                              ControlPanelCubit.get(context).getStarted();
                            },
                            style: ButtonStyle(
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ابدأ الان',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.arrow_circle_left_outlined)
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
