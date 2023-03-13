import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../employee_model.dart';

class EmployeeDetailsPage extends StatefulWidget {
  static const String routeName = '/details';
  const EmployeeDetailsPage({Key? key}) : super(key: key);

  @override
  State<EmployeeDetailsPage> createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  late EmployeeModel employee;

  @override
  void didChangeDependencies() {
    employee = ModalRoute.of(context)!.settings.arguments as EmployeeModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.name),
      ),
      body: ListView(
        children: [
          Image.file(File(employee.image), width: double.maxFinite, height: 300, fit: BoxFit.cover,),
          ListTile(
            title: Text(employee.mobile),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: _callEmployee,
                ),
                IconButton(
                  icon: const Icon(Icons.sms),
                  onPressed: _messagesEmployee,
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(employee.email),
            trailing: IconButton(
              icon: const Icon(Icons.email),
              onPressed: _emailEmployee,
            ),
          ),
          ListTile(
            title: Text(employee.streetAddress),
            trailing: IconButton(
              icon: const Icon(Icons.map),
              onPressed:(){
                _mapEmployee(77.74775, -463.3478562);
              },
            ),
          ),
          ListTile(
            title: Text(employee.designation),
            trailing: Text('BDT ${employee.salary}'),
          ),
        ],
      ),
    );
  }

  void _callEmployee() async {
    final uri = Uri.parse('tel:${employee.mobile}');
    if(await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'could not launch url';
    }
  }

  void _messagesEmployee() async {
    final uri = Uri.parse('sms:${employee.mobile}');
    if(await canLaunchUrl(uri)){
      await launchUrl(uri);
    }else{
      throw 'could not launch url';

    }

  }

  void _emailEmployee() async{
    final uri= Uri.parse('mailto:${employee.email}');
    if(await canLaunchUrl(uri)){
      await launchUrl(uri);
    }
    else{
      throw'could not launch url';
    }
  }

  void _mapEmployee(double lat,double long) async{
    final uri= Uri.parse('https://maps.google.com/maps/search/?api=API_KEY&query=$lat,$long');
    if(await canLaunchUrl(uri)){
      await launchUrl(uri);
    }
    else{
      throw'could not launch url';
    }
  }
}
