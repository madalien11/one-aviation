import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_aviation/src/common/widgets/buttons/pink_rounded_button.dart';
import 'package:one_aviation/src/common/widgets/passenger_data_text_field.dart';
import 'package:one_aviation/src/common/widgets/text/error_message.dart';
import 'package:one_aviation/src/constants/colors.dart';
import 'package:one_aviation/src/constants/spacing.dart';
import 'package:one_aviation/src/constants/text_styles.dart';
import 'package:one_aviation/src/models/document/document_model.dart';
import 'package:one_aviation/src/models/join_flight/join_flight_model.dart';
import 'package:one_aviation/src/models/passenger/passenger_model.dart';
import 'package:one_aviation/src/screens/flight/bloc/flights_bloc.dart';
import 'package:one_aviation/src/screens/flight/flight_screen.dart';
import 'package:one_aviation/src/screens/flight/widgets/flight_screen_image.dart';
import 'package:one_aviation/src/screens/profile/my_orders/widgets/my_order_card.dart';

List<int> documents = [1];

class AddPassengersScreen extends StatefulWidget {
  @override
  _AddPassengersScreenState createState() => _AddPassengersScreenState();
}

class _AddPassengersScreenState extends State<AddPassengersScreen> {
  int passengerNum = 2;
  List<PassengerDataTextField> _passengerDataTextFields = [];
  List<PassengerModel> _passengers = [];

  bool _isLoading = false;
  bool _showError = false;
  String _errorMessage = 'Fill in all the fields';

  @override
  void initState() {
    super.initState();
    documents.clear();
    documents.add(1);
    _passengerDataTextFields.add(
      PassengerDataTextField(
        number: 1,
        title: 'Passenger 1',
        passengerInfoFormkey: GlobalKey<FormState>(),
        nameTextController: TextEditingController(),
        surnameTextController: TextEditingController(),
        emailTextController: TextEditingController(),
        documentTextController: TextEditingController(),
        phoneTextController: TextEditingController(),
        onChanged: (int? value) {
          setState(() => documents[0] = value!);
        },
      ),
    );
    if (globalSearchFlightData != null) {
      int nums = globalSearchFlightData!.numberOfPassengers;
      for (int i = 2; i <= nums; i++) {
        documents.add(1);
        _passengerDataTextFields.add(
          PassengerDataTextField(
            number: i,
            title: 'Passenger $i',
            passengerInfoFormkey: GlobalKey<FormState>(),
            nameTextController: TextEditingController(),
            surnameTextController: TextEditingController(),
            emailTextController: TextEditingController(),
            documentTextController: TextEditingController(),
            phoneTextController: TextEditingController(),
            onChanged: (int? value) {
              setState(() => documents[i - 1] = value!);
            },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var pinkRoundedButton = PinkRoundedButton(
      title: 'Book Now',
      onTap: () {
        _passengers.clear();
        for (int i = 0; i < _passengerDataTextFields.length; i++) {
          var element = _passengerDataTextFields[i];
          if (element.passengerInfoFormkey.currentState!.validate()) {
            FocusScope.of(context).unfocus();
            setState(() => _showError = false);

            _passengers.add(
              PassengerModel(
                document: DocumentModel(
                  number: element.documentTextController.text,
                  type: documents[i] == 1 ? 'passport' : 'national ID',
                ),
                email: element.emailTextController.text,
                phoneNumber: element.phoneTextController.text,
                direction: 'FORWARD',
                firstName: element.nameTextController.text,
                lastName: element.surnameTextController.text,
              ),
            );
          } else {
            setState(() {
              _showError = true;
              _errorMessage = 'Fill in all the fields';
            });
          }
        }
        if (_showError == false) {
          var joinFlightModel = JoinFlightModel(
            document: DocumentModel(
              number: _passengers[0].document.number,
              type: _passengers[0].document.type,
              // type: documents[widget.number],
            ),
            email: _passengers[0].email,
            orderId: foundFlightId,
            passengers: _passengers.length == 1 ? [] : _passengers.sublist(1),
            phoneNumber: _passengers[0].phoneNumber,
          );
          print(joinFlightModel.toJson());
          context.read<FlightsBloc>().add(
                JoinFlight(passengersData: joinFlightModel),
              );
          // Navigator.pushNamed(context, '/flight/search');
        }
      },
    );

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocListener<FlightsBloc, FlightsState>(
          listener: (context, state) {
            if (state is JoinFlightLoading) {
              setState(() => _isLoading = true);
            } else {
              setState(() => _isLoading = false);
            }

            if (state is JoinFlightSuccessful) {
              setState(() => _showError = false);
              showDialog(
                  context: context,
                  builder: (_) {
                    // Future.delayed(Duration(milliseconds: 600), () {
                    //   Navigator.of(context).maybePop();
                    // });
                    return AlertDialog(
                      title: Text(
                        'Successfull!\nYou joined a flight.',
                        textAlign: TextAlign.center,
                        style: MyTextStyle.googleFontWrapper(
                          MyTextStyle.AlertDialogTextStyle,
                        ),
                      ),
                      content: Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        color: CupertinoColors.activeGreen,
                        size: 50,
                      ),
                    );
                  }).then((value) => Navigator.of(context).pop());
            } else if (state is JoinFlightUnsuccessful) {
              setState(() {
                _showError = true;
                _errorMessage = state.errorMessage;
              });
            }
          },
          child: _isLoading
              ? Center(child: CupertinoActivityIndicator())
              : SafeArea(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        FlightScreenImage(),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.33,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: double.infinity,
                            height:
                                MediaQuery.of(context).size.height * 0.67 - 40,
                            padding: paddingHorizontal40,
                            decoration: BoxDecoration(
                              color: ContainerBackgroundColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    'Personal Information',
                                    textAlign: TextAlign.center,
                                    style: MyTextStyle.googleFontWrapper(
                                      MyTextStyle.TitleTextStyle,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      for (int i = 0;
                                          i < _passengerDataTextFields.length;
                                          i++)
                                        _passengerDataTextFields[i],
                                      _showError
                                          ? ErrorMessage(
                                              errorMessage: _errorMessage)
                                          : SizedBox(),
                                      SizedBox(height: 10),
                                      globalSearchFlightData != null
                                          ? pinkRoundedButton
                                          : Row(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: PinkRoundedButton(
                                                    title: '+1',
                                                    onTap: () {
                                                      if (passengerNum < 8)
                                                        setState(() {
                                                          documents.add(1);
                                                          _passengerDataTextFields
                                                              .add(
                                                            PassengerDataTextField(
                                                              number:
                                                                  passengerNum,
                                                              title:
                                                                  'Passenger $passengerNum',
                                                              passengerInfoFormkey:
                                                                  GlobalKey<
                                                                      FormState>(),
                                                              nameTextController:
                                                                  TextEditingController(),
                                                              surnameTextController:
                                                                  TextEditingController(),
                                                              emailTextController:
                                                                  TextEditingController(),
                                                              documentTextController:
                                                                  TextEditingController(),
                                                              phoneTextController:
                                                                  TextEditingController(),
                                                              onChanged:
                                                                  (int? value) {
                                                                setState(() =>
                                                                    documents[passengerNum -
                                                                            1] =
                                                                        value!);
                                                              },
                                                            ),
                                                          );
                                                          passengerNum += 1;
                                                        });
                                                    },
                                                  ),
                                                ),
                                                Spacer(),
                                                Expanded(
                                                  flex: 20,
                                                  child: pinkRoundedButton,
                                                ),
                                                Spacer(),
                                                Expanded(
                                                  flex: 4,
                                                  child: PinkRoundedButton(
                                                    title: '-1',
                                                    onTap: () {
                                                      if (passengerNum > 2)
                                                        setState(() {
                                                          passengerNum -= 1;
                                                          _passengerDataTextFields
                                                              .removeAt(
                                                                  passengerNum -
                                                                      1);
                                                        });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                      SizedBox(height: 60),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
