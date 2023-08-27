import 'package:flutter/cupertino.dart';

import '../bloc_home_news_list/news_home_bloc.dart';

class LoginBlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;
  const LoginBlocProvider({
    super.key,
    required this.bloc,
    required this.child
  });

  static T of<T extends Bloc>(BuildContext context) {
    final LoginBlocProvider<T> provider = context.findAncestorWidgetOfExactType()!;
    return provider.bloc;
  }

  @override
  State<StatefulWidget> createState() => LoginBlocProviderState();
}

class LoginBlocProviderState extends State<LoginBlocProvider> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    // TODO: implement dispose
    widget.bloc.dispose();
    super.dispose();
  }
}