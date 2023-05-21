class ReviewRecord {
  final int imageId;
  final int reviewId;
  final String reviewImagePath;

  ReviewRecord({
    required this.imageId,
    required this.reviewId,
    required this.reviewImagePath,
  });

  factory ReviewRecord.fromJson(Map<String, dynamic> json) {
    return ReviewRecord(
      imageId: json['img_id'] as int,
      reviewId: json['review_id'] as int,
      reviewImagePath: json['img_image'] as String,
    );
  }
}