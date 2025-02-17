import 'package:flutter/material.dart';
import 'package:news_app/routes/app_router.dart';
import 'package:provider/provider.dart';
import 'configs/provider_list.dart';
import 'services/get_it_di_services.dart';
import 'services/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getItLocatorFunc();
  await SharedPreferenceHelper.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providerList,
      child: MaterialApp.router(
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        title: "Asad News App",
        routerConfig: appRouter,
      ),
    );
  }
}
