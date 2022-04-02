import 'package:doc_app/image_repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dog App',
      home: HomePage(),
    );
  }
}

class DocPicture extends StatelessWidget {
  final myRepository = ImageRepository();
  DocPicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<String>(
            future: myRepository.getImageUrl(),
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
            }));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dog App'),
      ),
      body: DocPicture(),
    );
  }
}
