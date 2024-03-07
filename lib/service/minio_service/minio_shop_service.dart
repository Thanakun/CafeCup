import 'package:minio_new/io.dart';
import 'package:minio_new/minio.dart';

class MinioShopService{
  MinioShopService(
    this.minioClient
  );

  final Minio minioClient;
}