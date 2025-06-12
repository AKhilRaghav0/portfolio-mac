# 🍎 macOS Portfolio - Flutter Web

A stunning, interactive macOS desktop experience built with Flutter Web, featuring glassmorphism effects, native Cupertino design, and a complete portfolio showcase.

![macOS Portfolio](https://img.shields.io/badge/Flutter-Web-blue?style=for-the-badge&logo=flutter)
![Vercel](https://img.shields.io/badge/Deployed%20on-Vercel-000000?style=for-the-badge&logo=vercel)

## ✨ Features

### 🖥️ **Authentic macOS Experience**
- **Menu Bar** with Apple menu, app menus, and status items  
- **Dock** with beautiful app icons and hover effects
- **Control Center** with glassmorphism effects
- **Dynamic Wallpapers** with gradient backgrounds

### 💼 **Portfolio Integration**
- **Interactive Chat** powered by your personal information
- **Skills & Experience** showcase
- **Project Gallery** with detailed descriptions
- **Contact Information** with direct links

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- A web browser

### Installation

1. **Install dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the development server**
   ```bash
   flutter run -d chrome
   ```

3. **Build for production**
   ```bash
   flutter build web --release
   ```

## 🌐 Deploy to Vercel

### Automatic Deployment (Recommended)

1. **Connect your GitHub repository to Vercel**
   - Go to [Vercel Dashboard](https://vercel.com/dashboard)
   - Click "New Project"
   - Import your GitHub repository

2. **Configure build settings**
   - Build Command: `flutter build web --release`
   - Output Directory: `build/web`
   - Install Command: `echo 'Flutter will handle dependencies'`

3. **Deploy**
   - Click "Deploy" - Your app will be live in minutes!

### Manual Deployment

1. **Install Vercel CLI**
   ```bash
   npm i -g vercel
   ```

2. **Build and deploy**
   ```bash
   flutter build web --release
   vercel --prod
   ```

## 📱 Customization

Update your portfolio data in `lib/providers/app_provider.dart`:

```dart
final Map<String, dynamic> _portfolioData = {
  'name': 'Your Name',
  'title': 'Your Title', 
  'email': 'your.email@example.com',
  'github': 'github.com/yourusername',
  // ... add your skills, projects, experience
};
```

---

**Built with ❤️ using Flutter Web** 

🔗 **Features**: Glassmorphism • Cupertino Design • Interactive Portfolio
🚀 **Deployment**: Ready for Vercel with zero configuration
