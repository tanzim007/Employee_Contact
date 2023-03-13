

import 'package:employee_app/pages/employee_details_page.dart';
import 'package:employee_app/pages/employee_list_page.dart';
import 'package:employee_app/pages/new_employee_page.dart';
import 'package:employee_app/providers/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(ChangeNotifierProvider(
    create: (context)=>EmployeeProvider().. getAllEmployees(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
     initialRoute: EmployeeListPage.routeName,
      routes:{
        EmployeeListPage.routeName:(context)=>EmployeeListPage(),
        EmployeeDetailsPage.routeName:(context)=>EmployeeDetailsPage(),
        NewEmployeePage.routeName:(context)=>NewEmployeePage(),
      },
    );
  }
}


