class BankAccount {
  final int accountId;
  final String accountOwner;
  double _balance = 0.0;

  BankAccount(this.accountId, this.accountOwner);

  double get balance => _balance;

  void credit(double amount) {
    _balance += amount;
  }

  void withdrawal(double amount) {
    if (balance - amount < 0) {
      throw Exception('Insufficient balance for withdrawal!!!');
    }
    _balance -= amount;
  }
}

class Bank {
  final String name;
  final List<BankAccount> _account = [];

  Bank({required this.name});

  BankAccount createAccount(int accountId, String accountOwner) {
    for (var acc in _account) {
      if (acc.accountId == accountId) {
        throw Exception('Account with ID $accountId already exist!');
      }
    }
    var newAccount = BankAccount(accountId, accountOwner);
    _account.add(newAccount);
    return newAccount;
  }

  List<BankAccount> get accounts => _account;
}

void main() {
  Bank myBank = Bank(name: "CADT Bank");
  BankAccount dimAccount = myBank.createAccount(1, "dim");

  print('balance: ${dimAccount.balance}'); // bal: 0.0
  dimAccount.credit(150);
  dimAccount.withdrawal(50);
  print('new balance: ${dimAccount.balance}'); // bal: 100

  try {
    dimAccount.withdrawal(200);
  } catch (e) {
    print(e);
  }

  try {
    myBank.createAccount(1, "Mr.Van");
  } catch (e) {
    print(e);
  }
}
