import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/address.dart';
import 'package:breakq/data/repositories/address_repository.dart';
import 'package:breakq/widgets/edit_text_widgets.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:breakq/utils/text_style.dart';

class AddEditAddress extends StatefulWidget {
  @override
  AddEditAddressState createState() => AddEditAddressState();
}

class AddEditAddressState extends State<AddEditAddress> {
  final GlobalKey<FormState> formKey =
      GlobalKey(debugLabel: "Form for add address");
  var address = Address();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          primary: true,
          pinned: true,
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Add/ Edit Address',
                style: Theme.of(context).textTheme.bodyText1.fs14),
            background: Row(
              children: [
                Spacer(),
                Expanded(
                  child: SvgPicture.asset(
                    AssetImages.addressIllustration,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: AutofillGroup(
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    FilledEditText(
                      hint: "Full Name",
                      isFirstField: true,
                      onSaved: (name) => address.setName = name,
                      error: "Please enter your name!",
                      autoFillHints: [AutofillHints.name],
                    ),
                    FilledEditText(
                      hint: "Phone Number",
                      inputTpe: TextInputType.phone,
                      onSaved: (phone) => address.setPhone = phone,
                      error: "Please enter your mobile number!",
                      autoFillHints: [AutofillHints.telephoneNumber],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: FilledEditText(
                            hint: "Pin Code",
                            inputTpe: TextInputType.number,
                            onSaved: (pinCode) => address.setPinCode = pinCode,
                            error: "Please fill the pin code!",
                            autoFillHints: [AutofillHints.postalCode],
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 10,
                          child: FilledEditText(
                            hint: "House No/Building",
                            onSaved: (houseNo) => address.setHouseNo = houseNo,
                            inputTpe: TextInputType.streetAddress,
                            error: "Please fill the house no!",
                            autoFillHints: [AutofillHints.streetAddressLevel1],
                          ),
                        ),
                      ],
                    ),
                    FilledEditText(
                      hint: "Street, Colony, Locality, Area",
                      onSaved: (street) => address.setStreet = street,
                      inputTpe: TextInputType.streetAddress,
                      error: "Please fill the address line!",
                      autoFillHints: [AutofillHints.streetAddressLevel2],
                    ),
                    FilledEditText(
                      hint: "Landmark (optional)",
                      onSaved: (landmark) => address.setLandmark = landmark,
                      autoFillHints: [AutofillHints.streetAddressLevel3],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: FilledEditText(
                            hint: "State",
                            onSaved: (state) => address.setState = state,
                            error: "Please fill the state!",
                            autoFillHints: [AutofillHints.addressState],
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 5,
                          child: FilledEditText(
                            hint: "City",
                            onSaved: (city) => address.setCityTown = city,
                            error: "Please fill the city!",
                            isLastField: true,
                            autoFillHints: [AutofillHints.addressCity],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ThemeButton(
                      text: "Add Address",
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          await AddressRepository().addOrUpdate(address);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
