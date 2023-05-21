class ReviewImages {
  final int imageId;
  final int reviewId;
  final String reviewImagePath;

  ReviewImages({
    required this.imageId,
    required this.reviewId,
    required this.reviewImagePath,
  });

  factory ReviewImages.fromJson(Map<String, dynamic> json) {
    return ReviewImages(
      imageId: json['img_id'] as int,
      reviewId: json['review_id'] as int,
      reviewImagePath: json['img_image'] as String,
    );
  }
}