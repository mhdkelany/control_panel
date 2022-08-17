import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:control_panel/layout/cubit/cubit.dart';
import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/shared/components/components.dart';
import 'package:control_panel/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

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
        return Scaffold(
          body: ConditionalBuilder(
            builder: (context)=>ListView.separated(
                itemBuilder: (context,index)=>Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${ControlPanelCubit.get(context).usersModel!.userInformation[index].name}',
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              if(ControlPanelCubit.get(context).usersModel!.userInformation[index].userType=='0')
                                Text(
                                  'تاجر',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              if(ControlPanelCubit.get(context).usersModel!.userInformation[index].userType=='1')
                                Text(
                                  'صاحب محل',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${ControlPanelCubit.get(context).usersModel!.userInformation[index].phone}',
                            style: TextStyle(
                                color: primaryColor
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width*0.23,
                        child: MaterialButton(
                          onPressed: ()
                          {
                            ControlPanelCubit.get(context).changeUserStatus(int.tryParse(ControlPanelCubit.get(context).usersModel!.userInformation[index].idUser!)!);
                          }
                          ,
                          child: Text(
                            ControlPanelCubit.get(context).isActive[ControlPanelCubit.get(context).usersModel!.userInformation[index].idUser]!?'مفعل':'غير مفعل',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12
                            ),
                          ),
                          color:ControlPanelCubit.get(context).isActive[ControlPanelCubit.get(context).usersModel!.userInformation[index].idUser]!?Colors.green:Colors.red ,
                          height: MediaQuery.of(context).size.height*0.054,

                        ),
                      )
                    ],
                  ),
                ),
                separatorBuilder: (context,index)=>Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
                itemCount: ControlPanelCubit.get(context).usersModel!.userInformation.length
            ),
            fallback:(context)=> Center(child: CircularProgressIndicator(),),
            condition: ControlPanelCubit.get(context).usersModel!=null,
          ),
        );
      },
    );
  }
}
