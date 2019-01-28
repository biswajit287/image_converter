import 'package:question_asker_bm/question_asker_bm.dart';
import 'dart:io';
import 'package:image_converter/src/converter.dart';

void main() {
  final promter = new Promter();
  final choice = promter.askBinary('Are you here to convert an image?');
  if (!choice) {
    exit(0);
  } 

  final format = promter.askMultiple('Select a format of image to convert to: ', buildFormatOption());
  final selectedFile = promter.askMultiple('Select an Image to convert: ', buildFormatFiles());

  String newPath = convertImage(selectedFile, format);
  print(newPath);
  final shouldOpenImage = promter.askBinary('Do you want to Open the Image? ');
  openNewImage(newPath, shouldOpenImage);
}

//Opening the converted image after converting
openNewImage(String newPath, bool shouldOpenImage)
{
  String imageName = newPath.split(Platform.pathSeparator).last;

  if(shouldOpenImage){
    if(Platform.isWindows){
      Process.run('start', [imageName]);
    }else{
      Process.run('open', [imageName]);
    }
  }
}

List<Option> buildFormatOption()
{
  return [
      new Option('Convert to JPEG', 'jpeg'),
      new Option('Convert to PNG', 'png'),
    ];
}

List<Option> buildFormatFiles()
{
  //Get a reference to the current working directory

    return Directory.current.listSync()                    //Find all the files and folders in this directory
        .where((entity){                                    //Look through the list and find only **IMAGES**
          return FileSystemEntity.isFileSync(entity.path) && 
                        entity.path.contains(new RegExp(r'\.(png|jpg|jpeg)'));
    }).map((entity){
        //extracting the filename only from the entire path
        final filename = entity.path.split(Platform.pathSeparator).last;
        return Option(filename, entity);
    }).toList();
  
    //Take all the images and create option object out of each
}