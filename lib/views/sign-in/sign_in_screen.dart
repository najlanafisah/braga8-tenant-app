import 'package:braga8_tenant_app/views/dashboard/dashboard_screen.dart';
import 'package:braga8_tenant_app/widgets/main_layouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;
  final bool _isLoading = false;
  bool _isRememberMe = false;
  String? _emailError;
  String? _passwordError;

  final List<Shadow> _uiShadows = [
    Shadow(
      color: Colors.black.withValues(alpha: 0.5),
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: MainLayout(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.88,
              constraints: BoxConstraints(minHeight: 650),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: AssetImage('../../../assets/sign-in-bg.png'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.white12),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/logo.png', width: 45),
                    SizedBox(height: 40),
                    Text(
                      "Sign In to Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        shadows: _uiShadows,
                      ),
                    ),
                    SizedBox(height: 35),
                    _buildLabel("Email"),
                    _buildTextField(
                      controller: _emailController,
                      hint: "Enter your email",
                      errorText: _emailError,
                    ),
                    SizedBox(height: 5),
                    _buildLabel("Password"),
                    _buildTextField(
                      controller: _passwordController,
                      hint: "Enter your password",
                      isPassword: true,
                      isObscured: _isObscured,
                      errorText: _passwordError,
                      onSuffixTap: () =>
                          setState(() => _isObscured = !_isObscured),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildRememberMe(),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        if (mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardScreen(),
                            ),
                          );
                        }
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: AspectRatio(
                          aspectRatio: 3.6,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned.fill(
                                child: SvgPicture.asset(
                                  '../../../assets/login_btn.svg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(0, -6),
                                child: _isLoading
                                    ? SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : Text(
                                        "Log In",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          shadows: _uiShadows,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          shadows: _uiShadows,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool isPassword = false,
    bool isObscured = false,
    String? errorText,
    VoidCallback? onSuffixTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFDCC8BB),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword ? isObscured : false,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              border: InputBorder.none,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        isObscured ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey[700],
                      ),
                      onPressed: onSuffixTap,
                    )
                  : null,
            ),
          ),
        ),
        SizedBox(
          height: 28,
          child: errorText != null
              ? Padding(
                  padding: EdgeInsets.only(left: 4, top: 4),
                  child: Text(
                    errorText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : null,
        ),
      ],
    );
  }

  Widget _buildRememberMe() {
    return GestureDetector(
      onTap: () => setState(() => _isRememberMe = !_isRememberMe),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: _isRememberMe
                ? Icon(Icons.check, size: 16, fontWeight: FontWeight.bold, color: Color(0xFF8B5A2B))
                : null,
          ),
          SizedBox(width: 8),
          Text(
            "Remember me",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              shadows: _uiShadows,
            ),
          ),
        ],
      ),
    );
  }
}
