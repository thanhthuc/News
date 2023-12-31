
import 'package:flutter/material.dart';
import '../bloc_home_news_list/news_home_bloc.dart';

class SearchBlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;
  const SearchBlocProvider({
    super.key,
    required this.bloc,
    required this.child
  });

  static T of<T extends Bloc>(BuildContext context) {
    final SearchBlocProvider<T> provider = context.findAncestorWidgetOfExactType()!;
    return provider.bloc;
  }

  @override
  State<StatefulWidget> createState() => SearchBlocProviderState();
}

class SearchBlocProviderState extends State<SearchBlocProvider> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    // TODO: implement dispose
    widget.bloc.dispose();
    super.dispose();
  }
}