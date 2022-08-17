import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PercentScreen extends StatelessWidget {
  const PercentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<ControlPanelCubit,ControlPanelStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('نسبة الربح'),
              titleSpacing: 0.0,
            ),
            body:ConditionalBuilder(
              condition: ControlPanelCubit.get(context).percentModel!=null,
              builder: (context)
              {
                if(ControlPanelCubit.get(context).percentModel!.data.length==0)
                  return Center(child: Text('لا يوجد منتجات لعرضها',style: TextStyle(color: Colors.grey,fontSize: 26),),);
                else
                  return  ListView.separated(
                    itemBuilder: (context,index)=>Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Colors.grey)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${ControlPanelCubit.get(context).percentModel!.data[index].name}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'tajawal-light',
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: Colors.grey)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'السعر قبل النسبة:',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'tajawal-light',
                                                color: Colors.grey
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${ControlPanelCubit.get(context).percentModel!.data[index].priceBeforePercent} د.أ',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'tajawal-light',
                                                  color: Colors.red
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'السعر بعد النسبة:',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'tajawal-light',
                                                color: Colors.grey
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${ControlPanelCubit.get(context).percentModel!.data[index].priceAfterPercent} د.أ',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'tajawal-light',
                                                  color: Colors.green
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                    itemCount: ControlPanelCubit.get(context).percentModel!.data.length,
                    separatorBuilder: (context,index)=>SizedBox(height: 8,),
                  );
              },
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
            ),


          );
        },
      ),
    );
  }
}
