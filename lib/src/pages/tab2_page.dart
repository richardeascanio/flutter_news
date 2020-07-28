import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:news_app/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _ListaCategorias(),
            Expanded(
              child: ListaNoticias(newsService.getArticulosCateriaSeleccionada)
            ),
          ],
        )
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 85.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final String categoryName = categories[index].name;
          return Padding(
            padding: EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0, top: 12.0),
            child: Column(
              children: <Widget>[
                _CategoryButton(category: categories[index]),
                SizedBox(height: 5.0,),
                Text('${categoryName[0].toUpperCase()}${categoryName.substring(1)}')
              ],
            ),
          );
        }
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Category category;

  const _CategoryButton({this.category});

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == category.name) 
            ? myTheme.accentColor
            : Colors.black54,
        ),
      ),
    );
  }
}