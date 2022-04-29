import 'package:final_pro/constants.dart';
import 'package:final_pro/cubits/Article_cubit/article_cubit.dart';
import 'package:final_pro/cubits/Article_cubit/article_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/Article_cubit/article_states.dart';

class Articles extends StatefulWidget {
  const Articles({Key? key}) : super(key: key);
  static String routeName = "/article";

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        ArticleCubit.get(context).gotoInit();
        Navigator.pop(context, false);
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Articles',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (v) {
                  if (v.isNotEmpty) ArticleCubit.get(context).getArticle(v);
                },
                controller: controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    suffix: InkWell(
                        onTap: () {
                          if (controller.text.isNotEmpty)
                            ArticleCubit.get(context)
                                .getArticle(controller.text);
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        )),
                    hintText: 'Search for articles',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: kPrimaryColor, width: 2))),
              ),
            ),
            BlocBuilder<ArticleCubit, ArticlesStates>(
                builder: (context, state) {
              var article = ArticleCubit.get(context).articles.data;
              if (article == null && state is InitState) {
                return Expanded(
                    child: Center(child: Text('search for articles')));
              } else if (state is Loading) {
                return Expanded(
                    child: Center(child: CircularProgressIndicator()));
              } else if (state is Success) {
                if (article != null && article.isNotEmpty)
                  return Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, i) {
                      return _buildArticleItem(
                          article[i].image,
                          article[i].title,
                          article[i].description,
                          article[i].source,
                          article[i].url);
                    },
                    itemCount: article.length,
                  ));
                else
                  return Expanded(
                      child: Center(
                    child: Text('no data found'),
                  ));
              } else
                return Expanded(
                  child: Center(
                    child: Text('error has occurred'),
                  ),
                );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleItem(image, title, desc, source, url) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(5),
        decoration:
            BoxDecoration(border: Border.all(color: kPrimaryColor, width: 2)),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                image != null
                    ? Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(image), fit: BoxFit.cover)),
                      )
                    : Container(),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    title.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Text(
              desc.toString(),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
            Text(
              'source: ${source.toString()}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
