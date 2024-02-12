class UserModel {
  String userid;
  String userName;
  String userEmail;
  String userDOB;
  int userNumber;
  String userAddress;
  String userGender;

  UserModel({
    required this.userid,
    required this.userName,
    required this.userEmail,
    required this.userDOB,
    required this.userNumber,
    required this.userAddress,
    required this.userGender,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        userid: map['userid'],
        userName: map['userName'],
        userEmail: map['userEmail'],
        userDOB: map['userDOB'],
        userNumber: map['userNumber'],
        userAddress: map['userAddress'],
        userGender: map['userGender']);
  }
  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'userName': userName,
      'userEmail': userEmail,
      'userDOB': userDOB,
      'userNumber': userNumber,
      'userAddress': userAddress,
      'userGender': userGender,
    };
  }
}
