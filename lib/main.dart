import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Preferences/SetupApplication.dart';
import 'ProviderCase/ProviderCase.dart';
import 'Screens/Wrapper.dart';
import 'assets/Themes/SystemTheme.dart';

void main() => runApp(ChangeNotifierProvider<ThemeNotifier>(
  create: (_) => ThemeNotifier(),
  child: ITProjectHomeWork(),
));

class ITProjectHomeWork extends StatefulWidget {
  @override
  _ITProjectHomeWorkState createState() => _ITProjectHomeWorkState();
}

class _ITProjectHomeWorkState extends State<ITProjectHomeWork> {
  PersonalProvider PersonalCase = new PersonalProvider();
  bool IsLoading = false;

  Future<bool> LoadingSharedPreference(PersonalCase) async {
    await PersonalCase.loadSharedPrefs();
    /*  setState(() {
      IsLoading = false;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    Widget RetVal(bool IsSystemConfigValid) {
      Widget TargetItem;
      if (IsSystemConfigValid == false)
        TargetItem = SetupApplication();
      else
        TargetItem = Wrapper();
      return TargetItem;
    }

    return FutureBuilder(
        future: LoadingSharedPreference(PersonalCase),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return ChangeNotifierProvider<PersonalProvider>(
              create: (context) => PersonalCase,
              child: IsLoading
                  ? Center(child: CircularProgressIndicator())
                  : MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: themeNotifier.GetTheme(),
                  home: RetVal(snapshot.data)));
        });
  }
}