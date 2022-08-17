import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/modules/choice_photo.dart';
import 'package:control_panel/modules/orders_screen.dart';
import 'package:control_panel/modules/percent_screen.dart';
import 'package:control_panel/modules/product_screen.dart';
import 'package:control_panel/modules/users_screen.dart';
import 'package:control_panel/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
          length: 4,
          child:  BlocConsumer<ControlPanelCubit,ControlPanelStates>(
            listener: (context,state)
            {
              if(state is ConnectionErrorState)
                {
                  buildDialog(context, state);
                }
              if(state is ConnectionSuccessState)
                {
                  ControlPanelCubit.get(context).getProduct();
                  ControlPanelCubit.get(context).getWish();
                  ControlPanelCubit.get(context).getOrders();
                  ControlPanelCubit.get(context).getUsers();
                  ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(Text('تم العودة للأتصال',style: TextStyle(),), Colors.green, Duration(seconds: 5)));
                }
            },
            builder: (context,state)
            {
              return Scaffold(
                appBar: AppBar(
                  elevation: 1,
                  title:const Text(
                    'لوحة التحكم',
                    style: TextStyle(
                        fontFamily: 'tajawal-bold'
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                            onPressed: ()
                            {
                              ControlPanelCubit.get(context).getPercent();
                              navigateTo(context, PercentScreen());
                            },
                            icon: Icon(Icons.percent_sharp,color: Colors.black54,)
                        ),
                      ),
                    )
                  ],
                  bottom:const TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.grey,
                      indicatorWeight: 3,

                      tabs: [
                        Tab(
                          child: Text(
                            'الطلبات',
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'الحسابات',
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'الأمنيات',
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'المنتجات',
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                        ),
                      ]),
                ),
                body: TabBarView(

                    children: [
                      OrdersScreen(),
                      UsersScreen(),
                      ViewWish(),
                      ProductScreen(),
                    ]),
              );
            },
          ),
      ),
    );
  }
}
