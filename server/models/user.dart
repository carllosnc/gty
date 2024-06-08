class User {
  User({
    required this.name,
    required this.age,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'] as String,
        age: json['age'] as int,
        email: json['email'] as String,
      );

  final String name;
  final int age;
  final String email;

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'email': email,
      };
}
