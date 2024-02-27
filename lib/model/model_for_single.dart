class User {
  final String name;
  final int age;
  final String add;

  User({
    required this.name,
    required this.age,
    required this.add,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'add': add,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      add: map['add'] ?? '',
    );
  }
}
