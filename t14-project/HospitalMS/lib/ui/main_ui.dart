import 'dart:io';
import '../data/data_manager.dart';
import '../domain/main.dart';

class HospitalUI {
  final DataManager manager = DataManager();

  void start() {
    while(true){
      print('\nWelcome to Our Hospital');
      print('1. Add New Staff');
      print('2. Delete Staff');
      print('3. View All Staffs');
      print('4. Adjust Staff');
      print('5. Exit');

      stdout.write('Choose your Option: ');
      String? choice = stdin.readLineSync();

      switch(choice){
        case '1':
        addStaff();
        break;

        case'2':
        removeStaff();
        break;

        case'3':
        viewAllStaff();
        break;

        case'4':
        adjustStaff();
        break;

        case'5':
        print('Byee!!!');
        return;
        
        default:
        print('Invalid input option');
      }
    }
  }

  void addStaff(){
    stdout.write('Enter staff type (doctor/nurse/admin): ');
    String type = stdin.readLineSync()!.toLowerCase();

    switch(type){
      case'doctor': 
        stdout.write('Enter ID: ');
        String id = stdin.readLineSync()!;
        stdout.write('Enter Name: ');
        String name = stdin.readLineSync()!;
        stdout.write('Enter Age: ');
        int age = int.parse(stdin.readLineSync()!);
        stdout.write('Enter Speciality: ');
        String specialization = stdin.readLineSync()!;
        stdout.write('Enter Salary: ');
        double salary = double.parse(stdin.readLineSync()!);

        var doctor = Doctor(id: id, name: name, age: age, salary: salary, specialization: specialization);
        var doctors = manager.loadDoctors();
        doctors.add(doctor);
        manager.saveDoctors(doctors);
        print('Doctor has been added');
        break;

      case'nurse': 
        stdout.write('Enter ID: ');
        String id = stdin.readLineSync()!;
        stdout.write('Enter Name: ');
        String name = stdin.readLineSync()!;
        stdout.write('Enter Age: ');
        int age = int.parse(stdin.readLineSync()!);
        stdout.write('Enter Salary: ');
        double salary = double.parse(stdin.readLineSync()!);

        var nurse = Nurse(id: id, name: name, age: age, salary: salary);
        var nurses = manager.loadNurses();
        nurses.add(nurse);
        manager.saveNurses(nurses);
        print('Nurse has been added');
        break;

      case'admin': 
        stdout.write('Enter ID: ');
        String id = stdin.readLineSync()!;
        stdout.write('Enter Name: ');
        String name = stdin.readLineSync()!;
        stdout.write('Enter Age: ');
        int age = int.parse(stdin.readLineSync()!);
        stdout.write('Enter Salary: ');
        double salary = double.parse(stdin.readLineSync()!);

        var admin = AdminStaff(id: id, name: name, age: age, salary: salary);
        var admins = manager.loadAdmins();
        admins.add(admin);
        manager.saveAdmins(admins);
        print('Admin Staff has been added');
        break;
      }
    }
  

  void removeStaff(){
    stdout.write('Enter staff type (doctor/nurse/admin): ');
    String type = stdin.readLineSync()!.toLowerCase();
    stdout.write('Enter ID to remove: ');
    String id = stdin.readLineSync()!;

    switch (type){
      case 'doctor':
      manager.loadDoctors().forEach(print);
      var doctors = manager.loadDoctors();
      doctors.removeWhere((d) => d.id == id);
      manager.saveDoctors(doctors);
      print('Doctor has been deleted');
      break;

      case 'nurse':
      manager.loadNurses().forEach(print);
      var nurses = manager.loadNurses();
      nurses.removeWhere((n) => n.id == id);
      manager.saveNurses(nurses);
      print('Nurse has been deleted');
      break;

      case 'admin':
      manager.loadAdmins().forEach(print);
      var admins = manager.loadAdmins();
      admins.removeWhere((a) => a.id == id);
      manager.saveAdmins(admins);
      print('Admin has been deleted');
      break;
    }
    
  }


  void viewAllStaff() {
    print('Doctors:');
    manager.loadDoctors().forEach(print);

    print('\nNurses:');
    manager.loadNurses().forEach(print);

    print('\nAdmin Staff:');
    manager.loadAdmins().forEach(print);
  }

  void adjustStaff() {
    stdout.write('Enter staff type (doctor/nurse/admin): ');
    String type = stdin.readLineSync()!.toLowerCase();
    stdout.write('Enter ID to update: ');
    String id = stdin.readLineSync()!;

    switch (type) {
      case 'doctor':
        var doctors = manager.loadDoctors();
        var index = doctors.indexWhere((d) => d.id == id);
        if (index == -1) {
          print('Doctor not found.');
          return;
        }
        stdout.write('Enter new salary: ');
        double newSalary = double.parse(stdin.readLineSync()!);
        doctors[index] = Doctor(
          id: doctors[index].id,
          name: doctors[index].name,
          age: doctors[index].age,
          specialization: doctors[index].specialization,
          salary: newSalary,
        );
        manager.saveDoctors(doctors);
        print('Doctor updated.');
        break;

      case 'nurse':
        var nurses = manager.loadNurses();
        var index = nurses.indexWhere((n) => n.id == id);
        if (index == -1) {
          print('Nurse not found.');
          return;
        }
        stdout.write('Enter new salary: ');
        double newSalary = double.parse(stdin.readLineSync()!);
        nurses[index] = Nurse(
          id: nurses[index].id,
          name: nurses[index].name,
          age: nurses[index].age,
          salary: newSalary,
        );
        manager.saveNurses(nurses);
        print('Nurse updated.');
        break;

      case 'admin':
        var admins = manager.loadAdmins();
        var index = admins.indexWhere((a) => a.id == id);
        if (index == -1) {
          print('Admin staff not found.');
          return;
        }
        stdout.write('Enter new salary: ');
        double newSalary = double.parse(stdin.readLineSync()!);
        admins[index] = AdminStaff(
          id: admins[index].id,
          name: admins[index].name,
          age: admins[index].age,
          salary: newSalary,
        );
        manager.saveAdmins(admins);
        print('Admin staff updated.');
        break;

      default:
        print('Invalid staff type.');
    }
  }
}

