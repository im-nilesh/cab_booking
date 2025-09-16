import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DocumentDialog extends StatelessWidget {
  final String storagePath;
  final String docName;

  const DocumentDialog({
    super.key,
    required this.storagePath,
    required this.docName,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FutureBuilder<String>(
        future: FirebaseStorage.instance.ref(storagePath).getDownloadURL(),
        builder: (context, snapshot) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  docName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              if (snapshot.connectionState == ConnectionState.waiting)
                const CircularProgressIndicator()
              else if (snapshot.hasError || !snapshot.hasData)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Unable to load image.'),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: 300,
                    height: 400,
                    child: Image.network(snapshot.data!, fit: BoxFit.contain),
                  ),
                ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      ),
    );
  }
}
