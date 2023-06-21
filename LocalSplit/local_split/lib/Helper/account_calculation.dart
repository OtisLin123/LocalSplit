import 'package:local_split/Manager/person_manager.dart';
import 'package:local_split/Model/person_data.dart';
import 'package:local_split/Model/spend_data.dart';

class AccountDetail {
  AccountDetail({
    required this.creditor,
    required this.debtor,
    required this.cost,
  });
  String creditor;
  String debtor;
  double cost;
}

class CheckIntegrateResult {
  CheckIntegrateResult({
    this.firstIndex = -1,
    this.secondIndex = -1,
    this.isNeed = false,
  });
  int firstIndex;
  int secondIndex;
  bool isNeed;
}

class AccountList {
  List<AccountDetail> accountDetails = [];

  void addAccount(AccountDetail account) {
    if (account.cost <= 0) {
      return;
    }
    for (AccountDetail accountDetail in accountDetails) {
      if (accountDetail.creditor == account.creditor &&
          accountDetail.debtor == account.debtor) {
        accountDetail.cost += account.cost;
        return;
      }
    }
    accountDetails.add(account);
  }

  void integrate() {
    CheckIntegrateResult result = needIntegrate();
    if (!result.isNeed) {
      return;
    }

    while (result.isNeed) {
      AccountDetail firstDetail = accountDetails.elementAt(result.firstIndex);
      AccountDetail secondDetail = accountDetails.elementAt(result.secondIndex);
      accountDetails.remove(firstDetail);
      accountDetails.remove(secondDetail);

      double delta = firstDetail.cost - secondDetail.cost;
      if (delta > 0) {
        firstDetail.cost = delta;
        accountDetails.add(firstDetail);
      } else if (delta < 0) {
        secondDetail.cost = delta.abs();
        accountDetails.add(secondDetail);
      }
      result = needIntegrate();
    }
  }

  CheckIntegrateResult needIntegrate() {
    for (int i = 0; i <= accountDetails.length - 1; i++) {
      for (int j = i + 1; j < accountDetails.length; j++) {
        if (accountDetails[i].creditor == accountDetails[j].debtor &&
            accountDetails[i].debtor == accountDetails[j].creditor) {
          return CheckIntegrateResult(
            firstIndex: i,
            secondIndex: j,
            isNeed: true,
          );
        }
      }
    }
    return CheckIntegrateResult(
      isNeed: false,
    );
  }
}

class AccountCalculation {
  List<AccountDetail> calculation(List<SpendData> spendDatas) {
    AccountList accountList = AccountList();
    for (SpendData data in spendDatas) {
      if (data.splitPeople.isEmpty) {
        break;
      }

      double averageCost = data.cost / data.splitPeople.length;
      for (PersonData splitPerson in data.splitPeople) {
        if (data.paidPerson.key != splitPerson.key) {
          accountList.addAccount(
            AccountDetail(
              creditor: data.paidPerson.key,
              debtor: splitPerson.key,
              cost: averageCost,
            ),
          );
        }
      }
    }

    accountList.integrate();
    for (AccountDetail detail in accountList.accountDetails) {
      print(
          "${PersonManager().getPersonName(detail.creditor)} <- ${PersonManager().getPersonName(detail.debtor)} cost: ${detail.cost}");
    }

    return accountList.accountDetails;
  }
}
