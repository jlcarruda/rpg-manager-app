// class Response {
//   final dynamic bodyData;

//   const Response({
//     required this.bodyData
//   });

//   factory Response.fromJson(Map<String, dynamic> json) {
//     print
//     return Response({
//       bodyData: json['data'],
//     });
//   }
// }


class Response {
  final dynamic bodyData;
  // final int id;
  // final String title;

  const Response({
    required this.bodyData,
    // required this.id,
    // required this.title,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      bodyData: json['data'],
      // id: json['id'],
      // title: json['title'],
    );
  }
}
