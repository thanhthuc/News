import 'dart:async';import 'package:news/model/news_model.dart';abstract class MultipleStreamI {  late StreamController<bool> streamIsAllNewsController;  late StreamController<bool> streamIsLoadingController;  late StreamController<List<News>> streamListController;}// TODO: use this api: https://github.com/MohamadSobhy/News-App-Hacker-News-Api---Flutter-// TODO: https://github.com/HackerNews/APIclass MultipleStream implements MultipleStreamI {  @override  StreamController<bool> streamIsAllNewsController = StreamController();  @override  StreamController<bool> streamIsLoadingController = StreamController();  @override  StreamController<List<News>> streamListController = StreamController();}