import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'auth_services.dart';
import 'chat_room.dart';

class SignIn extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()=>SignInState();
}
class SignInState extends State<SignIn>
{
  bool isLoading = false;
  final signInKey=GlobalKey<FormState>();
  TextEditingController emailID=TextEditingController();
  TextEditingController password=TextEditingController();
  AuthService _authService=AuthService();

  @override
  Widget build(BuildContext context)
  {
    callFirebaseAuthAndChangeState() async
    {
      if(signInKey.currentState!.validate())
      {
        setState(() {isLoading=true;});
        await _authService.signIn(emailID.text.toString().trim(), password.text.toString().trim()).then((result)
        {
          print(result);
          setState(() {isLoading=false;});
          if(result!=null)
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ChatRoom()));
          //TODO
        });
      }
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: Text('Home Page'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent
      ),
      body: (isLoading) ?
      Container(child: Center(child: CircularProgressIndicator()))
              :
      Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(image: DecorationImage(image:AssetImage('images/login_background_image.jpg'), fit: BoxFit.cover)),
        child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
            key: signInKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: width * .04,right: width * .04),
                  padding: EdgeInsets.only(top: 3.0),
                  //color: Colors.white,
                  child: TextFormField(
                    validator: (value)
                    {
                      if(value==null || value.isEmpty)
                        return 'No Text';
                      else if((RegExp(r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.)*[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.[a-zA-Z0-9]{2,}$").hasMatch(value)))
                          return 'Wrong Email';
                      else
                        return null;
                      //return (RegExp(r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.)*[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.[a-zA-Z0-9]{2,}$").hasMatch(value!)) ? null:"Enter a Valid Email Id";
                    },
                    autofocus: true,
                    maxLength: 30,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    controller: emailID,
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
                  child: TextFormField(
                    validator: (value)
                    {
                      if(value==null || value.isEmpty)
                        return 'No Password Entered';
                      else
                        return null;
                      //return (value!.isEmpty) ? null : "Password Can't Be Empty";
                    },
                    maxLength: 15,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    controller: password,
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
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {callFirebaseAuthAndChangeState();},
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
                child: Text('Login Now', style: TextStyle(fontSize: height * 0.032,color: Colors.black))
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Not a User?',style: TextStyle(fontSize: height * .025, color: Colors.teal)),
              Container(
                  child: TextButton(
                      child: Text(
                          'SignUp',
                          style: TextStyle(
                              fontSize: height * .023,
                              color: Colors.teal,
                              decoration: TextDecoration.underline)),
                      onPressed: () async {Navigator.pushNamed(context, '/signUp');}
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
