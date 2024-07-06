class Verify {
  final String verificationCode;

  Verify({required this.verificationCode});

  Map<String, dynamic> toJson() {
    return {
      'verificationCode': verificationCode,
    };
  }
}
