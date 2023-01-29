import "dart:io";
import 'BankAccount.dart';

class AccountService {
  static Future<bool> isExistAcc(String login) async {
    Directory baseFolder = Directory("./usersAccounts");
    bool isExist = false;

    await baseFolder.list().forEach((element) {
      String name =
          element.path.replaceFirst(RegExp(r"./usersAccounts"), '', 0);
      String nameForCheck = '';
      for (int i = 0; i < name.length; i++) {
        if (i != 0) {
          nameForCheck += name[i];
        }
      }
      if (login == nameForCheck) {
        isExist = true;
      }
    });

    return isExist;
  }

  void createOrRewriteAcc(String nameOfFile, BankAccount acc) async {
    String fileName = './usersAccounts/$nameOfFile';
    File file = File(fileName);
    file.writeAsStringSync(
        'Login:${acc.login},Password:${acc.getPassword()},Balance:${acc.balance}');
  }

  static Future<List<String>> getAccInfo(String login) async {
    String info = await File('./usersAccounts/$login')
        .readAsString()
        .then((String contents) {
      return contents;
    });

    return info.split(",");
  }

  //unusable method
  Future<String> findLogin(String login) async {
    Directory baseFolder = Directory("./usersAccounts");
    String foundedLogin = "";
    await baseFolder.list().forEach((element) {
      String name =
          element.path.replaceFirst(RegExp(r"./usersAccounts"), '', 0);
      String nameForOutput = '';
      for (int i = 0; i < name.length; i++) {
        if (i != 0) {
          nameForOutput += name[i];
        }
      }
      if (login == nameForOutput) {
        foundedLogin = nameForOutput;
      }
    });
    return foundedLogin;
  }

  //unusable method
  Future<List<String>> getArrayOfFiles() async {
    Directory baseFolder = Directory("./usersAccounts");
    List<String> listOfNames = List<String>.empty(growable: true);
    await baseFolder.list().forEach((element) {
      String name =
          element.path.replaceFirst(RegExp(r"./usersAccounts"), '', 0);
      String nameForOutput = '';
      for (int i = 0; i < name.length; i++) {
        if (i != 0) {
          nameForOutput += name[i];
        }
      }
      listOfNames.add(nameForOutput);
    });
    return listOfNames;
  }
}
