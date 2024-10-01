import 'package:bento_arena/controller.dart';
import 'package:flutter/material.dart';

import '../welcome.dart';

class HiThere extends StatelessWidget {
  const HiThere({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomePage(title: 'hi there,', description: [
      'welcome to bento, where you can have fun with combat robotics from your bed.'], next_page: ThisIsBento(), img: 'https://images.unsplash.com/photo-1725610588097-9ba8efa96b17?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxNHx8fGVufDB8fHx8fA%3D%3D');
  }
}

class ThisIsBento extends StatelessWidget {
  const ThisIsBento({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomePage(title: 'i am Bento Bot', description: [
      'I might look cute, but I hit hard'], next_page: ControlAnywhere(),
        img: 'https://images.unsplash.com/photo-1622599511051-16f55a1234d0?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Ym94aW5nfGVufDB8fDB8fHww'
    );
  }
}

class ControlAnywhere extends StatelessWidget {
  const ControlAnywhere({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomePage(title: 'remote control', description: [
      'i am in Florida, US. however, this application allows you to control me from anywhere in the world'], next_page: ControllerPage(),
        img: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Z2xvYmFsfGVufDB8fDB8fHww'
    );
  }
}

