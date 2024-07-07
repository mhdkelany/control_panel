import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/layout/home_layout.dart';
import 'package:control_panel/modules/order_details_screen.dart';
import 'package:control_panel/modules/splash_screen.dart';
import 'package:control_panel/shared/components/components.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (event.notification!.body != null) {
        ControlPanelCubit.get(context).getOrders();
        navigateTo(context, SplashScreen());
      }
    });
    FirebaseMessaging.onMessage.listen((event) {
      print(event.notification);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.infoReverse,
        animType: AnimType.bottomSlide,
        title: 'طلب جديد ',
        desc: 'احد الاشخاص قام بطلب منتجات انقر لعرض الطلب',
        btnOkOnPress: () {
          ControlPanelCubit.get(context).getOrders();
        },
      )..show();
    });
    return BlocConsumer<ControlPanelCubit, ControlPanelStates>(
      listener: (context, state) {
        if (state is OpenAppState) {
          navigateTo(context, OrdersScreen());
        }
        if (state is CheckSocketState) {
          ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
              Text('لا يوجد اتصال باﻷنترنت'),
              Colors.amber,
              Duration(seconds: 5)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            builder: (context) {
              if (ControlPanelCubit.get(context)
                      .allBillModel!
                      .information
                      .length ==
                  0)
                return Center(
                    child: Text(
                  'لا يوجد طلبات بعد',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 20),
                ));
              return ListView.builder(
                  itemBuilder: (context, index) => Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          // if(direction==DismissDirection.startToEnd)
                          //    {
                          //    ControlPanelCubit.get(context).changeStateForOrder(true, int.tryParse(ControlPanelCubit.get(context).allBillModel!.information[index].idBill!)!);
                          //
                          //   }
                          if (direction == DismissDirection.endToStart) {
                            ControlPanelCubit.get(context).changeStateForOrder(
                                false,
                                int.tryParse(ControlPanelCubit.get(context)
                                    .allBillModel!
                                    .information[index]
                                    .idBill!)!);
                          }
                        },
                        direction: DismissDirection.endToStart,
                        background: Container(),
                        secondaryBackground: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.green,
                          child: Icon(
                            Icons.archive_sharp,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            ControlPanelCubit.get(context).getDetailsBill(
                                int.tryParse(ControlPanelCubit.get(context)
                                    .allBillModel!
                                    .information[index]
                                    .idBill!)!);
                            print(ControlPanelCubit.get(context)
                                .allBillModel!
                                .information[index]
                                .idBill!);
                            navigateTo(context, OrderDetailsScreen());
                            ControlPanelCubit.get(context).totalPrice = 0.0;
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 14,
                                      backgroundColor: Colors.grey[300],
                                      child: Text('${index + 1}'),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      'طلب من :',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                          fontFamily: 'tajawal-bold'),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${ControlPanelCubit.get(context).allBillModel!.information[index].billOwnerName}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      'تفاصيل',
                                      style:
                                          Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    const Icon(
                                      Icons.arrow_circle_left_outlined,
                                      color: Colors.grey,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  // separatorBuilder: (context,index)=>const SizedBox(height: 3,),
                  itemCount: ControlPanelCubit.get(context)
                      .allBillModel!
                      .information
                      .length);
            },
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            condition: ControlPanelCubit.get(context).allBillModel != null,
          ),
        );
      },
    );
  }
}
