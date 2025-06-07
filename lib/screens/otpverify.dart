import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPVerifyPage extends StatefulWidget {
  const OTPVerifyPage({super.key});

  @override
  _OTPVerifyPageState createState() => _OTPVerifyPageState();
}

class _OTPVerifyPageState extends State<OTPVerifyPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  bool _isResendButtonEnabled = false;
  int _secondsRemaining = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 60;
      _isResendButtonEnabled = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isResendButtonEnabled = true;
        });
        timer.cancel();
      }
    });
  }

  void _resendCode() {
    if (_isResendButtonEnabled) {
      _startTimer();
      // Add your resend code logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP code resent')),
      );
    }
  }

  String _getOTP() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter Verification Code ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 120),
            const Text(
              'Enter the 6-digit OTP sent to your phone',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 40,
                  child: TextField(
                    controller: _otpControllers[index],
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final otp = _getOTP();
                if (otp.length == 6) {
                  // Add your OTP verification logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('OTP Verified: $otp')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter all 6 digits')),
                  );
                }
              },
              child: const Text('Verify'),
            ),
            const SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isResendButtonEnabled
                        ? 'You can resend the code now'
                        : 'Resend code in $_secondsRemaining seconds',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: _isResendButtonEnabled ? _resendCode : null,
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        color: _isResendButtonEnabled
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
