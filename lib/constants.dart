import 'package:flutter/material.dart';

class AppPreferencesHelper {
  static const String USER_INFO = "userInfo";
  static const String LINK_TOKEN = "linkToken";
  static const String ACCESS_TOKEN = "accessToken";

  static const String CLIENT_ID = "649e90bb49f07c0018fdac7b";
  static const String SECRET_KEY = "2b3f3b3801c4939683101f32036c89";
}

const primaryColor = Color(0xFF2697FF);
const darkBlueColor = Color(0xFF2573EF);
const lightBlueColor = Color(0xFF91C5FA);
const blueColor = Colors.blue;
// const secondaryColor = Color(0xFF2A2D3E);
// const bgColor = Color(0xFF212332);
//
const secondaryColor = Colors.white;
const bgColor = Color(0xFFF5F5F5);

const textFieldBgColor = Color(0xFFF5F4FF);

const textColor = Color(0xFF666666);

const textLightColor = Color(0xFFCECECE);

const defaultPadding = 16.0;

const placeHolderImg =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNg9FjmQSz3-2pDVFp4EM3NTQn91ApoG3o_tPrcE11S2d2XPoFKTDvPydg4-bK5224i6k&usqp=CAU';

const errorEmptyFieldMessage = 'Please Enter Value';
const errorEmptySelectMessage = 'Please Enter Value';

const defaultHeight = 900;
const defaultWidth = 1350;

// ::::::::::::::::::: ACCOUNT TYPES

const enterPrise = 'Enterprise (Corporation or Trust)';
const individual = 'Individual';

// Sing in With
const singInWithPhone = 'Phone';
const singInWithEmail = 'Email';

// User Status
const userNew = 'New';
const userPending = 'Pending';
const userApproved = 'Approved';

// :::::: USERs VARIABLES  ::::::::::::::::::::::::::

// Employ Status Fields
const selfEmployed = 'Self Employed';
const employed = 'Employed';
const unemployed = 'Unemployed';
const retired = 'Retired';
const student = 'Student';

// Relationship Status
const singleOrDating = 'Single or Dating';
const married = 'Married';
const domesticPartner = 'Domestic Partner';
const widowed = 'Widowed';
const divorced = 'Divorced';

// AMIA Account Status
const income = 'Income';
const retirementSavings = 'Retirement Savings';
const gift = 'Gift';
const other = 'Other';

// yer or no
const yesValue = 'Yes';
const noValue = 'No';

// Risk Level
const moderate = 'Moderate';
const aggressive = 'Aggressive';
const conservative = 'Conservative';

// Document's Type
const driverLicense = 'Driver\'s License';
const socialSecurityCard = 'Social Security Card';

// :::::: ENTERPRICE VARIABLES :::::::::::::::::::::::::

// Local variables
const statement1 =
    'The net worth of each owner is \$1M+ (excluding primary residence)';
const statement2 =
    'The individual income of each owner was \$200k+ for each of the past two';
const statement3 =
    'Are you or anyone in your household associated with a FINRA Member?';
const statement4 = 'The entity has total assets exceeding';
const statement5 =
    'For each owner, their joint income including their spouse was \$300k';

// :::::: PROPERTY VARIABLES  ::::::::::::::::::::::::::

// Employ Status Fields
const publicStatus = 'Public';
const privateStatus = 'Private';

// offer Status Fields
const currentOffer = 'Current';
const futureOffer = 'Future';
