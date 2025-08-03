class UserProfileModel {
  final String? status;
  final List<ProfileData>? data;

  UserProfileModel({this.status, this.data});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      status: json['status'],
      data: json['data'] != null
          ? List<ProfileData>.from(
          json['data'].map((v) => ProfileData.fromJson(v)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((v) => v.toJson()).toList(),
    };
  }
}

class ProfileData {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? password;
  final String? createdDate;

  ProfileData({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.mobile,
    this.password,
    this.createdDate,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      mobile: json['mobile'],
      password: json['password'],
      createdDate: json['createdDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'password': password,
      'createdDate': createdDate,
    };
  }
}
