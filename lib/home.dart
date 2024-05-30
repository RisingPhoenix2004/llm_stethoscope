import 'package:flutter/material.dart';
import 'package:llm_stethoscope/DLmodel.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(height: 30,),
            ListTile(
              title: Center(child: const Text('Home')),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHome()));},
            ),
            SizedBox(height: 30,),
            ListTile(
              title: Center(child: const Text('DL Model')),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyDLModel()));},
            ),
          ],
        ),
      ),
    );
  }
}
