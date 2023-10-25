// import 'package:flutter/material.dart';

// class Practice extends StatefulWidget {
//   const Practice({super.key});

//   @override
//   State<Practice> createState() => _PracticeState();
// }

// class _PracticeState extends State<Practice> {

// final name=TextEditingController();
// final age=TextEditingController();

// List<Map<String,dynamic>> userinfo=[];


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(''),),
// body: Column(
//   children: [
// TextField(
//   controller:name ,

// ),

// TextField(
//   controller:age ,

// ),

// ElevatedButton(onPressed: (){
//   for(int i=0; i<=userinfo.length;i++){
//     if(userinfo.contains(userinfo[i]["name":name.text])){

//     }
//   }
  

 
//     userinfo.add({"name":name.text,"age":age.text});
//   name.clear();
//   age.clear();

  
//   setState(() {
    
//   });
 
// }, child: Text("submit")),
// Expanded(
//   child:   ListView.builder(
  
//     itemCount: userinfo.length,
  
//     itemBuilder: (context,index){
  
//       return Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
  
//           Text("${index+1} ${userinfo[index]["name"]}" ),
//           GestureDetector(child: Icon(Icons.delete),
//           onTap: (){
//             userinfo.removeAt(index);
//             setState(() {
              
//             });
//           },)
  
          
  
//         ],
  
//       );
  
  
  
//   }),
// )
//   ]
// )



//     );
//   }
// }