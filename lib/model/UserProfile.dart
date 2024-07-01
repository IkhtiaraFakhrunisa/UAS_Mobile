class UserProfile {
  int? id;
  String name;
  String email;
  String password;


  UserProfile({
    this.id,
    required this.name,
    required this.email,
    required this.password,

  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}
