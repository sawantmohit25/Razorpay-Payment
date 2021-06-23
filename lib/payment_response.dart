import 'package:flutter/material.dart';
class PaymentResponse extends StatelessWidget {
  String paymentId;
  PaymentResponse({@required this.paymentId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Payment Response'),
      ),
      body:Center(
        child:Card(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Text('Transaction Successful',style:TextStyle(fontWeight:FontWeight.bold,fontSize:25),),
                  Icon(Icons.check_circle,color:Colors.blue,size:30,)
                ],
              ),
              SizedBox(height:20),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceAround,
                children: [
                  Text('Payment Id:-',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold),),
                  Text(paymentId!=null?paymentId:'',style:TextStyle(fontSize:18),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
