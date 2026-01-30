class UserProfileData {
  static final UserProfileData _instance = UserProfileData._internal();
  factory UserProfileData() => _instance;
  UserProfileData._internal();

  String name = "Rahul Sharma";
  String email = "rahul.s@email.com";
  String phone = "+91 98765 43210";
  
  bool isPremium = true;
  DateTime renewalDate = DateTime(2024, 10, 24);

  // App Settings
  bool notificationsEnabled = true;
  bool darkMode = false;

  // Security
  bool biometricsEnabled = true;
  bool dataSharing = false;

  void updateProfile({String? name, String? email, String? phone}) {
    if (name != null) this.name = name;
    if (email != null) this.email = email;
    if (phone != null) this.phone = phone;
  }
}
