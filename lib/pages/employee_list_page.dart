import 'dart:io';

import 'package:employee_app/providers/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../employee_model.dart';
import 'employee_details_page.dart';
import 'new_employee_page.dart';

class EmployeeListPage extends StatefulWidget {
  static const String routeName = '/';

  const EmployeeListPage({Key? key}) : super(key: key);

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  Future<bool?> deleteConfirmationDialog(DismissDirection direction) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Delete'),
              content: const Text('Sure to delete this employee'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('CANCEL')),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('YES'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: Consumer<EmployeeProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.employees.length,
          itemBuilder: (context, index) {
            final emp = provider.employees[index];
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.purple,
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete),
              ),
              confirmDismiss: deleteConfirmationDialog,
              onDismissed: (_) {
                provider.deleteEmployee(emp);
              },
              child: ListTile(
                onTap: () => Navigator.pushNamed(
                    context, EmployeeDetailsPage.routeName,
                    arguments: emp),
                leading: CircleAvatar(
                  backgroundImage: FileImage(File(emp.image)),
                ),
                title: Text(emp.name),
                subtitle: Text(emp.designation),
                trailing: IconButton(
                  onPressed: () {
                    provider.updateFavorite(index);
                  },
                  icon: Icon(
                      emp.favorite ? Icons.favorite : Icons.favorite_border,color: Colors.purple,),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewEmployeePage.routeName)
            .then((value) => setState(() {})),
        child: const Icon(Icons.add),
      ),
    );
  }
}
