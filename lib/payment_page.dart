import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:payment_app/payment_response.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Razorpay _razorpay;
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }
  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading:Icon(Icons.menu),
        title: Text('Payment Demo'),
        centerTitle: true,
        actions: [
          Icon(Icons.shopping_cart)
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.fromLTRB(15,0,15,0),
        child: Column(
          children: [
            Container(height:300,child: Image.network('https://www.goalinn.com/f/13651/136513989/adidas-nemeziz-17.1-fg-football-boots.jpg')),
            SizedBox(height:10,),
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
                Text('ADIDAS',style:TextStyle(fontWeight:FontWeight.bold,fontSize:25),),
              ],
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
                Text('Nemeziz 17.1 FG Football Boots (Black,Blue)',style:TextStyle(fontSize:15),)
              ],
            ),
            SizedBox(height:5,),
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
                Text('Product Details',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold),)
              ],
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text('Designed with the ultimate goal of turning the game upside down, the adidas Nemeziz 17.1 FG will allow you to deploy unrivaled agility in the pitch. These junior football boots have a minimalist design that reduces weight and eliminates additional elements in order to guarantee the highest possible speed when invading the opposing team’s defensive line.',
                    style:TextStyle(fontSize:15),),
                )
              ],
            ),
            SizedBox(height:5,),
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
                Text('₹5,450 ',style:TextStyle(fontSize:30,fontWeight:FontWeight.bold),)
              ],
            ),
            SizedBox(height:10,),
            RaisedButton(color:Colors.blue,onPressed:(){
              payment();
            },child:Text('BUY NOW',style:TextStyle(color:Colors.white),),)
          ],
        ),
      ),
    );
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(response.paymentId);
    Fluttertoast.showToast(
        msg:'Amount Paid Successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white
    );
    Navigator.push(context,MaterialPageRoute(builder:(context)=>PaymentResponse(paymentId:response.paymentId)));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response.code);
    Fluttertoast.showToast(
        msg:response.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  void payment() {
    var options = {
      'key': 'rzp_test_IFCJH9gX64L18P',
      'amount': 545000, //in the smallest currency sub-unit.
      'name': 'ADIDAS',
      'description': 'Nemeziz 17.1 FG Football Boots (Black,Blue)',
      'timeout': 60, // in seconds
      'prefill': {
        'contact': '123456789',
        'email': 'st4251089@gmail.com'
      }
    };
    _razorpay.open(options);
  }
}
