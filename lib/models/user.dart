class User {
  final String fullName;
  final String userId;
  final String imageId;
  final String imageUrl;
  final String email;
  final String province;
  final String district;
  final String voterId;
  final String pin;

  User({
    required this.fullName,
    required this.userId,
    required this.email,
    required this.imageId,
    required this.imageUrl,
    required this.province,
    required this.district,
    required this.voterId,
    required this.pin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        fullName: json['Full Name'],
        userId: json['userId'],
        email: json['email'],
        imageId: json['imageId'],
        imageUrl: json['imageUrl'],
        province: json['Province'],
        district: json['District'],
        voterId: json['Voter ID'],
        pin: json['PIN'],
    );
  }

}
