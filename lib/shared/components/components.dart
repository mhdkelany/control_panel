import 'package:control_panel/layout/cubit/states.dart';
import 'package:control_panel/shared/style/route.dart';
import 'package:flutter/material.dart';

navigateTo(BuildContext context,Widget widget)=>Navigator.push(context,Routes(widget));
navigateToEnd(BuildContext context,Widget widget)=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
SnackBar buildSnackBar(Widget content,Color color,Duration duration)=>SnackBar(
  content: content,
  duration: duration,
  backgroundColor: color,
);
buildDialog(context,ControlPanelStates state)=> showDialog(context: context, builder: (context)=>AlertDialog(

  title: Text('No Internet Connection'),
  content: Text('Turn on the WiFi or Mobil Data'),
  actions: [
    TextButton(onPressed: ()
    {
      if(state is ConnectionErrorState)
      {
        buildDialog(context, state);
        Navigator.pop(context);
      }
    }, child: Text('Ok'))
  ],
));
