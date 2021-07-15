import 'package:chat_application/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'getX_controller.dart';

class ChatRoom extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    TextEditingController searchEditingController=TextEditingController();
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    final MyController getXController=Get.put(MyController());
    List<String> seachedUserDetails=[];
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: width * 0.04),
            child: IconButton(onPressed: (){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>SignIn()));}, icon: Icon(Icons.login))
          ),
        ],
      ),

      body: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: height * .03),
                width: width * .75,
                child: TextField(
                  controller: searchEditingController,
                  decoration: InputDecoration(
                    hintText: "Search User Name...",
                    hintStyle: TextStyle(color: Colors.deepPurple),
                    labelText: AutofillHints.username,
                    focusColor: Colors.greenAccent,
                    labelStyle: TextStyle(color: Colors.purple),
                    focusedBorder: UnderlineInputBorder(
                        borderRadius:BorderRadius.circular(2.0),
                        borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * .03),
                child: IconButton(onPressed: ()
                {
                  getXController.isSearching.value=true;
                  getXController.haveSearchedUser.value=false;
                  getXController.getUserFromFireCloud(searchEditingController.text.toString().trim()).then((value)
                  {
                      print(getXController.userDetails);
                      seachedUserDetails=getXController.userDetails;
                      getXController.isSearching.value=false;
                      getXController.haveSearchedUser.value=true;
                  });
                }, icon: Icon(Icons.youtube_searched_for_rounded)),
              )
            ],
          ),
          Obx(()
              {
                if(getXController.isSearching.value==false && getXController.haveSearchedUser.value==false)
                  return Center(child: Container(margin: EdgeInsets.symmetric(vertical: 50.0),child: Text('No Results Searched Yet')));
                else if(getXController.isSearching.value==true && getXController.haveSearchedUser.value==false)
                  return Center(child: Container(margin: EdgeInsets.symmetric(vertical: 50.0), child: CircularProgressIndicator(),));
                else if(getXController.isSearching.value==false && getXController.haveSearchedUser.value==true)
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Text('${getXController.userDetails.elementAt(1)}',style: TextStyle(fontSize: 15.0),)
                          ),
                        /*TextButton(onPressed: (){getXController.sentMsg(userID);},
                            child: Text('Message'))*/
                      ],
                    );
                else
                  return Center(child: Container(child: Text('Something is Wrong')));
              }
          )
        ],
      ),
    );
  }

}