import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/view/home_screen/widget/cat_card.dart';
import 'package:news_app/view_model/home_view_model/home_view_model.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes_name.dart';
import '../../services/shared_preferences.dart';
import '../../utils/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final spref = SharedPreferenceHelper();
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          title: Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  spref.clear();
                  context.go(AppRouteNames.initialscreen);
                },
                icon: Icon(
                  Icons.power_settings_new_outlined,
                  color: Colors.white,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to the News App',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                'Categories',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    CategoryCard(
                      title: 'Latest News',
                      icon: Icons.fiber_new,
                      onTap: () {
                        context.push(AppRouteNames.newsList);
                      },
                    ),
                    CategoryCard(
                        title: 'News by Date',
                        icon: Icons.calendar_month,
                        onTap: () {
                          context.push(AppRouteNames.filternewsList);
                        }),
                    CategoryCard(
                        title: 'News by Country',
                        icon: Icons.location_on,
                        onTap: () {}),
                    CategoryCard(
                        title: 'News by Publication',
                        icon: Icons.account_circle,
                        onTap: () {}),
                    CategoryCard(
                        title: 'All News', icon: Icons.article, onTap: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Consumer<HomeNewsProviderViewModel>(
          builder: (context, value, child) => FloatingActionButton(
            onPressed: () {
              value.getPopularNewsApiRepo();
            },
            child: Icon(Icons.add),
          ),
        )
        // bottomNavigationBar:
        );
  }
}
