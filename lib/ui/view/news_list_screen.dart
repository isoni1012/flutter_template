import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/utils/extensions/ScrollControllerExtensions.dart';
import 'package:flutter_base_project/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../domain/models/article.dart';
import '../cubits/local_articles/local_article_cubit.dart';
import '../cubits/remote_articles/remote_articles_cubit.dart';
import '../widgets/article_widget.dart';

@RoutePage()
//ignore: must_be_immutable
class NewsListScreen extends HookWidget {
  bool isInternetAvailable = false;

  NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //If you declare any Bloc provider then you need to declare BlocBuilder otherwise it throw error
    final localArticlesCubit = BlocProvider.of<LocalArticleCubit>(context);
    final remoteArticlesCubit = BlocProvider.of<RemoteArticlesCubit>(context);
    final scrollController = ScrollController();

    /*
      for calling future method you need to use useFuture in which 2 parameter accept 1st future method and 2nd initial parameter
      then you can user this variable in useEffect
    */
    final snapshot =
        useFuture(Helper.isInternetAvailable(), initialData: false);
    useEffect(() {
      if (snapshot.data != null) {
        isInternetAvailable = snapshot.data!;
      }
      if (isInternetAvailable) {
        remoteArticlesCubit.getBreakingNewsArticles();
      }

      scrollController.onScrollEndsListener(() {
        if (isInternetAvailable) {
          // Future.delayed(const Duration(seconds: 3));
          remoteArticlesCubit.getBreakingNewsArticles();
        }
      });
      return scrollController.dispose;
    }, [snapshot.data]);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Daily News',
            style: TextStyle(color: Colors.black),
          ),
          actions: [GestureDetector(onTap: () {
            remoteArticlesCubit.update(1);
          }, child: const Text("Update"))],
        ),
        body: isInternetAvailable
            ? BlocBuilder<RemoteArticlesCubit, RemoteArticlesState>(
                builder: (_, state) {
                  switch (state.runtimeType) {
                    case RemoteArticlesLoading:
                      return const Center(child: CupertinoActivityIndicator());
                    case RemoteArticlesFailed:
                      return const Center(child: Icon(Icons.refresh));
                    case RemoteArticlesSuccess:
                      // for (int i = 0; i < state.articles.length; i++) {
                      //   localArticlesCubit.saveArticle(
                      //       article: state.articles[i]);
                      // }
                      return _buildArticles(
                        scrollController,
                        state.articles,
                        state.noMoreData,
                      );
                    default:
                      return const SizedBox();
                  }
                },
              )
            : BlocBuilder<LocalArticleCubit, LocalArticleState>(
                builder: (_, state) {
                  switch (state.runtimeType) {
                    case LocalArticleLoading:
                      return const Center(child: CupertinoActivityIndicator());
                    case LocalArticleSuccess:
                      return _buildArticles(
                        scrollController,
                        state.articles,
                        true,
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ));
  }

  Widget _buildArticles(
    ScrollController scrollController,
    List<Article> articles,
    bool noMoreData,
  ) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ArticleWidget(
              article: articles[index],
            ),
            childCount: articles.length,
          ),
        ),
        if (!noMoreData)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 14, bottom: 32),
              child: CupertinoActivityIndicator(),
            ),
          )
      ],
    );
  }
}
