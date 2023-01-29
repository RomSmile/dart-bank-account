import "dart:io";
import 'package:cli/services/AccountService.dart';
import 'package:cli/services/BankAccount.dart';
import 'Output.dart';
import 'package:cli/cli.dart';

void createAcc() async {
  print("Hi user, let's create a bank account");
  print("Enter the login:");
  String login = stdin.readLineSync()!;
  print("Enter the password:");
  String password = stdin.readLineSync()!;
  print("Repeat your password password:");
  String repeatPassword = stdin.readLineSync()!;

  Future<bool> isExistAcc = AccountService.isExistAcc(login);

  if (await isExistAcc == true) {
    printError('this Account already Exist \n');
    return projectRun();
  }

  BankAccount acc = BankAccount(login, password, repeatPassword, 0, true);
  return projectRun();
}

Future<void> enterTheAcc() async {
  print("Enter your Login");
  String login = stdin.readLineSync()!;
  Future<bool> isExistAcc = AccountService.isExistAcc(login);

  if (await isExistAcc != true) {
    printError('This account is not exist \n');
    return;
  }

  List<String> accInfo = await AccountService.getAccInfo(login);

  BankAccount enteredAccount = BankAccount(
      accInfo[0].split(":")[1],
      accInfo[1].split(":")[1],
      accInfo[1].split(":")[1],
      int.parse(accInfo[2].split(":")[1]),
      false);

  print("Enter the password");
  String password = stdin.readLineSync()!;

  if (password == enteredAccount.getPassword()) {
    print("You Entered your Account");
  } else {
    printError("Your password is incorrect");
    return projectRun();
  }

  print("Select a operation what you want to do");
  print("1.Put money");
  print("2.Get money");
  print("3.Send money");

  String userOperation = stdin.readLineSync()!;
  switch (int.parse(userOperation)) {
    case 1:
      print("Enter the amount of money");
      String money = stdin.readLineSync()!;
      enteredAccount.putMoney(int.parse(money));
      break;

    case 2:
      print("Enter the amount of money");
      String money = stdin.readLineSync()!;
      enteredAccount.getMoney(int.parse(money), true);
      break;

    case 3:
      print("Enter the login where you want to transfer money");
      String login = stdin.readLineSync()!;
      print("Enter the amount of money");
      String money = stdin.readLineSync()!;
      enteredAccount.transferMoney(login, int.parse(money));
      break;

    default:
      printWarning("We don't have this operation");
      break;
  }
}
