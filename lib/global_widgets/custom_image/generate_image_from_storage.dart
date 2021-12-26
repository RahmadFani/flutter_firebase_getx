import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class GenerateImageFromFirebaseStorage extends StatelessWidget {
  GenerateImageFromFirebaseStorage(
      {Key? key,
      this.image,
      this.withIcon,
      this.imageSize = 60,
      this.assetsImage = 'assets/images/user_icon.png',
      FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance,
        super(key: key);

  final String? image;
  final String assetsImage;
  final Icon? withIcon;
  final double imageSize;

  final FirebaseStorage _storage;

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return FutureBuilder(
          future: _storage.ref(image).getDownloadURL(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ClipOval(
                child: Image.network(
                  snapshot.data.toString(),
                  width: imageSize,
                  height: imageSize,
                ),
              );
            }
            if (withIcon != null) {
              return ClipOval(child: withIcon);
            }
            return ClipOval(
              child: Image.asset(
                assetsImage,
                width: imageSize,
                height: imageSize,
              ),
            );
          });
    }
    if (withIcon != null) {
      return ClipOval(child: withIcon);
    }
    return ClipOval(
      child: Image.asset(assetsImage, width: imageSize, height: imageSize),
    );
  }
}
