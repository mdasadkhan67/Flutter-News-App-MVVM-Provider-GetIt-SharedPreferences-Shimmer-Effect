import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package
import '../../model/top_news_model.dart';
import '../../routes/app_routes_name.dart';
import '../../view_model/filer_news_view_model/filer_news_view_model.dart';

class FilterNewsList extends StatefulWidget {
  const FilterNewsList({super.key});

  @override
  State<FilterNewsList> createState() => _FilterNewsListState();
}

class _FilterNewsListState extends State<FilterNewsList> {
  String selectedPublication = '';
  String selectedCountry = '';
  List publicationName = [];
  List author = [];

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProviderNewsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('All News'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          // Date Icon
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () {
              filterProvider.setDate(context);
            },
          ),
          // Other actions...
          IconButton(
            icon: Icon(Icons.public_sharp),
            onPressed: () {
              _showPublicationDialog(publicationName);
            },
          ),
          IconButton(
            icon: Icon(Icons.wrong_location_sharp),
            onPressed: () {
              _showAuthorDialog(author);
            },
          ),
        ],
      ),
      body: Consumer<FilterProviderNewsViewModel>(
        builder: (context, model, _) {
          // Check if loading is true when date is changed
          if (model.isLoading) {
            return _buildShimmerEffect(); // Show shimmer while loading new data
          }

          return FutureBuilder<TopNewsModel>(
            future:
                model.getDataByDate(model.newDate!), // Fetch data based on date
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildShimmerEffect(); // Show shimmer effect
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data == null ||
                  snapshot.data!.articles!.isEmpty) {
                return const Center(child: Text('No Data Found'));
              } else {
                final data = snapshot.data!;
                return ListView.builder(
                  itemCount: data.articles!.length,
                  itemBuilder: (context, index) {
                    publicationName.add(data.articles![index].source!.name);
                    author.add(data.articles![index].author ?? "Not Author");
                    return _buildNewsCard(context, index, data);
                  },
                );
              }
            },
          );
        },
      ),
    );
  }

  // Shimmer effect while loading
  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 5, // Show 5 placeholder items while loading
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  color: Colors.white,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 200,
                        height: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
                    data.articles![index].title ?? "Title not available",
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
                        "Description not available",
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

  // Dialog for selecting Publication
  Future<void> _showPublicationDialog(List publicationData) async {
    final List publications = publicationData;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Publication'),
          content: SingleChildScrollView(
            child: ListBody(
              children: publications.map((pub) {
                return ListTile(
                  title: Text(pub),
                  onTap: () {
                    setState(() {
                      selectedPublication = pub;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Dialog for selecting Country
  Future<void> _showAuthorDialog(List author) async {
    final List countries = author;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Country'),
          content: SingleChildScrollView(
            child: ListBody(
              children: countries.map((country) {
                return ListTile(
                  title: Text(country),
                  onTap: () {
                    setState(() {
                      selectedCountry = country;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
