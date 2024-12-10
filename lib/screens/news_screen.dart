import 'dart:convert'; // For decoding JSON data
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // For formatting date and time
import 'package:url_launcher/url_launcher.dart'; // For opening URLs

class NewsScreen extends StatefulWidget {
  final String userName;

  const NewsScreen({super.key, required this.userName});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final String apiUrl =
      "https://finnhub.io/api/v1/news?category=general&token=crals9pr01qhk4bqotb0crals9pr01qhk4bqotbg";

  List<dynamic>? _newsArticles; // Null initially to check loading state
  String? _errorMessage; // Holds error message if request fails

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data is List) {
          // Assuming the API returns a list of articles
          setState(() {
            _newsArticles = data;
            _errorMessage = null; // Clear any previous error messages
          });
        } else {
          throw "Unexpected data format"; // Handle non-list responses
        }
      } else {
        throw "Failed to fetch news. Status code: ${response.statusCode}";
      }
    } catch (e) {
      setState(() {
        _newsArticles = null;
        _errorMessage = "Something went wrong. Please try again later."; // Set error message
      });
    }
  }

  String _formatDate(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('yyyy-MM-dd – hh:mm a').format(date);
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000), // Black background for entire screen
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Updated background and text color for greeting
            Container(
              color: const Color(0xFF05021B), // Background color for greeting
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hey ${widget.userName}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text
                    ),
                  ),
                  if (_errorMessage != null) // Display error message if it exists
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white, // White text for error message
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (_newsArticles == null && _errorMessage == null)
              // Show loading indicator if fetching data
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (_errorMessage != null)
              // Show a retry button if there's an error
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: _fetchNews,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF523AE4), // Same color as the input name page submit button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Button shape
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16), // Button padding
                    ),
                    child: const Text(
                      "Retry",
                      style: TextStyle(color: Colors.white), // White text for retry button
                    ),
                  ),
                ),
              )
            else
              // Display the articles
              Expanded(
                child: ListView.builder(
                  itemCount: _newsArticles?.length ?? 0,
                  itemBuilder: (context, index) {
                    var article = _newsArticles![index];
                    String articleDate = _formatDate(article['datetime']);

                    return Card(
                      color: const Color(0xFF000000), // Black background for article cards
                      margin: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => _launchURL(article['url']),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Icon or Image
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: article['image'] != null
                                  ? Image.network(
                                      article['image'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(
                                      Icons.article,
                                      size: 80,
                                      color: Colors.white, // White icon
                                    ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Source and Date
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          article['source'] ?? 'Unknown Source',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFFFFFFB2), // Source font color
                                          ),
                                        ),
                                        Text(
                                          articleDate,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFFFFFFB2), // Date font color
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    // Headline
                                    Text(
                                      article['headline'] ?? 'No Title',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white, // Headline font color
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
