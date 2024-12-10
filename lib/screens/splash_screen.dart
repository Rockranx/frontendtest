import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';  // Import flutter_svg

import 'input_name_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the Input Name Screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const InputNameScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Black background
      body: Stack(
        children: [
          // Center the content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Use SVG logo
                SvgPicture.string(
                  '''
                    <svg width="188" height="188" viewBox="0 0 188 188" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path d="M93.8745 56.4C104.667 56.4 114.398 60.917 121.259 68.1528L124.659 64.9003H133.21L138.768 69.1505L128.494 79.1273C130.429 83.6328 131.5 88.5928 131.5 93.8014C131.5 114.458 114.654 131.203 93.8745 131.203C83.4701 131.203 74.052 127.005 67.2409 120.22L63.0901 123.978H54.9665L50.2633 118.877L59.7446 109.566C57.5016 104.775 56.2492 99.4337 56.2492 93.8014C56.2492 73.1452 73.0946 56.4 93.8745 56.4ZM116.732 90.5469L101.998 104.852H96.8674L92.5918 102.302H87.0335L78.0069 110.473C82.144 114.365 87.7288 116.752 93.8745 116.752C106.626 116.752 116.963 106.477 116.963 93.8014C116.963 92.6966 116.884 91.6101 116.732 90.5469ZM43.4908 74.3087C43.9696 73.9007 44.7906 74.3087 44.7906 74.9207V79.6809C44.7906 80.7689 44.2433 81.857 43.4908 82.537L32.7505 92.2613L43.4224 101.986C44.2433 102.666 44.7906 103.754 44.7906 104.842V109.602C44.7906 110.214 43.9696 110.622 43.4908 110.214L27.6197 95.8655C26.8672 95.2535 26.3199 94.0974 26.3199 93.0774V91.5133C26.3199 90.4933 26.8672 89.3372 27.6197 88.6572L43.4908 74.3087ZM142.114 74.9207C142.114 74.3087 142.935 73.9007 143.414 74.3087L159.285 88.6572C160.037 89.3372 160.585 90.4933 160.585 91.5133V93.0774C160.585 94.0974 160.037 95.2535 159.285 95.8655L143.414 110.214C142.935 110.622 142.114 110.214 142.114 109.602V104.842C142.114 103.754 142.661 102.666 143.482 101.986L154.154 92.2613L143.414 82.537C142.661 81.857 142.114 80.7689 142.114 79.6809V74.9207ZM93.8745 70.8506C81.1232 70.8506 70.7862 81.126 70.7862 93.8014C70.7862 95.3371 70.938 96.8376 71.2274 98.2889L85.7508 84.0261H92.5918L96.8674 86.5762H101.998L110.783 78.1727C106.567 73.6682 100.552 70.8506 93.8745 70.8506Z" fill="white"/>
                    </svg>
                  ''',  // Paste the SVG path directly as a string
                  width: 188,
                  height: 188,
                ),
              ],
            ),
          ),
          // Loader at the bottom
          Positioned(
            bottom: 30, // Add margin to the bottom of the screen
            left: MediaQuery.of(context).size.width * 0.14, // Align to 14% from the left
            right: MediaQuery.of(context).size.width * 0.14, // Align to 14% from the right
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Loader color
              backgroundColor: Colors.grey.withOpacity(0.3), // Background color of the loader
              minHeight: 6, // Thickness of the loader
            ),
          ),
        ],
      ),
    );
  }
}
