import 'dart:convert';

import 'package:bento_arena/admin/function/user_management.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../theme/color.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

DatabaseReference user_presence_status = database.ref('status');

class AdminConsole extends StatefulWidget {
  const AdminConsole({super.key});

  @override
  State<AdminConsole> createState() => _AdminConsoleState();
}

class _AdminConsoleState extends State<AdminConsole> {

  @override
  void initState() {
    //display_user();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: user_presence_status.onValue,
          builder: (context, snapshot){
            if(snapshot.hasError){
              return Center(child: Text('error displaying live user ${snapshot.error}'),);
            }
            else if(snapshot.hasData){
              Map<String, dynamic> user_presence_map = Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);
              List<String> user_uid = user_presence_map.keys.toList();

              return ListView.builder(
                itemCount: user_presence_map.length,
                  padding: EdgeInsets.all(20),
                  itemBuilder: (context, index){
                  String uid = user_uid[index];
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: (){
                        if((user_presence_map[uid]['queue']) ==true){
                          database.ref('status/$uid').update({'queue': false});
                        }
                        else{
                          database.ref('status/$uid').update({'queue': true});
                        }
                      },
                      child: Container(
                        color: (user_presence_map[uid]['state'] == 'online')? AppColors.comfyGreen :AppColors.lighterGreen,
                        padding: const EdgeInsets.all(12),
                        child: ListTile(
                          leading: ((user_presence_map[uid]['queue']) == true)? Icon(Icons.play_circle, color: AppColors.comfyGreenText,): Icon(Icons.pause, color: AppColors.lightGrey),
                          title: ((user_presence_map[uid]['email']) != null)? Text(user_presence_map[uid]['email']) : Text(uid),
                          trailing: DropdownButton<String>(
                            value: (user_presence_map[uid]['bento'] == null)? 'none' :user_presence_map[uid]['bento'],
                              items: const [
                                DropdownMenuItem(child: Text('men-in-black'), value: 'men-in-black',),
                                DropdownMenuItem(child: Text('snow-white'), value: 'snow-white',),
                                DropdownMenuItem(child: Text('none'), value: 'none',)
                              ]
                              /*robot_list.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()*/
                              , onChanged: (new_value){
                            database.ref('status/$uid').update({'bento': new_value});
                          }
                          ),
                        ),
                      ),
                    ),
                  );
                  }
              );
              return Center(child: Text('data exists'));
            }
            else{
              return Center(child: Text('there is no data'),);
            }
          }
      ),
    );
  }
}

