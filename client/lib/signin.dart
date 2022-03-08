import 'package:flutter/material.dart';
import 'package:pfe/model/Etudiant.dart';
import 'package:http/http.dart' as http;
import 'package:pfe/model/Societe.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _formKey = GlobalKey<FormState>();
  Etudiant etd =Etudiant('', '');
  Societe soc = Societe('', '');

  Future save(String user) async {
    if(user=="etudiant")
    {
    var res = await http.post(Uri.parse("http://192.168.1.4:5000/etudiant/login"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': etd.email,
          'password': etd.password
        });
    print(res.body);
    
   Navigator.pushNamed(context, '/AccueilEtd');
   }else if(user=="societe")
   {
         var res = await http.post(Uri.parse("http://192.168.1.4:5000/societe/login"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': soc.email,
          'password': soc.password
        });
    print(res.body);
    
   Navigator.pushNamed(context, '/AccueilSoc');
   }
  }
  

  @override
  Widget build(BuildContext context) {
String getUser()
{
  String? route=ModalRoute.of(context)?.settings.name;
  print(route);
  String user='';
  for(int i=7;i<route!.length;i++)
  {user+=route[i];}
  return user;
}
print(getUser());

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key:_formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: TextEditingController(text: etd.email),
                              onChanged: (value){
                                etd.email=value;
                              },
                              validator: (value){
                              if (value!.isEmpty) {
                                  return 'Enter something';
                                } else if (RegExp( r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                 .hasMatch(value)) {
                                 return null;
                                 } else {
                                   return 'Enter valid email';
                               }
                                },
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: TextEditingController(text: etd.password),
                  
                              onChanged: (value) {
                              etd.password = value;
                               },
                              validator: (value) {
                              if (value!.isEmpty) {
                               return 'Enter something';
                               }
                              return null;
                                    },
                              style: TextStyle(),
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 27, fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                
                                        onPressed: () {
                       
                                          if (_formKey.currentState!.validate()) {
                                             save(getUser());
                                             print('ok');
                                          } else {
                                          print("not ok");
                                                }
                                                },
                                     
                                      icon: Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                  child: Text(
                                    'Sign Up',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18),
                                  ),
                                  style: ButtonStyle(),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }}