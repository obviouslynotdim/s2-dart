enum Skill { FLUTTER, DART, OTHER }

class Address {
  final String street;
  final String city;
  final String zipCode;

  const Address(this.street, this.city, this.zipCode);

  @override
  String toString() => '$street, $city, $zipCode';
}

class Employee {
  final String _name;
  final double _baseSalary;
  final List<Skill> _skills;
  final Address _address;
  final int _yearsOfExperience;

  Employee(
    this._name,
    this._baseSalary,
    this._skills,
    this._address,
    this._yearsOfExperience,
  );

  Employee.mobileDeveloper(String name, Address address, int yearsOfExperience)
    : _name = name,
      _baseSalary = 40000,
      _skills = [Skill.FLUTTER, Skill.DART],
      _address = address,
      _yearsOfExperience = yearsOfExperience;

  String get name => _name;
  double get baseSalary => _baseSalary;
  List<Skill> get skills => List.unmodifiable(_skills); //read-only
  Address get address => _address;
  int get yearsOfExperience => _yearsOfExperience;

  double computeSalary() {
    double salary = _baseSalary + (_yearsOfExperience * 2000);
    for (var skill in skills) {
      switch (skill) {
        case Skill.FLUTTER:
          salary += 5000;
          break;
        case Skill.DART:
          salary += 3000;
          break;
        case Skill.OTHER:
          salary += 1000;
          break;
      }
    }
    return salary;
  }

  void printDetails() {
    print('Employee: $_name, Base Salary: \$${baseSalary}');
    print('Address: $_address');
    print('Skills: ${_skills.map((s) => s.name).join(", ")}'); //turns the list of enum values into a readable string
    print('Years of Experience: $_yearsOfExperience, Computed Salary: \$${computeSalary()}');
    print('===');
  }
}

void main() {
  var emp1 = Employee('dimdom', 40000,  [Skill.FLUTTER, Skill.OTHER], const Address('6 7 St', 'Phnom Penh', '67676'), 0);
  emp1.printDetails();

  var emp2 = Employee.mobileDeveloper('Ronan', const Address('456 Park Ave', 'Siem Reap', '13000'), 5);
  emp2.printDetails();
}
