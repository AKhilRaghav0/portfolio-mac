import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppProvider extends ChangeNotifier {
  // Portfolio data
  final Map<String, dynamic> _portfolioData = {
    'name': 'Akhil Raghav',
    'title': 'Full Stack Developer & CP Enthusiast',
    'location': 'India',
    'email': 'work@akhilraghav.com',
    'github': 'github.com/AKhilRaghav0',
    'description': 'Full Stack Developer specializing in Backend Development, Competitive Programming, and iOS Development',
    'skills': [
      'Flutter & Dart',
      'React & Node.js',
      'Python & Django',
      'Competitive Programming',
      'iOS Development',
      'System Design',
      'Backend Development',
      'Database Design',
    ],
    'projects': [
      {
        'name': 'macOS Portfolio',
        'description': 'A stunning macOS desktop experience built with Flutter Web',
        'tech': ['Flutter', 'Dart', 'Web'],
        'status': 'In Progress',
      },
      {
        'name': 'Competitive Programming Platform',
        'description': 'A platform for competitive programming contests and practice',
        'tech': ['React', 'Node.js', 'MongoDB'],
        'status': 'Completed',
      },
      {
        'name': 'iOS Finance App',
        'description': 'Personal finance management app with beautiful UI',
        'tech': ['Swift', 'CoreData', 'iOS'],
        'status': 'Completed',
      },
    ],
    'experience': [
      {
        'company': 'Tech Startup',
        'role': 'Full Stack Developer',
        'duration': '2022 - Present',
        'description': 'Developing scalable web applications and mobile solutions',
      },
      {
        'company': 'Freelance',
        'role': 'iOS Developer',
        'duration': '2021 - 2022',
        'description': 'Created iOS applications for various clients',
      },
    ],
  };
  
  // Chat functionality
  final List<Map<String, String>> _chatMessages = [];
  bool _isTyping = false;
  
  // App states
  final Map<String, bool> _appStates = {
    'finder': false,
    'terminal': false,
    'calculator': false,
    'calendar': false,
    'notes': false,
    'photos': false,
    'music': false,
    'mail': false,
    'safari': false,
    'settings': false,
  };
  
  // Getters
  Map<String, dynamic> get portfolioData => _portfolioData;
  List<Map<String, String>> get chatMessages => _chatMessages;
  bool get isTyping => _isTyping;
  Map<String, bool> get appStates => _appStates;
  
  // Portfolio methods
  void updatePortfolioData(String key, dynamic value) {
    _portfolioData[key] = value;
    notifyListeners();
  }
  
  // Chat methods
  void addChatMessage(String role, String content) {
    _chatMessages.add({
      'role': role,
      'content': content,
      'timestamp': DateTime.now().toIso8601String(),
    });
    notifyListeners();
  }
  
  void clearChatHistory() {
    _chatMessages.clear();
    notifyListeners();
  }
  
  Future<void> sendChatMessage(String message) async {
    // Add user message
    addChatMessage('user', message);
    
    // Set typing state
    _isTyping = true;
    notifyListeners();
    
    try {
      // Simulate AI response (replace with actual API call)
      await Future.delayed(const Duration(seconds: 1));
      
      String response = _generateResponse(message);
      
      // Add AI response
      addChatMessage('assistant', response);
    } catch (e) {
      addChatMessage('assistant', 'Sorry, I\'m having trouble processing that. Please email me at work@akhilraghav.com');
    } finally {
      _isTyping = false;
      notifyListeners();
    }
  }
  
  String _generateResponse(String message) {
    final lowerMessage = message.toLowerCase();
    
    if (lowerMessage.contains('name') || lowerMessage.contains('who are you')) {
      return 'I\'m ${_portfolioData['name']}, a ${_portfolioData['title']} based in ${_portfolioData['location']}.';
    } else if (lowerMessage.contains('email') || lowerMessage.contains('contact')) {
      return 'You can reach me at ${_portfolioData['email']}';
    } else if (lowerMessage.contains('github')) {
      return 'Check out my GitHub at ${_portfolioData['github']}';
    } else if (lowerMessage.contains('skills') || lowerMessage.contains('technology')) {
      final skills = (_portfolioData['skills'] as List).join(', ');
      return 'My technical skills include: $skills';
    } else if (lowerMessage.contains('experience') || lowerMessage.contains('work')) {
      return 'I have experience as a Full Stack Developer at various companies, specializing in backend development and competitive programming.';
    } else if (lowerMessage.contains('projects')) {
      return 'I\'ve worked on several exciting projects including a macOS Portfolio, Competitive Programming Platform, and iOS Finance App. Would you like to know more about any specific project?';
    } else if (lowerMessage.contains('location') || lowerMessage.contains('where')) {
      return 'I\'m based in ${_portfolioData['location']}.';
    } else if (lowerMessage.contains('age')) {
      return 'I\'m 23 years old.';
    } else {
      return 'That\'s outside my area of expertise. Feel free to email me at ${_portfolioData['email']} and we can discuss further!';
    }
  }
  
  // App state methods
  void toggleAppState(String appName) {
    _appStates[appName] = !(_appStates[appName] ?? false);
    notifyListeners();
  }
  
  void setAppState(String appName, bool state) {
    _appStates[appName] = state;
    notifyListeners();
  }
  
  // Initialize chat with welcome message
  void initializeChat() {
    if (_chatMessages.isEmpty) {
      final welcomeMessage = '''Welcome to My Portfolio

Name: ${_portfolioData['name']}
Role: ${_portfolioData['title']}
Location: ${_portfolioData['location']}

Contact: ${_portfolioData['email']}
GitHub: ${_portfolioData['github']}

Ask me anything!''';
      
      addChatMessage('assistant', welcomeMessage);
    }
  }
} 