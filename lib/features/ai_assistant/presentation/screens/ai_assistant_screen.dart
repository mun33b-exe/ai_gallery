import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radii.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/ai_empty_state.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final _inputController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': text.trim()});
      _messages.add({
        'role': 'assistant',
        'content':
            'Blueprint preview response: Once AI inference is connected in future phases, your receipts will be queried to answer "$text".',
      });
    });
    _inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBlueprintBanner: true,
      appBar: AppBar(title: const Text('Ask AI')),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? AiEmptyState(onPromptSelected: _sendMessage)
                : ListView.builder(
                    padding: AppSpacing.screenPadding,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isUser = message['role'] == 'user';

                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: AppSpacing.md),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.md,
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                          ),
                          decoration: BoxDecoration(
                            color: isUser
                                ? AppColors.primaryGreen
                                : AppColors.surface,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: Radius.circular(isUser ? 16 : 4),
                              bottomRight: Radius.circular(isUser ? 4 : 16),
                            ),
                            border: Border.all(
                              color: isUser
                                  ? AppColors.primaryGreen
                                  : AppColors.border,
                            ),
                          ),
                          child: Text(
                            message['content'] ?? '',
                            style: AppTypography.bodyMedium.copyWith(
                              color: isUser
                                  ? AppColors.textWhite
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    decoration: InputDecoration(
                      hintText: 'Ask about your transactions...',
                      hintStyle: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textMuted,
                      ),
                      filled: true,
                      fillColor: AppColors.gray100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: AppRadii.radiusPill,
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                IconButton.filled(
                  icon: const Icon(Icons.arrow_upward_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: AppColors.textWhite,
                  ),
                  onPressed: () => _sendMessage(_inputController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
