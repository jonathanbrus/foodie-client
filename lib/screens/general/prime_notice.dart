import 'package:flutter/material.dart';

class PrimeNotice extends StatelessWidget {
  const PrimeNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("Alo Prime Notice"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 40,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/primenotice.jpg",
              ),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
