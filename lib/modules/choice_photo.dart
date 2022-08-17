import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/modules/map_screen.dart';
import 'package:control_panel/shared/components/components.dart';
import 'package:control_panel/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewWish extends StatelessWidget {
  const ViewWish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ControlPanelCubit,ControlPanelStates>(
      listener: (context,state)
      {
        if(state is CheckSocketState)
          {
            ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('لا يوجد اتصال باﻷنترنت'), Colors.amber, Duration(seconds: 5)));
          }
      },
      builder: (context,state)
      {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            body:ConditionalBuilder(
              builder: (context)=>ListView.separated(
                  itemBuilder: (context,index)
                  {
                    if(ControlPanelCubit.get(context).wishModel!.wishes.length==0)
                      return Center(child: Text(
                          'لا يوجد طلبات لعرضها',
                        style: TextStyle(
                          color: Colors.grey[300],
                              fontSize: 30
                        ),
                      ),);
                    else{
                      return  Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction)
                        {
                          if(direction==DismissDirection.startToEnd)
                            {
                              print(true);
                              ControlPanelCubit.get(context).changeStateForWish(true, int.tryParse(ControlPanelCubit.get(context).wishModel!.wishes[index].idWish!)!);
                            }
                          if(direction==DismissDirection.endToStart)
                            {
                              print(false);
                              ControlPanelCubit.get(context).changeStateForWish(false, int.tryParse(ControlPanelCubit.get(context).wishModel!.wishes[index].idWish!)!);
                            }
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.red,
                          child: Icon(Icons.delete_forever,color: Colors.white,size: 30,),
                        ),
                        secondaryBackground:Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.green,
                          child: Icon(Icons.archive_sharp,color: Colors.white,size: 30,),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: Column(
                              children:
                              [
                                Row(
                                  children: [
                                    Text(
                                      'الاسم: ',
                                      style: Theme.of(context).textTheme.caption!.copyWith(
                                          fontSize: 20,
                                          fontFamily: 'tajawal-bold'
                                      ),
                                    ),
                                    Text(
                                      '${ControlPanelCubit.get(context).wishModel!.wishes[index].name}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'tajawal-light',
                                          fontSize: 16
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'الرقم: ',
                                      style: Theme.of(context).textTheme.caption!.copyWith(
                                          fontSize: 20,
                                          fontFamily: 'tajawal-bold'
                                      ),
                                    ),
                                    Text(
                                      '${ControlPanelCubit.get(context).wishModel!.wishes[index].phone}',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontFamily: 'tajawal-light',
                                          fontSize: 16
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'الطلب: ',
                                      style: Theme.of(context).textTheme.caption!.copyWith(
                                          fontSize: 20,
                                          fontFamily: 'tajawal-bold'
                                      ),
                                    ),
                                    Text(
                                      '${ControlPanelCubit.get(context).wishModel!.wishes[index].wish}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'tajawal-light',
                                          fontSize: 16
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'الموقع: ',
                                      style: Theme.of(context).textTheme.caption!.copyWith(
                                          fontSize: 20,
                                          fontFamily: 'tajawal-bold'
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: ()
                                        {
                                          ControlPanelCubit.get(context).lat=double.tryParse(ControlPanelCubit.get(context).wishModel!.wishes[index].lat!);
                                          ControlPanelCubit.get(context).lng=double.tryParse(ControlPanelCubit.get(context).wishModel!.wishes[index].lng!);
                                          ControlPanelCubit.get(context).initialMap();
                                          navigateTo(context, MapScreen());
                                        },
                                        child: Text('انقر لعرض الموقع')
                                    )
                                  ],
                                ),
                              ]
                          ),
                        ),
                      );
                    }
                  },
                  separatorBuilder: (context,index)=>Container(width: double.infinity,height: 1,color: Colors.grey[300],),
                  itemCount: ControlPanelCubit.get(context).wishModel!.wishes.length
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
              condition: ControlPanelCubit.get(context).wishModel!=null,
            )
          ),
        );
      },
    );
  }
}
