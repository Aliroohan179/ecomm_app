class UserProfile {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String photoUrl;
  final DateTime createdAt;

  UserProfile({
    required this.id,
    required this.email,
    required this.name,
    this.phone = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.zipCode = '',
    this.photoUrl = '',
    required this.createdAt,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map, String id) {
    return UserProfile(
      id: id,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zipCode'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'photoUrl': photoUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  UserProfile copyWith({
    String? name,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? photoUrl,
  }) {
    return UserProfile(
      id: id,
      email: email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt,
    );
  }
}
