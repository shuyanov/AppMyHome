import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePatch;
  final bool isEdit;
  final VoidCallback onCliced;

  const ProfileWidget({
    Key? key,
    required this.imagePatch,
    this.isEdit = false,
    required this.onCliced,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          buildImage(),
          Align(
              alignment: Alignment.topLeft,
            child:
            buildEditIcon(Colors.cyan)),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePatch);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 100,
          height: 100,
          child: InkWell(onTap: onCliced),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    clor: Colors.white,
    all: 3,
      child: buildCircle(
      clor: color,
      all: 8,
      child: Icon(
        isEdit ? Icons.add_a_photo : Icons.add,
        size: 15,
        color: Colors.black,
        ),
      ),
  );

  Widget buildCircle({
  required Widget child,
  required double all,
  required Color clor,
    required
}) =>
    ClipOval(
      child: Container(
      padding:  EdgeInsets.all(all),
      color: clor,
      child: child,
      ),
    );
}
