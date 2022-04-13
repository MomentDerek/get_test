import 'dart:convert';


class ResponseEntity<T> {
    ResponseEntity({
        this.code,
         this.message,
         this.data,
    });

    int? code;
    String? message;
    T? data;

    @override
    String toString() {
      return "Response{code: $code, message: $message, data: $data}";
    }

    factory ResponseEntity.fromRawJson(String str) => ResponseEntity.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResponseEntity.fromJson(Map<String, dynamic> json) => ResponseEntity(
        code: json["code"],
        message: json["message"],
        data: json["data"]
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data,
    };
}