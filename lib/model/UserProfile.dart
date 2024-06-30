class UserProfile {
  int? id;
  String name;
  String email;
  String password;
  String? image;

  UserProfile({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'image': image,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      image: map['image'],
    );
  }
}
