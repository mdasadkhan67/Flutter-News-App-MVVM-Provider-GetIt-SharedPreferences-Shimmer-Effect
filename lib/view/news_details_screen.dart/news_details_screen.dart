import 'package:flutter/material.dart';
import '../../model/top_news_model.dart';

class NewsDetailsScreen extends StatefulWidget {
  final Articles deatilsData;
  const NewsDetailsScreen({super.key, required this.deatilsData});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final data = widget.deatilsData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Displaying the image or fallback image if null
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  data.urlToImage ?? 'https://via.placeholder.com/600x300',
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 20),

              // Title of the article
              Text(
                data.title ?? 'Title not available',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Author and Published Date row
              Row(
                children: [
                  const Icon(Icons.person, color: Colors.grey, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    data.author ?? 'Author not available',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.calendar_today,
                      color: Colors.grey, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    data.publishedAt ?? 'Date not available',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description of the article
              Text(
                data.description ?? 'No description available.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),

              // Content of the article
              Text(
                data.content ?? 'No content available.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // "Read More" Button (could be used for external links or other actions)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle "Read More" action
                    // You can open a link or another action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Read More',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
