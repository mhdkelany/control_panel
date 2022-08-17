import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_details_screen.dart';

class ProductScreen extends StatelessWidget {
var textController=TextEditingController();
bool isDelete=false;
  @override
  Widget build(BuildContext context) {
    textController.text=7.toString();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<ControlPanelCubit,ControlPanelStates>(
        listener: (context,state)
        {
          if(state is CheckSocketState)
            {
              ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('لا يوجد اتصال باﻷنترنت'), Colors.amber, Duration(seconds: 5)));
            }
          if(state is ChangeStatusProductLoadingState)
          {
            showDialog(context: context, builder: (context)=>Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('جاري المعالجة'),
                      SizedBox(
                        width: 5,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            ));

          }
         else if(state is ChangeStatusProductSuccessState)
            {
              if(!isDelete) {
                ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
                    Text('تم قبول المنتج'), Colors.green,
                    Duration(seconds: 3)));
                Navigator.pop(context);
              }
              if(isDelete)
                ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('تم حذف المنتج'), Colors.red, Duration(seconds: 3)));

            }
        },
        builder: (context,state)
        {
          return Scaffold(
            backgroundColor: Colors.white,
            body:ConditionalBuilder(
              builder: (context)=> ListView.separated(
                  itemBuilder:(context,index)
                  {
                    return  Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction)
                      {
                        if(direction==DismissDirection.startToEnd)
                        {
                          isDelete=true;
                          print(ControlPanelCubit.get(context).productModel!.information[index].idProduct);
                          ControlPanelCubit.get(context).changeStateForProduct(isDelete, int.tryParse(ControlPanelCubit.get(context).productModel!.information[index].idProduct!)!);
                        }
                        if(direction==DismissDirection.endToStart)
                        {
                          isDelete=false;
                          showDialog(context: context, builder: (context)=>Directionality(
                            textDirection: TextDirection.rtl,
                            child: AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      label: Text('ادخل النسبة'),
                                      hintText: 'ادخل النسبة',
                                      border: OutlineInputBorder(
                                      )
                                    ),
                                    keyboardType:  TextInputType.number,
                                    controller:textController ,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(onPressed: ()
                                  {
                                    ControlPanelCubit.get(context).changeStateForProduct(isDelete, int.tryParse(ControlPanelCubit.get(context).productModel!.information[index].idProduct!)!,percent: double.tryParse(textController.text));
                                    Navigator.pop(context);
                                  }, child: Text('تم'))
                                ],
                              ),

                            ),
                          ));
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
                      child: InkWell(
                        onTap: (){
                          navigateTo(context, ProductDetailsScreen(index: index,));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          'صاحب المنتج : ',
                                        style: TextStyle(
                                          fontFamily: 'tajawal-bold',
                                          fontSize: 16
                                        ),
                                      ),
                                      Text(
                                        '${ControlPanelCubit.get(context).productModel!.information[index].userName}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[400]
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'اسم المنتج : ',
                                        style: TextStyle(
                                            fontFamily: 'tajawal-bold',
                                            fontSize: 16
                                        ),
                                      ),
                                      Text(
                                        '${ControlPanelCubit.get(context).productModel!.information[index].productName}',
                                        style: TextStyle(
                                            color: Colors.blue,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios,color: Colors.grey[300],)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context,index)=>Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                  itemCount: ControlPanelCubit.get(context).productModel!.information.length
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
              condition: ControlPanelCubit.get(context).productModel!=null,
            )


          );
        },
      ),
    );
  }
}
