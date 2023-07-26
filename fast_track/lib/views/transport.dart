import 'package:flutter/material.dart';

class TransPort extends StatefulWidget {
  TransPort({Key? key}) : super(key: key);

  @override
  State<TransPort> createState() => _TransPortState();
}

class _TransPortState extends State<TransPort> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        title: const Text("Transport",style: TextStyle(color: Colors.black87,fontSize: 24,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(Radius.circular(10))
          
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.traffic,color: Colors.blue,),
                    Padding(
                      padding: EdgeInsets.only(top:5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Traffic Issue",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          SizedBox(height:5 ,),
                          Text("Heavy traffic,no signal,accidents,others",style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    )
                  ],
                ),
                
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(Radius.circular(10))
          
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.timelapse,color: Colors.blue,),
                    Padding(
                      padding: const EdgeInsets.only(top:5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Bus Time Schedule",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          SizedBox(height:5 ,),
                          Text("Delay,Updates,Others ...............................",style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    )
                  ],
                ),
                
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(Radius.circular(10))
          
                ),
                  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.hiking_rounded,color: Colors.blue,),
                      Padding(
                        padding: const EdgeInsets.only(top:5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Fare Hike",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            SizedBox(height:5 ,),
                            Text("Unusual fare hike,scams,additional charges",style: TextStyle(fontSize: 16,),),
                          ],
                        ),
                      )
                    ],
                  ),
                
                
              ),
            ),
          ),
        ],

      ),
    );
  }
}