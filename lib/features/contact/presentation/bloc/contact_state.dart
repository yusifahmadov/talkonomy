part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();  

  @override
  List<Object> get props => [];
}
class ContactInitial extends ContactState {}
