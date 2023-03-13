class EmployeeModel {
  int? empId;
  String name;
  String dob;
  String designation;
  String mobile;
  String email;
  String streetAddress;
  num salary;
  String image;
  String gender;
  bool favorite;

  EmployeeModel({this.empId,
    required this.name,
    required this.dob,
    required this.designation,
    required this.mobile,
    required this.email,
    required this.streetAddress,
    required this.salary,
    required this.image,
    required this.gender,
    this.favorite = false

  });
}

final List<EmployeeModel> employeeList = [
  EmployeeModel(
    name: 'Mr. Sabbir',
    dob: '01/01/1999',
    designation: 'Executive',
    mobile: '999900000',
    email: 'sabbir@gmail.com',
    streetAddress: 'EDB Trade Center, Kawranbazar, Dhaka',
    salary: 25000,
    image:
    '/data/user/0/com.example.employee_management_app_batch06/cache/a7ffbb6b-d352-43d9-a720-16d339e092ab2822539373327306078.jpg',
    gender: 'Male',
  ),
];

final designationList = <String>[
  'Director',
  'CEO',
  'CTO',
  'Sales Manager',
  'Project Manager',
  'Senior Developer',
  'Software Engineer'
];
