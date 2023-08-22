/// This bloc provider base on stateful widget//////import 'package:flutter/material.dart';import 'package:news/state_management/bloc_home_news_list/news_home_bloc.dart';class NewsBlocProvider<T extends Bloc> extends StatefulWidget {  final Widget child;  final T bloc;  const NewsBlocProvider({    super.key,    required this.bloc,    required this.child  });  static T of<T extends Bloc>(BuildContext context) {    final NewsBlocProvider<T> provider = context.findAncestorWidgetOfExactType()!;    return provider.bloc;  }  @override  State<StatefulWidget> createState() => NewsBlocProviderState();}class NewsBlocProviderState extends State<NewsBlocProvider> {  @override  Widget build(BuildContext context) => widget.child;  @override  void dispose() {    // TODO: implement dispose    super.dispose();    widget.bloc.dispose();  }}