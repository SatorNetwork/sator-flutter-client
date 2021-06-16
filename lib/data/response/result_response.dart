class ResultResponse {
  final bool result;

  const ResultResponse(this.result);

  factory ResultResponse.fromJson(Map json) =>
      ResultResponse(json['result'] as bool);
}
