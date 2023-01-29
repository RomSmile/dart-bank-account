import 'package:cli/cli.dart';

import 'AccountService.dart';
import 'package:cli/helpers/Output.dart';

class BankAccount extends AccountService {
  late String login;
  late String _password;
  late int balance = 0;

  BankAccount(String login, String password, String repeatPassword,
      int newBalance, bool isNew) {
    if (password == repeatPassword) {
      this.login = login;
      _password = password;
      balance = newBalance;
      if (isNew) {
        createOrRewriteAcc(login, this);
      }
    } else {
      printError("Your passwords are not the same");
    }
  }

  String getPassword() {
    return _password;
  }

  void putMoney(int money) {
    balance += money;
    createOrRewriteAcc(login, this);

    projectRun();
  }

  void getMoney(int money, bool isRecursive) {
    if (money <= balance) {
      balance -= money;
      createOrRewriteAcc(login, this);
    } else {
      printError("On your balance not enough money to get it");
    }
    if (isRecursive == true) {
      projectRun();
    }
  }

  void transferMoney(String login, int money) async {
    if (money > balance) {
      printError("You don't have enough money on your Acc");
      return;
    }

    if (await AccountService.isExistAcc(login) != true) {
      printError("this account is not exist");
      return;
    }

    getMoney(money, false);

    List<String> accToTransfer = await AccountService.getAccInfo(login);

    BankAccount enteredAccount = BankAccount(
        accToTransfer[0].split(":")[1],
        accToTransfer[1].split(":")[1],
        accToTransfer[1].split(":")[1],
        int.parse(accToTransfer[2].split(":")[1]),
        false);

    enteredAccount.putMoney(money);
  }
}
