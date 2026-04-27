import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart'; // ─── Make sure this is imported

class CreateGroupController extends GetxController {

  final ImagePicker _picker = ImagePicker();

  final RxString descriptionPhotoPath = ''.obs;

  void pickDescriptionPhoto() {
    MediaPickerBottomSheet.show(
      onCamera: () async {
        final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
        if (photo != null) descriptionPhotoPath.value = photo.path;
      },
      onGallery: () async {
        final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
        if (photo != null) descriptionPhotoPath.value = photo.path;
      },
    );
  }

}