part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileUnsuccessful extends ProfileState {
  ProfileUnsuccessful({required this.errorMessage});
  final String errorMessage;
}

class ProfileSuccessful extends ProfileState {
  ProfileSuccessful({required this.profileModel});
  final ProfileModel profileModel;
}

class DocumentTypesLoading extends ProfileState {}

class DocumentTypesUnsuccessful extends ProfileState {
  DocumentTypesUnsuccessful({required this.errorMessage});
  final String errorMessage;
}

class DocumentTypesSuccessful extends ProfileState {
  DocumentTypesSuccessful({required this.documentTypes});
  final List<String> documentTypes;
}
