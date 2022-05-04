import 'package:flutter/material.dart';

class importerVScreeCv extends StatelessWidget {
  const importerVScreeCv({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
            
      ),
      
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
              height: 300,
            ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
              primary:Color.fromRGBO(100, 80,85,97)  ,
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(25) ),
            ),
            icon: const Icon(Icons.border_color_outlined,size:32),
            label: const Text(
              'Créer votre CV',
              style: TextStyle( color: Colors.white,fontSize: 20)
            ),
            onPressed: (){
            Navigator.pushNamed(context,
            '/createCVPart1');
            },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Ou',
              style: TextStyle( color: Color.fromARGB(255, 255, 255, 255),fontSize: 20)
            ),
            const SizedBox(
              height: 20,
            ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 60,vertical: 20),
              primary: Color.fromRGBO(100, 80,85,97),
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(25) ),
            ),
            icon: const Icon(Icons.check,size:32),
            label: const Text(
              "J'ai un CV",
              style: TextStyle( color: Colors.white,fontSize: 20)
            ),
            onPressed: (){
            Navigator.pushNamed(context,
            '/importerCV');
            },
            ),
        ],
      ))
    );
  }
}