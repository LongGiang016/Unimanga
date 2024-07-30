
import 'package:flutter/material.dart';
import 'package:unimanga_app/app/models/comic_model.dart';

class ItemManga extends StatefulWidget {
  ItemManga({
    super.key,
    required this.manga,
  });
  ComicModel manga;

  @override
  State<ItemManga> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemManga> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Card(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 33,
              child: Image.network(
                'https://picsum.photos/250?image=9',
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              flex: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.start, // Changed to spaceBetween
                children: [
                 Text(
                    widget.manga.ten!.length >= 15
                        ? widget.manga.ten!.substring(0, 15) + "..."
                        : widget.manga.ten!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("Chapter: ${widget.manga.chapComicModel}"),
                  Text("Cập nhật lúc: ${widget.manga.tinhTrang}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
