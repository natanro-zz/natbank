import 'package:flutter/material.dart';
import 'package:natbank/models/contact.dart';
import 'package:natbank/screens/contact_form.dart';
import 'package:natbank/screens/transaction_form.dart';
import 'package:natbank/widgets/app_dependencies.dart';
import 'package:natbank/widgets/progress.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tranferências'),
      ),
      body: FutureBuilder<List<Contact>>(
          initialData: List(),
          future: dependencies.contactDAO.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
                break;
              case ConnectionState
                  .active: // casos de stream ou download (10% carregado, já devolve)
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Contact> contacts = snapshot.data;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      Contact contact = contacts[index];
                      return ContactItem(
                        contact,
                        onClick: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TransactionForm(contact),
                            ),
                          );
                        },
                      );
                    },
                    itemCount: contacts.length,
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('Sem contatos'),
                      ],
                    ),
                  );
                }
                break;
            }

            return Text('Unknown error');
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(builder: (context) => ContactForm()),
              )
              .then((value) => _reload());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _reload() => setState(() {});
}

class ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  const ContactItem(
    this.contact, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
