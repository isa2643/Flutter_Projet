import 'package:flutter/material.dart';
import 'package:projet/app/screens/home-details/home_details_screen.dart';
import 'package:projet/app/screens/home/home_screen.dart';

const kMainRoute = '/home';
const kHomeRoute = '/home';
const kHomeDetailRoute = '/home-details';

final Map<String, WidgetBuilder> kRoutes = {
  kMainRoute: (_) => HomeScreen(),
  kHomeDetailRoute: (_) => HomeScreenDetails(),
};

onGenerateRoute(settings) {
  if (settings.name == kHomeDetailRoute) {
     String data = settings.arguments;
    return MaterialPageRoute(builder: (_) => HomeScreenDetails(imagePath: data));
  } 
  else 
  {
    return null;
  }
}