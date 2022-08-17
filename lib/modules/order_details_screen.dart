import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/modules/map_screen.dart';
import 'package:control_panel/shared/components/components.dart';
import 'package:control_panel/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<ControlPanelCubit,ControlPanelStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              titleSpacing: 0,
              title: Text(
                'التفاصيل',
                style: TextStyle(
                    fontFamily: 'tajawal-bold'
                ),
              ),
              actions: [
                Row(
                  children: [
                    Text(
                      'مجموع الفاتورة :',
                      style: TextStyle(
                        color: Colors.black
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${ControlPanelCubit.get(context).totalPrice} د.أ',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontFamily: 'tajawal-bold',
                      ),
                    )
                  ],
                )
              ],
            ),
            body: ConditionalBuilder(
              builder: (context)=>Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListView.separated(
                        itemBuilder: (context,index)=>Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'اسم المنتج :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${ControlPanelCubit.get(context).billDetailsModel!.details[index].productName}',
                                          style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'السعر :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${ControlPanelCubit.get(context).billDetailsModel!.details[index].price} د.أ',
                                          style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'الكمية :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${ControlPanelCubit.get(context).billDetailsModel!.details[index].quantity}',
                                          style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        Text('صاحب المنتج :',style: TextStyle(
                                          fontSize: 18
                                        ),),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${ControlPanelCubit.get(context).billDetailsModel!.details[index].productOwnerName}',
                                          style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        Text('الرقم :',style: TextStyle(fontSize: 18),),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${ControlPanelCubit.get(context).billDetailsModel!.details[index].productOwnerPhone}',
                                          style: TextStyle(
                                              color: primaryColor
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: MediaQuery.of(context).size.height*0.05,
                                      child: TextButton(
                                          onPressed: ()
                                          {
                                            ControlPanelCubit.get(context).lat=double.tryParse(ControlPanelCubit.get(context).billDetailsModel!.details[index].productOwnerLat!);
                                            ControlPanelCubit.get(context).lng=double.tryParse(ControlPanelCubit.get(context).billDetailsModel!.details[index].productOwnerLng!);
                                            ControlPanelCubit.get(context).initialMap();
                                            navigateTo(context, MapScreen());
                                          },
                                          child: Text('اضغط هنا لرؤية الموقع')
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Expanded(
                                  child: Text(
                                    '${ControlPanelCubit.get(context).billDetailsModel!.details[index].sumPrice} د.أ',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 20,
                                      fontFamily: 'tajawal-bold',
                                    ),
                                    maxLines: 1,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        separatorBuilder: (context,index)=>SizedBox(height: 5,),
                        itemCount: ControlPanelCubit.get(context).billDetailsModel!.details.length
                    ),
                  ),
                  Expanded(

                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              height: MediaQuery.of(context).size.height*0.30,
                              child: Column(
                                children: [
                                  Text('صاحب الطلب'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.person,color: Colors.grey,size: 20,),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${ControlPanelCubit.get(context).billDetailsModel!.details[0].billOwnerName}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                fontSize: 16
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.phone,color: Colors.grey,size: 20,),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${ControlPanelCubit.get(context).billDetailsModel!.details[0].billOwnerPhone}',
                                              style: TextStyle(
                                                  color: primaryColor
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,color: Colors.grey,size: 20,),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            if(ControlPanelCubit.get(context).placeOwnerBill!=null)
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.40,
                                                child: Text(
                                                  '${ControlPanelCubit.get(context).placeOwnerBill!.locality!}, ${ControlPanelCubit.get(context).placeOwnerBill!.street!},${ControlPanelCubit.get(context).placeOwnerBill!.postalCode!},${ControlPanelCubit.get(context).placeOwnerBill!.subLocality!}',
                                                  style: TextStyle(
                                                      color: Colors.black
                                                  ),
                                                  maxLines: 3,
                                                ),
                                              ),
                                            if(ControlPanelCubit.get(context).placeOwnerBill==null)
                                              Text(
                                                'جاري تحميل...',
                                                style: TextStyle(
                                                    color: Colors.black
                                                ),
                                              )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  TextButton(
                                      onPressed: ()
                                      {
                                        ControlPanelCubit.get(context).lat=double.tryParse(ControlPanelCubit.get(context).billDetailsModel!.details[0].billOwnerLat!);
                                        ControlPanelCubit.get(context).lng=double.tryParse(ControlPanelCubit.get(context).billDetailsModel!.details[0].billOwnerLng!);
                                        ControlPanelCubit.get(context).initialMap();
                                        navigateTo(context, MapScreen());
                                      },
                                      child: Text('اضغط هنا لرؤية الموقع')
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(15)
                        //       ),
                        //       height: MediaQuery.of(context).size.height*0.30,
                        //       child: Column(
                        //         children: [
                        //           Text('صاحب المنتج'),
                        //           SizedBox(
                        //             height: 10,
                        //           ),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Row(
                        //                 children: [
                        //                   Icon(Icons.person,color: Colors.grey,size: 20,),
                        //                   SizedBox(
                        //                     width: 5,
                        //                   ),
                        //                   Text(
                        //                     '${ControlPanelCubit.get(context).billDetailsModel!.details[0].productOwnerName}',
                        //                     style: TextStyle(
                        //                         color: Colors.black
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               Row(
                        //                 children: [
                        //                   Icon(Icons.phone,color: Colors.grey,size: 20,),
                        //                   SizedBox(
                        //                     width: 5,
                        //                   ),
                        //                   Text(
                        //                     '${ControlPanelCubit.get(context).billDetailsModel!.details[0].productOwnerPhone}',
                        //                     style: TextStyle(
                        //                         color: primaryColor
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               Row(
                        //                 children: [
                        //                   Icon(Icons.location_on,color: Colors.grey,size: 20,),
                        //                   SizedBox(
                        //                     width: 5,
                        //                   ),
                        //                   if(ControlPanelCubit.get(context).placeOwnerProduct!=null)
                        //                     Container(
                        //                       width: MediaQuery.of(context).size.width*0.30,
                        //                       child: Text(
                        //                           '${ControlPanelCubit.get(context).placeOwnerProduct!.locality!}, ${ControlPanelCubit.get(context).placeOwnerProduct!.street!},${ControlPanelCubit.get(context).placeOwnerProduct!.postalCode!},${ControlPanelCubit.get(context).placeOwnerProduct!.subLocality!}',
                        //                         style: TextStyle(
                        //                           color: Colors.black
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   if(ControlPanelCubit.get(context).placeOwnerProduct==null)
                        //                   Text(
                        //                     'جاري تحميل...',
                        //                     style: TextStyle(
                        //                         color: Colors.black
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //           Spacer(),
                        //           TextButton(
                        //               onPressed: (){},
                        //               child: Text('اضغط هنا لرؤية الموقع')
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
              condition: ControlPanelCubit.get(context).billDetailsModel!=null,
            ),
          );
        },
      ),
    );
  }
}
