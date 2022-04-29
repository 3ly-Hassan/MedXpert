import 'package:bloc/bloc.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/cubits/Article_cubit/article_states.dart';
import 'package:final_pro/models/article.dart';
import 'package:final_pro/pages/article/articles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleCubit extends Cubit<ArticlesStates> {
  APIService api = new APIService();
  Article articles = Article();
  ArticleCubit() : super(InitState());

  static ArticleCubit get(context) => BlocProvider.of(context);

  void getArticle(key) {
    print(articles.data);
    emit(Loading());
    _articlesFromDB(key).then((article) {
      if (article.statusCode == 200) {
        articles = article;
        print(article.data);
        emit(Success());
      } else
        emit(Error());
    });
  }

  gotoInit() {
    articles = Article();
    emit(InitState());
  }

  Future<Article> _articlesFromDB(key) async {
    var articles = await api.getAllArticles(key);
    return articles;
  }
}
