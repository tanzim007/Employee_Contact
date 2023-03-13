import 'package:employee_app/employee_model.dart';
import 'package:flutter/material.dart';

class EmployeeProvider extends ChangeNotifier {
  List<EmployeeModel>employees=[];
      addEmployee(EmployeeModel employeeModel){
    employees.add(employeeModel);
    notifyListeners();
      }
  getAllEmployees(){
        employees=employeeList;
        notifyListeners();
  }
  deleteEmployee(EmployeeModel employeeModel){
        employees.remove(employeeModel);
        notifyListeners();
 }
  updateFavorite(int index){
        employees[index].favorite=!employees[index].favorite;
        notifyListeners();
  }
}