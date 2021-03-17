/*********************************************************************
   FILE: prog1.cc
   PROGRAMMER: Bryan Butz
   LOGON ID: z1836033
   DUE DATE: 9/24/2019
   FUNCTION: This file contains the functions and driver program for
             a full adder of two strings that represent binary numbers
             of any length. It also displays parity as well as flags
             representing if signed or unsigned overflow occurs and if
             its value equals zero.
*********************************************************************/

#include <iostream>
#include <iomanip>

using namespace std;

string adder(string, string, int);
string diff(string, string);
string parity(string);
string flags(string);
string subtrahend(string);

bool sOverflow = false;
bool uOverflow = false;

int main()
   {
     string bin1;
     string bin2;


	while( cin >> bin1 && cin >> bin2 )
	 {

	  cout<<left<<setw(5)<<"v1"<<setw(5)<<parity(bin1)<<"    "<<setw(5)<<bin1<<"\n";

	  cout<<left<<setw(5)<<"v2"<<setw(5)<<parity(bin2)<<"    "<<setw(5)<<bin2<<"\n";

	  cout<<left<<setw(5)<<"sum"<<setw(5)<<parity(adder(bin1,bin2,0))<<setw(4)<<flags(adder(bin1,bin2,0))<<setw(5)<<adder(bin1,bin2,0)<<"\n";

          cout<<left<<setw(5)<<"diff"<<setw(5)<<parity(adder(bin1,subtrahend(bin2),1))<<setw(4)<<flags(adder(bin1,subtrahend(bin2),1));
            cout<<setw(5)<<adder(bin1,subtrahend(bin2),1)<<"\n";

	  cout<<endl;
	 }


    return 0;
   }


/**
* This is the binary full adder to add or subtract binary numbers
*
* This function takes in two binary strings and a carry in value
* to either add or subtract two binary numbers. The carry in value will
* determine the operation and after going through the arithemtic operation
* of adding or subtracting, while taking note of carry in/out value of the MSB,
* will also flag the global variables signifying signed or unsigned overflow.
*
* @string bin1 - A string to represent the first binary number
* @string bin2 - A string to represent the second binary number
* @int cIn - An integer value to represent the carry in value to start. If a
*            0 is passed in the adder will add or if a 1 is passed it'll subtract
*
* @string sum - The sum of two binary numbers represented by strings. Can either
*               represent the sum of two passed in binary numbers or the sum of
*               a passed in binary number with the subtrahend of another(subtracting)
*
*****************************************************************************/
string adder(string bin1, string bin2, int cIn )
  {
     string sum="";

    int carry = cIn; // Initialize carry in
    int msbCarry = 0;

    // Reset overflow flags
    sOverflow = false;
    uOverflow = false;

    // Traverse both strings starting from LSB
    int i = bin1.size() - 1;
    int j = bin2.size() - 1;


    while( i >= 0 || j >= 0 )
    {
        msbCarry = carry;

        // Find sum of last digits and carry
        carry += ((i >= 0)? bin1[i] - '0': 0);
        carry += ((j >= 0)? bin2[j] - '0': 0);

        // If current sum is 1 or 3, add 1 to result
        sum = char(carry % 2 + '0') + sum;

        // Determine carry
        carry /= 2;


       //Check if signed overflow occured
        if( carry != msbCarry && i == 0 )
           sOverflow = true;


       //For subtracting, invert carry out of MSB
       //to determine if unsigned overflow occured
	if( cIn == 1 && carry == 1 && i == 0 )
          carry = 0;
        else if( cIn == 1 && carry == 0 && i == 0 )
          carry = 1;


	//Check if unsigned overflow occured
        if( carry == 1 && i == 0 )
          uOverflow = true;

        // Move to next digits
        i--; j--;
    }


  return sum;
  }


/**
* Returns the subtrahend of a binary number.
*
* This function takes in a binary number of any length and inverts
* all the bits one at a time to obtain the subtrahend to be used in
* binary subtraction.
*
* @string binNum - The binary number who's subtrahend will be returned
*
* @string subtra - The subtrahend of the passed in binary number
*
*****************************************************************************/
string subtrahend( string binNum )
{
  string subtra = "";
  int binLength = binNum.length();

    for( int i = 0; i <= binLength; i++ )
     {
      if( binNum[i] == '0' )
       subtra += "1";
      else if( binNum[i] == '1' )
       subtra += "0";
    }

 return subtra;
}


/**
* Returns the parity value of a binary number
*
* This takes in a string of a binary number of any length and loops through
* each bit to determine the number of 1s in the entire number. It then divides
* that number to determine if it's even or odd and thus returns its parity.
*
* @string binNum - The binary number who's parity is to be determined
*
* @string evenOdd - The parity value of the passed in binary number,
*                   either even or odd
*
*****************************************************************************/
string parity(string binNum)
  {
    int evenOdd=0;
    int i = binNum.size() - 1;

    while( i >=0 )
     {
       if( binNum[i] == '1')
	 evenOdd++;

      i--;
     }


    if( evenOdd % 2 )
     return("odd");
    else
     return("even");

  }


/**
* Prints out the flags that symbolize overflow or value of zero
*
* This takes in a binary number to be tested for zero while also reading
* the global variables that were set in adder(string,string,int) and based
* on what has been set, creates one string with all the flags pertaining to
* if signed or unsigned overflow occured as well as if the number's value is 0.
*
* @string binToTest - The binary number to test after an arithmetic operation
*
* @string flagString - A string made to represent the set of flags that tell
*                      if signed or unsigned overflow occured or if the value
*                      is zero.
*
*****************************************************************************/
string flags( string binToTest )
{
  string flagString = "";
  bool zeroFlag=true;

  //Test for signed overflow
   if( sOverflow == true )
     flagString += "S";
   else
     flagString += " ";


  //Test for unsigned overflow
   if( uOverflow == true )
     flagString += "U";
   else
     flagString += " ";


  //Test for value of 0
      for( int i = binToTest.size(); i >=0; --i )
     {
       if( binToTest[i] == '1')
         zeroFlag = false;
     }

    if( zeroFlag == true )
      flagString += "Z";
    else
      flagString += " ";


  return flagString;
}
