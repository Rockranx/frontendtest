import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import the flutter_svg package
import 'package:permission_handler/permission_handler.dart'; // For permission requests
import 'news_screen.dart';

class NotificationScreen extends StatefulWidget {
  final String firstName;
  final String lastName;

  const NotificationScreen({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    _requestNotificationPermission(); // Request permission when screen is loaded
  }

  // Function to request notification permission
  Future<void> _requestNotificationPermission() async {
    final status = await Permission.notification.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      // If permission is denied, request it
      await Permission.notification.request();
    } else if (status.isGranted) {
      print('Notification Permission Granted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Replace the big round icon with the provided SVG
                  SvgPicture.string(
                    '''
                      <svg width="99" height="98" viewBox="0 0 99 98" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M82.1667 27.5625C88.3684 27.5625 93.3958 22.535 93.3958 16.3333C93.3958 10.1316 88.3684 5.10416 82.1667 5.10416C75.965 5.10416 70.9375 10.1316 70.9375 16.3333C70.9375 22.535 75.965 27.5625 82.1667 27.5625Z" fill="#6D59E9"/>
                        <path opacity="0.3" d="M82.1667 32.6667C73.1425 32.6667 65.8334 25.3575 65.8334 16.3333C65.8334 13.3525 66.6908 10.5758 68.12 8.16666H29.0834C17.8134 8.16666 8.66669 17.2725 8.66669 28.5017V52.92V57.0033C8.66669 68.2325 17.8134 77.3383 29.0834 77.3383H35.2084C36.3109 77.3383 37.7809 78.0733 38.475 78.9717L44.6 87.0975C47.295 90.6908 51.705 90.6908 54.4 87.0975L60.525 78.9717C61.3008 77.9508 62.5258 77.3383 63.7917 77.3383H69.9167C81.1867 77.3383 90.3333 68.2325 90.3333 57.0033V30.38C87.9242 31.8092 85.1475 32.6667 82.1667 32.6667Z" fill="#111827"/>
                        <path d="M49.5 49C47.2134 49 45.4167 47.1625 45.4167 44.9167C45.4167 42.6708 47.2542 40.8333 49.5 40.8333C51.7459 40.8333 53.5834 42.6708 53.5834 44.9167C53.5834 47.1625 51.7867 49 49.5 49Z" fill="#111827"/>
                        <path d="M65.8333 49C63.5467 49 61.75 47.1625 61.75 44.9167C61.75 42.6708 63.5875 40.8333 65.8333 40.8333C68.0792 40.8333 69.9167 42.6708 69.9167 44.9167C69.9167 47.1625 68.12 49 65.8333 49Z" fill="#111827"/>
                        <path d="M33.1666 49C30.88 49 29.0833 47.1625 29.0833 44.9167C29.0833 42.6708 30.9208 40.8333 33.1666 40.8333C35.4125 40.8333 37.25 42.6708 37.25 44.9167C37.25 47.1625 35.4533 49 33.1666 49Z" fill="#111827"/>
                      </svg>
                    ''',  // The SVG path string
                    width: 99,  // Adjust the size as needed
                    height: 98, 
                  ),
                  const SizedBox(height: 20),
                  // Updated Text with Emoji Beside it
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Get the most out of Blott ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "✅", // Green check emoji
                        style: TextStyle(fontSize: 24, color: Colors.green),  // Set the color to green and same size
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Allow notifications to stay in the loop with your payments, requests and groups.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Continue Button with Positioned Layout (Docked Button)
            Positioned(
              left: 0,
              right: 0,
              bottom: 30, // Added margin to the bottom to give space
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the News Screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsScreen(
                          userName: "${widget.firstName} ${widget.lastName}",
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF523AE4), // Same as input name page
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24), // Rounded
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
