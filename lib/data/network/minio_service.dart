import 'dart:io';
import 'dart:typed_data';
import 'package:coffee_application/model/response/pie_graph_response.dart';
import 'package:coffee_application/utility/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minio_new/io.dart';
import 'package:minio_new/minio.dart';
import 'package:minio_new/models.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;

class MinioService {
  late Minio _minioClient;

  MinioService() {
    _minioClient = Minio(
        useSSL: false,
        port: 9000,
        endPoint: "172.31.48.1",
        accessKey: "y8sFAaRyGxdWI1b5ahBT",
        secretKey: "gaPZgOgwZjzEHl5QLp9MNTPaKT6OysIx7JLbkpTV",
        enableTrace: true);
  }

  //createBucketByShopName
  Future<void> createBucketByShopName({required String shopName}) async {
    try {
      _minioClient.makeBucket("shopName");
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Bucket>> getBucketList() async {
    try {
      return _minioClient.listBuckets();
    } catch (_) {
      return [];
    }
  }

  Future<String> getObjectItem({
    required String bucketName,
    required String objectName,
  }) async {
    try {
      String bucketLowerCase = bucketName.toLowerCase();
      if (kIsWeb) {
        String item = await _minioClient.presignedGetObject(
          bucketLowerCase,
          objectName,
        );

        return item;
      }

      return await _minioClient.presignedGetObject(
        bucketLowerCase,
        objectName,
        respHeaders: {"Content-Type": "image/jpeg"},
      );
    } catch (e) {
      return "";
    }
  }

  Future<String> uploadObject({
    required String bucketName,
    required String objectName,
    required Stream<Uint8List> file,
  }) async {
    try {
      String bucketLowerCase = bucketName.toLowerCase();
      if (!(await _minioClient.bucketExists(bucketLowerCase))) {
        _minioClient.makeBucket(bucketLowerCase);
      }

      await _minioClient.putObject(bucketLowerCase, objectName, file);

      // Construct and return the URL for the uploaded object
      final url = _minioClient.endPoint
          .replaceFirst("http://", "http://$bucketLowerCase:9001");
      return '$url/$objectName';
    } catch (e) {
      print('Error uploading object: $e');
      rethrow;
    }
  }

  Future<List<String>> uploadMultipleFiles({
    required String bucketName,
    required List<String> objectNames,
    required List<String> filePaths,
    required List<XFile> xfiles,
  }) async {
    try {
      String bucketLowerCase = bucketName.toLowerCase();

      if (!(await _minioClient.bucketExists(bucketLowerCase))) {
        _minioClient.makeBucket(bucketLowerCase);
      }

      List<Future<String>> uploadTasks = [];

      for (int i = 0; i < objectNames.length; i++) {
        late Future<String> uploadType;

        if (kIsWeb) {
          // Handle Web
          uploadType = _minioClient.putObject(
            bucketLowerCase,
            objectNames[i],
            xfiles[i].openRead(),
            metadata: {"Content-type": "image/jpeg"},
            onProgress: (p0) {},
          );
        } else {
          // Handle non-web environments
          uploadType = _minioClient.fPutObject(
            bucketLowerCase,
            objectNames[i],
            filePaths[i],
          );
        }

        uploadTasks.add(uploadType);
      }

      // Wait for all uploads to complete
      List<String> uploadedUrls = await Future.wait(uploadTasks);

      // Construct and return a list of URLs for the uploaded objects
      final url = _minioClient.endPoint
          .replaceFirst("http://", "http://$bucketLowerCase:9001");
      return uploadedUrls.map((uploadedObjectName) {
        return '$url/$uploadedObjectName';
      }).toList();
    } catch (e) {
      print('Error uploading objects: $e');
      return [];
    }
  }

  Future<String> uploadFilePathObject({
    required String bucketName,
    required String objectName,
    required String filePath,
  }) async {
    try {
      String bucketLowerCase = bucketName.toLowerCase();

      if (!(await _minioClient.bucketExists(bucketLowerCase))) {
        _minioClient.makeBucket(bucketLowerCase);
      }

      late Future<String> uploadType;

      if (kIsWeb) {
        uploadType = _minioClient.putObject(
          bucketLowerCase,
          objectName,
          Helper.pathToXFile(filePath).openRead(),
          onProgress: (p0) {
            print("p0");
            print(p0);
          },
        );
      } else {
        // Handle non-web environments
        uploadType =
            _minioClient.fPutObject(bucketLowerCase, objectName, filePath);
      }

      // Construct and return the URL for the uploaded object
      final url = _minioClient.endPoint
          .replaceFirst("http://", "http://$bucketLowerCase:9001");
      return uploadType;
    } catch (e) {
      print('Error uploading object: $e');
      rethrow;
    }
  }
}
