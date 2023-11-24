part of 'contact_page_bloc.dart';

abstract class ContactsPageState {}

class ContactsPageInitial extends ContactsPageState {}

class ContactsPageLoadingState extends ContactsPageState {}

class ContactsPageErrorState extends ContactsPageState {
  final String error;
  ContactsPageErrorState(this.error);
}

class ContactsPageDataState extends ContactsPageState {
  final String data;
  ContactsPageDataState(this.data);
}
