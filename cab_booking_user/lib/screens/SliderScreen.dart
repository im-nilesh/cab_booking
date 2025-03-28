import 'package:cab_booking_user/Widgets/slider/custom_slider.dart';
import 'package:flutter/material.dart';

class SliderScreen extends StatefulWidget {
  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> slides = [
    {
      "image": "assets/images/Anywhere you are.png",
      "heading": "Book taxi",
      "subheading":
          "Skip the curb hassle. Tap, track, and hail a taxi for a stress-free ride, all on your phone.",
    },
    {
      "image": "assets/images/At anytime.png",
      "heading": "Carpool with others",
      "subheading":
          "Ditch the solo ride! Share your journey with others and unlock a treasure trove of savings.",
    },
    {
      "image": "assets/images/Frame 1.png",
      "heading": "Your ride. Elevated.",
      "subheading":
          "Turn your drive into cash! Share your ride & earn on the go",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: slides.length,
              itemBuilder: (context, index) {
                return CustomSlider(
                  imagePath: slides[index]["image"]!,
                  heading: slides[index]["heading"]!,
                  subheading: slides[index]["subheading"]!,
                );
              },
            ),
          ),

          SizedBox(height: 20),
          if (_currentPage == slides.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to Home Screen
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Get Started", style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
