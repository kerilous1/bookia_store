import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_theme_helpers.dart';
import '../cubit/profile_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // بنطلب الداتا أول ما الشاشة تفتح لو لسه مش موجودة
    final cubit = context.read<ProfileCubit>();
    if (cubit.curntUser == null) {
      cubit.getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is DeleteProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Account deleted successfully'),
                backgroundColor: AppColors.success,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
            // TODO: Navigate to Login Page & clear stack
          } else if (state is DeleteProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ProfileCubit>();
          final user = cubit.curntUser;

          // لو لسه بيحمل لأول مرة
          if (state is GetProfileLoading && user == null) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryLight),
            );
          }

          // لو حصل خطأ وماعندناش داتا قديمة نعرضها
          if (state is GetProfileError && user == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: AppColors.error,
                    size: 50,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppGradients.primary,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: AppShadows.glowPurple,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () => cubit.getProfile(),
                      child: const Text(
                        'Retry',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          // عرض البيانات
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // ── 1. Avatar & User Info ──
                Center(
                  child: Column(
                    children: [
                      //avatar with gradient border
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppGradients.primary,
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.surface,
                          backgroundImage: (user?.image != null && user!.image!.isNotEmpty)
                              ? NetworkImage(user.image!)
                              : null,
                          child: (user?.image == null || user!.image!.isEmpty)
                              ? const Icon(Icons.person, size: 50, color: AppColors.textMuted)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user?.name ?? 'Guest User',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        user?.email ?? '',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // ── 2. Profile Options List ──
                _buildProfileOption(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  onTap: () {
                    // TODO: Navigate to UpdateProfilePage
                  },
                ),
                _buildProfileOption(
                  icon: Icons.lock_outline,
                  title: 'Change Password',
                  onTap: () {
                    // TODO: Navigate to ChangePasswordPage
                  },
                ),
                _buildProfileOption(
                  icon: Icons.shopping_bag_outlined,
                  title: 'My Orders',
                  onTap: () {
                    // TODO: Navigate to Orders
                  },
                ),

                //divider
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: AppColors.border, thickness: 1),
                ),

                // ── 3. Danger Zone (Logout & Delete) ──
                _buildProfileOption(
                  icon: Icons.logout,
                  title: 'Logout',
                  color: AppColors.warning,
                  onTap: () {
                    // TODO: Handle Logout logic (clear token & go to login)
                  },
                ),
                _buildProfileOption(
                  icon: Icons.delete_forever_outlined,
                  title: 'Delete Account',
                  color: AppColors.error,
                  onTap: () => _showDeleteConfirmationDialog(context, cubit),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ودجت صغيرة لرسم عنصر في القائمة شكلها شيك
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    final optionColor = color ?? AppColors.primaryLight;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: optionColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: optionColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color ?? AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }

  // ديالوج تأكيد الحذف عشان اليوزر مايدوسش بالغلط
  void _showDeleteConfirmationDialog(BuildContext context, ProfileCubit cubit) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.error,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Delete Account',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Are you sure you want to delete your account? This action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        cubit.deleteProfile();
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}