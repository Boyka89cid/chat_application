import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'auth_services.dart';

class SignUp extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()=>SignUpState();
}
class SignUpState extends State<SignUp>
{
  //TextEditingController
  TextEditingController newUserName=TextEditingController();
  TextEditingController newEmailID=TextEditingController();
  TextEditingController newPassword=TextEditingController();
  AuthService _authService=AuthService();
  @override
  Widget build(BuildContext context)
  {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: Text('Home Page'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(image:AssetImage('images/login_background_image.jpg'), fit: BoxFit.cover)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: width * .04,right: width * .04),
              padding: EdgeInsets.only(top: 3.0),
              //color: Colors.white,
              child: TextField(
                autofocus: true,
                maxLength: 30,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: newUserName,
                style: TextStyle(color: Colors.tealAccent),
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderRadius:BorderRadius.circular(2.0),
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    focusColor: Colors.greenAccent,
                    hintText: 'Enter Your Username Here',
                    hintStyle: TextStyle(color: Colors.tealAccent),
                    labelText: AutofillHints.username,
                    labelStyle: TextStyle(color: Colors.green)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: width * .04,right: width * .04),
              padding: EdgeInsets.only(top: 3.0),
              //color: Colors.white,
              child: TextField(
                autofocus: true,
                maxLength: 30,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: newEmailID,
                style: TextStyle(color: Colors.tealAccent),
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderRadius:BorderRadius.circular(2.0),
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    focusColor: Colors.greenAccent,
                    hintText: 'Enter Your Email Here',
                    hintStyle: TextStyle(color: Colors.tealAccent),
                    labelText: AutofillHints.email,
                    labelStyle: TextStyle(color: Colors.green)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: width*0.04,right: width*0.04),
              padding: EdgeInsets.only(top: 3.0),
              //color: Colors.white,
              child: TextField(
                maxLength: 15,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: newPassword,
                style: TextStyle(color: Colors.tealAccent),
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderRadius:BorderRadius.circular(2.0),
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    focusColor: Colors.greenAccent,
                    hintText: 'Enter Your Password Here',
                    hintStyle: TextStyle(color: Colors.tealAccent),
                    labelText: AutofillHints.password,
                    labelStyle: TextStyle(color: Colors.green)
                ),
              ),
            ),
            GestureDetector(
              onTap: () async
              {
                print('Clicked');
                _authService.signUp(newUserName.text.toString().trim(),newEmailID.text.toString().trim(), newPassword.text.toString().trim());
              },
              child: Container(
                  width: width * .8,
                  height: height * .08,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: height *.05,left: width * .04,right: width * .04, bottom: height * .02),
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.green, Colors.indigo ,Colors.blueGrey]),
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: Text('Sign Up Now', style: TextStyle(fontSize: height * 0.032,color: Colors.black))
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Already a User?',style: TextStyle(fontSize: height * .025, color: Colors.teal)),
                Container(
                    child: TextButton(
                        child: Text(
                            'SignIn',
                            style: TextStyle(
                                fontSize: height * .023,
                                color: Colors.teal,
                                decoration: TextDecoration.underline)),
                        onPressed: () async {Navigator.pop(context);}
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}