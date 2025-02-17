import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../model/top_news_model.dart';
import '../../routes/app_routes_name.dart';
import '../../view_model/home_view_model/home_view_model.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All News'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Consumer<HomeNewsProviderViewModel>(builder: (context, model, _) {
        return FutureBuilder<TopNewsModel>(
          future: model.getPopularNewsApiRepo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return ListView.builder(
                itemCount: data.articles!.length,
                itemBuilder: (context, index) {
                  return _buildNewsCard(context, index, data);
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      }),
    );
  }

  // Method to build the news card
  Widget _buildNewsCard(BuildContext context, int index, TopNewsModel data) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          print((data.articles![index]).runtimeType);
          context.push(AppRouteNames.newsdetails, extra: data.articles![index]);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                data.articles![index].urlToImage ??
                    'https://via.placeholder.com/150', // Fallback image URL
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.articles![index].title ??
                        "Title not available", // Use article title
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.articles![index].description ??
                        "Description not available", // Use article description
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
