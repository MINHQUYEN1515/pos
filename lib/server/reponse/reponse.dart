class ResponseData<T> {
  final bool status;
  final T data;
  final String message;

  ResponseData({
    required this.status,
    required this.data,
    required this.message,
  });

  // Convert ResponseData to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data,
      'message': message,
    };
  }

  // Helper method for copying with modifications
}
