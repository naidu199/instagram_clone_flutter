import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);

  try {
    if (file != null) {
      return await file.readAsBytes();
    } else {
      // ignore: avoid_print
      print("no image selected");
    }
  } catch (e) {
    print(e.toString());
  }
}
