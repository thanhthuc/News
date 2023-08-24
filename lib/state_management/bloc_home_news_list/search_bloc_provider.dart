
import 'package:flutter/material.dart';
import 'news_home_bloc.dart';

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
    super.dispose();
    widget.bloc.dispose();
  }
}