import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:motel/presentation/guest_info_screen.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  double _slideProgress = 0.0;
  double _dragOffset = 0.0; // Смещение для точки

  late AnimationController _arrowAnimationController;
  late Animation<double> _arrowAnimation;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _arrowAnimation = Tween<double>(begin: 0, end: 5).animate(
      CurvedAnimation(parent: _arrowAnimationController, curve: Curves.easeInOut),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) _arrowAnimationController.reverse();
      if (status == AnimationStatus.dismissed) _arrowAnimationController.forward();
    });
    _arrowAnimationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _arrowAnimationController.dispose();
    super.dispose();
  }

  void _onPointerMove(PointerMoveEvent details, double sliderWidth) {
    if (details.buttons == kPrimaryMouseButton) {
      setState(() {
        // Обновляем прогресс и смещение точки
        _slideProgress = (_slideProgress + details.delta.dx / sliderWidth).clamp(0.0, 1.0);
        _dragOffset = _slideProgress * sliderWidth;
      });
    }
  }

  void _onPointerUp(PointerUpEvent details) {
    if (_slideProgress > 0.8) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => GuestInfoScreen(),
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _slideProgress = 0.0;
            _dragOffset = 0.0;
          });
        }
      });
    } else {
      // Возвращаем слайдер в начальное положение с анимацией
      setState(() {
        _slideProgress = 0.0;
        _dragOffset = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _buildBackground('assets/images/hostel_social_area.jpg'),
              _buildBackground('assets/images/hostel_cozy_room.jpg'),
            ],
          ),
          _buildHud(context),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              // <<< ИЗМЕНЕНИЕ: Ограничиваем ширину слайдера
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500), // Максимальная ширина
                child: LayoutBuilder(builder: (context, constraints) {
                  final sliderWidth = constraints.maxWidth - 80; // Ширина контейнера минус отступы
                  return Listener(
                    onPointerMove: (event) => _onPointerMove(event, sliderWidth),
                    onPointerUp: _onPointerUp,
                    child: _buildSlideToUnlock(sliderWidth),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(String imagePath) => Container(
    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover)),
  );

  Widget _buildHud(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      top: screenHeight * 0.15,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Text(
            '15:15',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.25,
              fontWeight: FontWeight.w200,
              height: 0.9,
              letterSpacing: -5,
              shadows: const [
                Shadow(blurRadius: 20, color: Colors.black54),
                Shadow(blurRadius: 40, color: Colors.black54),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            'Среда, 16 июля',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w500,
              shadows: const [Shadow(blurRadius: 5, color: Colors.black54)],
            ),
          ),
        ],
      ),
    );
  }

  // <<< ИЗМЕНЕНИЕ: Полностью переработанный слайдер с точкой и заполнением
  Widget _buildSlideToUnlock(double sliderWidth) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      height: 60, // Задаем фиксированную высоту
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Эффект заполнения
          AnimatedContainer(
            duration: const Duration(milliseconds: 100), // Плавность заполнения
            width: _dragOffset + 60, // Ширина заполнения + ширина точки
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4), // Цвет заполнения
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          // Текст-подсказка
          Center(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: const [Colors.white24, Colors.white, Colors.white24],
                stops: const [0.0, 0.5, 1.0],
                transform: _SlideGradientTransform(_slideProgress),
              ).createShader(bounds),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _arrowAnimation,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(_arrowAnimation.value, 0),
                      child: const Row(children: [
                        Icon(CupertinoIcons.chevron_right, color: Colors.white, size: 24),
                        Icon(CupertinoIcons.chevron_right, color: Colors.white, size: 24),
                      ]),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('Потяни для разблокировки', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          // "Точка" для перетаскивания
          Positioned(
            left: _dragOffset,
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(CupertinoIcons.arrow_right, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}


class _SlideGradientTransform extends GradientTransform {
  final double progress;
  const _SlideGradientTransform(this.progress);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(bounds.width * progress * 2 - bounds.width, 0.0, 0.0);
}