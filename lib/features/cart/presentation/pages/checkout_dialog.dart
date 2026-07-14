import 'package:bookia_store/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_theme_helpers.dart';
import '../../../../core/utils/notification_helper.dart';
import '../cubit/cart_state_cubit.dart';

void showCheckoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const CheckoutDialog(),
  );
}

class CheckoutDialog extends StatefulWidget {
  const CheckoutDialog({super.key});

  @override
  State<CheckoutDialog> createState() => _CheckoutDialogState();
}

class _CheckoutDialogState extends State<CheckoutDialog> {
  String _selectedAddress = 'Home';
  String _selectedPaymentMethod = 'Cash On Delivery';
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),


      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.65,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.borderFocus,width: 1),
        ),

        padding: EdgeInsets.only(bottom: bottomInset > 0 ? bottomInset : 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Checkout',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.dangerous_outlined,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<CartStateCubit, CartStateState>(
                builder: (context, state) {
                  num totalBeforeDiscount = 0;
                  num totalAfterDiscount = 0;

                  if (state is CartUpdateState) {
                    for (var product in state.cartProducts) {
                      final num originalPrice = num.tryParse(product.price.toString()) ?? 0;

                      final num priceAfter = num.tryParse(product.priceAfterDiscount.toString()) ?? originalPrice;

                      final int qty = state.quantity[product.id] ?? 1;

                      totalBeforeDiscount += (originalPrice * qty);
                      totalAfterDiscount += (priceAfter * qty);
                    }
                  }
                  final num savedAmount =
                      totalBeforeDiscount - totalAfterDiscount;

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Delivery Address
                        const _SectionTitle(
                          title: 'Delivery Address',
                          icon: Icons.location_on_outlined,
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              child: _SelectionCard(
                                title: 'Home',
                                subtitle: '6th of October ,Main st 52',
                                icon: Icons.home_rounded,
                                isselected: _selectedAddress == 'Home',
                                onTap: () =>
                                    setState(() => _selectedAddress = 'Home'),
                              ),
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: _SelectionCard(
                                title: 'Work',
                                subtitle: 'New Giza',
                                icon: Icons.work_outline,
                                isselected: _selectedAddress == 'Work',
                                onTap: () =>
                                    setState(() => _selectedAddress = 'Work'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        //payment
                        Row(
                          children: [
                            Expanded(
                              child: _SelectionCard(
                                title: 'Cash',
                                subtitle: 'On Delivery',
                                icon: Icons.money_rounded,
                                isselected: _selectedPaymentMethod == 'Cash',
                                onTap: () => setState(
                                  () => _selectedPaymentMethod = 'Cash',
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _SelectionCard(
                                title: 'Visa',
                                subtitle: '**** 1234',
                                icon: Icons.credit_card_rounded,
                                isselected: _selectedPaymentMethod == 'Visa',
                                onTap: () => setState(
                                  () => _selectedPaymentMethod = 'Visa',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        //delevry notes
                        const _SectionTitle(
                          title: 'Delivery Notes',
                          icon: Icons.note_alt_rounded,
                        ),
                        const SizedBox(height: 12),

                        TextField(
                          controller: _notesController,
                          maxLines: 2,
                          style: const TextStyle(color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            hintText: 'Any specific instructions?',
                            hintStyle: const TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 13,
                            ),
                            filled: true,
                            fillColor: AppColors.surfaceLight,
                            contentPadding: const EdgeInsets.all(16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: AppColors.primaryLight,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        //total payment
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            children: [
                              _SummaryRow(
                                title: 'Subtotal',
                                value:
                                    '\$${totalBeforeDiscount.toStringAsFixed(2)}',
                                valueColor: AppColors.success,
                              ),

                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Divider(
                                  color: AppColors.border,
                                  thickness: 1,
                                ),
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                    ),
                                  ),

                                  Text(
                                    '\$${totalAfterDiscount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: AppColors.accent,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                              if (savedAmount > 0) ...[
                                const SizedBox(height: 12),

                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'You saved \$${savedAmount.toStringAsFixed(2)}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: AppColors.success,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        //checkout button
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {
                              context.read<CartStateCubit>().clearCart();

                              NotificationHelper.showOrderNotification();

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).clearSnackBars();


                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: AppGradients.primary,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: Text(
                                  'Confirm Order',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//helper widget

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionTitle({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryLight, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _SelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isselected;
  final VoidCallback onTap;

  const _SelectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isselected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isselected
              ? AppColors.primaryLight.withOpacity(0.15)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isselected ? AppColors.borderFocus : AppColors.border,
            width: isselected ? 1 : 0.5,
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: isselected
                      ? AppColors.primaryLight
                      : AppColors.textMuted,
                  size: 22,
                ),
                if (isselected)
                  const Icon(
                    Icons.check_circle_outlined,
                    color: AppColors.primaryLight,
                    size: 18,
                  ),
              ],
            ),
            const SizedBox(height: 8),

            Text(
              title,
              style: TextStyle(
                color: isselected
                    ? AppColors.primaryLight
                    : AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),

            Text(
              subtitle,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const _SummaryRow({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),

        Text(
          value,
          style: TextStyle(
            color: valueColor ?? AppColors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
