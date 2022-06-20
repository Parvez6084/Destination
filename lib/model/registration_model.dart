class RegistrationModel {
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? otpCode;
  String? password;
  String? rePassword;

  RegistrationModel(
      {this.firstName,
      this.lastName,
      this.userName,
      this.email,
      this.otpCode,
      this.password,
      this.rePassword});

  @override
  String toString() {
    return 'RegistrationModel{firstName: $firstName, lastName: $lastName,'
        ' userName: $userName, email: $email, otpCode: $otpCode,'
        ' password: $password, rePassword: $rePassword}';
  }
}
