import 'dart:io';

import 'package:employee_app/providers/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../employee_model.dart';
import '../helper_function.dart';

class NewEmployeePage extends StatefulWidget {
  static const String routeName = '/new_employee';

  const NewEmployeePage({Key? key}) : super(key: key);

  @override
  State<NewEmployeePage> createState() => _NewEmployeePageState();
}

class _NewEmployeePageState extends State<NewEmployeePage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final salaryController = TextEditingController();
  String? dob;
  String? imagePath;
  ImageSource source = ImageSource.camera;
  String genderGroupValue = 'Male';
  String? designation;

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: _saveEmployee,
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            keyboardType: TextInputType.name,
            controller: nameController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                filled: true,
                labelText: 'Employee Name'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: mobileController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.call),
                filled: true,
                labelText: 'Mobile Number'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                filled: true,
                labelText: 'Email Address'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.streetAddress,
            controller: addressController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.my_location),
                filled: true,
                labelText: 'Street Address'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: salaryController,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.monetization_on),
                filled: true,
                labelText: 'Salary'),
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButton<String>(
            isExpanded: true,
            value: designation,
            hint: const Text('Select Designation'),
            items: designationList.map((e) =>
                DropdownMenuItem(
                    value: e,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(e),
                    )),
            ).toList(),
            onChanged: (value) {
              setState(() {
                designation = value;
              });
            },
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Select Gender'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: genderGroupValue,
                      onChanged: (value) {
                        setState(() {
                          genderGroupValue = value!;
                        });
                      },
                    ),
                    const Text('Male'),
                    Radio<String>(
                      value: 'Female',
                      groupValue: genderGroupValue,
                      onChanged: (value) {
                        setState(() {
                          genderGroupValue = value!;
                        });
                      },
                    ),
                    const Text('Female'),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: selectDate,
                child: const Text('Select Date of Birth'),
              ),
              Chip(
                label: Text(dob == null ? 'No Date chosen' : dob!),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 10,
                child: imagePath == null
                    ? Image.asset(
                  'images/person.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
                    : Image.file(
                  File(imagePath!),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.camera),
                    onPressed: () {
                      source = ImageSource.camera;
                      getImage();
                    },
                    label: const Text('Capture'),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.photo),
                    onPressed: () {
                      source = ImageSource.gallery;
                      getImage();
                    },
                    label: const Text('Gallery'),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  void selectDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      setState(() {
        dob = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  void getImage() async {
    final selectedImage = await ImagePicker()
        .pickImage(source: source);
    if (selectedImage != null) {
      setState(() {
        imagePath = selectedImage.path;
        print(imagePath);
      });
    }
  }

  void _saveEmployee() {
    if (nameController.text.isEmpty) {
      showMessage(context, 'Please provide a name for Employee');
      return;
    }

    if (designation == null) {
      showMessage(context, 'Please select a designation');
      return;
    }

    final employee = EmployeeModel(
        name: nameController.text,
        dob: dob!,
        designation: designation!,
        mobile: mobileController.text,
        email: emailController.text,
        streetAddress: addressController.text,
        salary: num.parse(salaryController.text),
        image: imagePath!,
        gender: genderGroupValue);

    EmployeeProvider provider= Provider.of<EmployeeProvider>(context,listen: false);
    provider.addEmployee(employee);
    Navigator.pop(context);
  }
}


