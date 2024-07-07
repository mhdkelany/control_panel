import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/modules/all_product_screen.dart';
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
                  surfaceTintColor: Colors.white,
                  elevation: 1,
                  title:const Text(
                    'لوحة التحكم',
                    style: TextStyle(
                        fontFamily: 'tajawal-bold'
                    ),
                  ),

                  bottom: TabBar(
                    dividerColor: Colors.grey.withOpacity(0.5),
                      indicatorPadding: EdgeInsets.only(bottom: 5),
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
                drawer: Drawer(
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                    'لوحة التحكم',
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    'خيارات اللوحة',
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ListTile(title: Text('نسبة الربح'),leading: Icon(Icons.percent_rounded),onTap: ()
                      {
                        ControlPanelCubit.get(context).getPercent();
                        navigateTo(context, PercentScreen());
                      },),
                      ListTile(title: Text('جميع المنتجات'),leading: Icon(Icons.production_quantity_limits),onTap: ()
                      {
                        ControlPanelCubit.get(context).getAllProducts();
                        navigateTo(context, AllProductsScreen());
                      },),
                    ],
                  ),
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
