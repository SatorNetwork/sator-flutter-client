class VerifyAccountResponse {
  final bool isVerify;

  const VerifyAccountResponse(this.isVerify);

  factory VerifyAccountResponse.fromJson(Map json) =>
      VerifyAccountResponse(json['result'] as bool);
}
