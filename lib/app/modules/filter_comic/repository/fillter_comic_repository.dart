import '../../../models/comic_model.dart';
import '../provider/fillter_comic_provider.dart';

class FilterReponsitory {
 final FilterComicProvider provider;
 FilterReponsitory({required this.provider});
 Future<List<ComicModel>> getComicListStatus(String string) =>
  provider.getComicListHot(string);

  Future<List<ComicModel>> getAllComicList() =>
    provider.getAllComicList();

}