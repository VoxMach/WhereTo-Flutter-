import 'package:flutter/material.dart';
import '../styletext.dart';

class AnimationWaveTrial extends StatefulWidget {
  @override
  _AnimationWaveTrialState createState() => _AnimationWaveTrialState();
}

class _AnimationWaveTrialState extends State<AnimationWaveTrial>
  with SingleTickerProviderStateMixin
 {

   Animation<double> animation;
   AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();
    animation = Tween<double>(begin: -500,end: 0 ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return  AnimationClip(
      animation
    );
  }
}


class AnimationClip extends AnimatedWidget{

  final Animation<double> animation;

  AnimationClip(this.animation) : super(listenable: animation);

  final Color color = pureblue;
  // Color(0xFF176DB5);  
  // Color(0xFF0C375B);
  @override
  Widget build(BuildContext context) {
      return Column(
      children: [
        Expanded(
          child: Stack(children: [
            Positioned(
              bottom: 0,
              right: animation.value,
              child: ClipPath(
                
                clipper: BottomWaveClipper(),
                child: Opacity(
                  opacity: 0.7,
                  child: Container(
                    color: color,
                    width: 2000,
                    height: 200,
                    
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: animation.value,
              child: ClipPath(
                clipper: BottomWaveClipper(),
                child: Opacity(
                  opacity: 0.7,
                  child: Container(
                    color: color,
                    width: 2000,
                    height: 200,
                   
                  ),
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }


}
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, 40.0);
    // path.lineTo(0.0, double.infinity);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 40.0);
    // path.lineTo(size.width, double.infinity);

    for (int i = 0; i < 10; i++) {
      if (i % 2 == 0) {
        path.quadraticBezierTo(
            size.width - (size.width / 16) - (i * size.width / 8),
            0.0,
            size.width - ((i + 1) * size.width / 8),
            size.height - 160);
      } else {
        path.quadraticBezierTo(
            size.width - (size.width / 16) - (i * size.width / 8),
            size.height - 120,
            size.width - ((i + 1) * size.width / 8),
            size.height - 160);
      }
    }

    path.lineTo(0.0, 40.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}