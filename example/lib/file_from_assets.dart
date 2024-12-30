import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

extension FileFromAssets on String {
  Future<File> getFileFromAsset() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = '$tempPath/$this';
    var file = File(filePath);
    final exists = await file.exists();
    if (exists) {
      return file;
    } else {
      final byteData = await rootBundle.load(this);
      final buffer = byteData.buffer;
      await file.create(recursive: true);
      return file.writeAsBytes(
        buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );
    }
  }
}
