import 'package:unimanga_app/app/modules/dashboard/provider/dashboard_provider.dart';

import '../../../models/rate_comic.dart';
import '../../../models/user.dart';
import '../../../models/chap_comic.dart';
import '../../../models/comic_model.dart';

class DashboardReponsitory {
 final DashboardProvider dashboardProvider;
 DashboardReponsitory({required this.dashboardProvider});
 Future<List<ComicModel>> getComicList() =>
  dashboardProvider.getComicListHot();
   Future<List<Users>> getAllUserData() =>
  dashboardProvider.getAllUserData();
   Future<List<Users>> getAllUserScores() =>
  dashboardProvider.getAllUserScores();
 Future<List<ComicModel>> getFilterComic(String stt) =>
  dashboardProvider.getFilterComic(stt);
 Future<List<ComicModel>> getComicListWithCate(String cate) =>
  dashboardProvider.getComicListWithCate(cate);
  Future<ComicModel?> getComicById(String id) =>
  dashboardProvider.getComicById(id);
  Future<List<ImageChap>> getImageChapComicById(String id, String idChuong) =>
    dashboardProvider.getImageChapComicById(id, idChuong);
  Future<Users?> getUserByUid(String uid) =>
    dashboardProvider.getUserByUid(uid);
    Future<List<ComicModel>> searchComics(String keyword) =>
    dashboardProvider.searchComics(keyword);
  Future<List<CommentChapComic>> getRateComicbyId(String id) =>
    dashboardProvider.getRateComicbyId(id);
  Future<List<ChapComicModel>> getChapComicByIdComic(String idComic, String idChap) =>
   dashboardProvider.getChapComicByIdComic(idComic, idChap);
  Future<ChapComicModel?> getComicChapById(String idComic, String idChap) =>
    dashboardProvider.getComicChapById(idComic, idChap);
  Future<List<RateComic>> getComicRate(String id) =>
    dashboardProvider.getComicRate(id);
  Future<List<ComicModel>> getComicListNewUpdate() =>
    dashboardProvider.getComicListNewUpdate();
}