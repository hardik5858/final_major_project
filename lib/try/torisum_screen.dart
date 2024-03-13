import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_major_project/backend/variable_data.dart';
import 'package:flutter/material.dart';

class Tourisum extends StatefulWidget {
  const Tourisum({super.key});

  @override
  State<Tourisum> createState() => _TourisumState();
}

class _TourisumState extends State<Tourisum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tourisum Screen"),),
      body:  DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/img.png"),fit: BoxFit.cover
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5,),
              Text("Discover Top Destinations",style: TextStyle(color: Colors.black,fontSize: 20)),
              SizedBox(height: 10,),
              CarouselSlider(
                options:CarouselOptions(
                  height: 200,
                  aspectRatio: 16/9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                ),
                items: [1,2,3,4,5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                              // image: DecorationImage(
                              //   // image: NetworkImage(imageUrl),
                              //   fit: BoxFit.cover,
                              // )
                          ),
                          child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                      );
                    },
                  );
                }).toList(),
              )
            ],
          ),
        ),
      )
        // Rest of your widget tree
    );
  }
}


