import 'package:doc_app/repository/image_repository.dart';
import 'package:flutter/material.dart';

class DogImage extends StatefulWidget {
  const DogImage({Key? key}) : super(key: key);

  @override
  State<DogImage> createState() => _DogImageState();
}

class _DogImageState extends State<DogImage> {
  final myRepository = ImageRepository();
  late Future<String> _pictureUrl;

  @override
  void initState() {
    super.initState();
    _pictureUrl = myRepository.getImageUrl();
  }

  changePicture() {
    setState(() {
      _pictureUrl = myRepository.getImageUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        FutureBuilder<String>(
            future: _pictureUrl,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return Image.network(
                  snapshot.data ?? '',
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                        child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ));
                  },
                );
              } else {
                return Container();
              }
            }),
        ElevatedButton(onPressed: changePicture, child: const Text('Get Dog')),
      ],
    ));
  }
}
