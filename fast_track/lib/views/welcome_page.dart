import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/views/login/login_screen.dart';
import 'package:flutter/material.dart';





class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Widget> slides = [
    const Slide(
      imageUrl: 'assets/images/public.jpg',
      title: 'Welcome to Government Services App',
      description: 'Engage with government services, make recommendations, report incidents, and view events.',
    ),
    const Slide(
      imageUrl: 'assets/images/front.jpg',
      title: 'Explore the Services',
      description: 'Discover a wide range of government services at your fingertips.',
    ),
    const Slide(
      imageUrl: 'assets/images/governmentworkers.jpg',
      title: 'Make a Difference',
      description: 'Contribute to your community by reporting incidents and making recommendations.',
    ),
    const Slide(
      imageUrl: 'assets/images/connect.jpg',
      title: 'Stay Informed',
      description: 'Stay updated with the latest events and news from your government.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextSlide() {
    if (_currentPage < slides.length - 1) {
      _currentPage++;
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: slides.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (ctx, index) {
              return slides[index];
            },
          ),
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                   Constants().p_button),
                            ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const Login()));
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Constants().p_button_text,
                      fontSize: 16,
                    ),
                  ),
                ),
                DotsIndicator(
                  dotsCount: slides.length,
                  position: _currentPage,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                   Constants().s_button),
                            ),
                  onPressed: _goToNextSlide,
                  child:  Text('Next',style: TextStyle(color: Constants().s_button_text),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Slide extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          opacity: 0.2,
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style:  TextStyle(
              color: Constants().tartiary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style:  TextStyle(
              color: Constants().s_button_text,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class DotsIndicator extends StatelessWidget {
  final int dotsCount;
  final int position;

  const DotsIndicator({
    required this.dotsCount,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(dotsCount, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == position ? Colors.white : Colors.white54,
          ),
        );
      }),
    );
  }
}
