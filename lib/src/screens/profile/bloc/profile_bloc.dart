import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:one_aviation/src/models/profile/profile_model.dart';
import 'package:one_aviation/src/services/profile_services.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.profileService}) : super(ProfileInitial());
  final ProfileService profileService;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is GetMyProfile) {
      yield ProfileLoading();
      var res = await profileService.getMyProfile();
      if (res['successful']) {
        yield ProfileSuccessful(profileModel: res['message']);
      } else {
        yield ProfileUnsuccessful(errorMessage: res['message']);
      }
    }
  }
}
