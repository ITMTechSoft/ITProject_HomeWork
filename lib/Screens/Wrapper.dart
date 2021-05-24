import 'package:flutter/material.dart';
import 'package:it_project_homework/ProviderCase/ProviderCase.dart';
import 'package:provider/provider.dart';

import 'Authenticate/LoginPage.dart';
import 'Home/MainActivity.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // SharedPref sharedPref = SharedPref();
  // MTM_UsersBLL userLoad = MTM_UsersBLL();

  @override
  void initState() {
    super.initState();
    // loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    var AppUser = PersonalCase.GetCurrentUser();
    if (!(AppUser!=null ? AppUser.ValidUser: false)) {
      return LoginPage();
    } else {
      return MainActivity();
    }
  }
}
