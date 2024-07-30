import '../../../models/comic_model.dart';
import '../provider/book_case_provider.dart';

class BookCaseReponsitory{
  BookCaseReponsitory({required this.provider});
  final BookCaseProvider provider;
  Future<List<ComicModel>> getComicListSaved(String uid) =>
    provider.getComicListSaved(uid);
  Future<List<ComicModel>> getComicListSaved1(String uid) =>
    provider.getComicListSaved1(uid);
  Future<List<ComicModel>> getComicListReaded(String uid) =>
    provider.getComicListReaded(uid);
    Future<List<ComicModel>> getComicListLiked(String uid) =>
      provider.getComicListLiked(uid);
  Future<ComicModel?> getComicReaderById(String uid, String idComic) =>
    provider.getComicReaderById(uid, idComic);
}