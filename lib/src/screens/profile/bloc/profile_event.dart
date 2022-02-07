part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class GetMyProfile extends ProfileEvent {}

class GetDocumentTypes extends ProfileEvent {}
