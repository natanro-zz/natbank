class Account {
  int id;
  int number;
  String agency;
  double balance;

  Account({
    this.id,
    this.number,
    this.agency,
    this.balance,
  });

  Account.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.number = json['number'];
    this.agency = json['agency'];
    this.balance = json['balance'];
  }
}
