import 'package:image/image.dart';
import 'dart:io';

String convertImage(FileSystemEntity selectedFile, String format)
{
  final rawImage = (selectedFile as File).readAsBytesSync();
  final image = decodeImage(rawImage);

  var newImage;
  if(format == 'jpeg') {
    newImage = encodeJpg(image);
  }else if(format == 'png'){
    newImage = encodePng(image);
  }else {
    print('Unsupported file format...!');
  }

  String newPath = replaceExtension(selectedFile.path, format);
  new File(newPath).writeAsBytesSync(newImage);
  return newPath;
}

String replaceExtension(String path, String newExtension)
{
  return path.replaceAll(new RegExp(r'(jpg|jpeg|png)'), newExtension);
}