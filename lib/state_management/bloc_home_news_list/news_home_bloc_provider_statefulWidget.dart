/// This bloc provider base on stateful widget//////import 'package:flutter/material.dart';class NewsBlocProvider extends StatefulWidget {  const NewsBlocProvider({super.key});  @override  State<StatefulWidget> createState() => NewsBlocProviderState();}class NewsBlocProviderState extends State<NewsBlocProvider> {  @override  Widget build(BuildContext context) {    // TODO: implement build    return const Text("Provider");  }}