import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class PagePrac extends StatefulWidget {
  const PagePrac({super.key});

  @override
  State<PagePrac> createState() => _PagePracState();
}

class _PagePracState extends State<PagePrac> {

  final controller =PageController();

  List images =["d","s","m"];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(

              itemCount: images.length,

              controller: controller,
              itemBuilder:(context,index){

return Container(
  color:index%2==0? Colors.red:Colors.amber,
);
            } ),
          ),
          SmoothPageIndicator(controller: controller, count: images.length)
        ],
      ),
    );
  }
}

