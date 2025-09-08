import 'package:flutter/material.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressInputModal extends StatefulWidget {
  final String habitTitle;
  final double targetValue;
  final double partialValue;
  final String unit;
  final double currentProgress;
  final Function(double) onProgressChanged;

  const ProgressInputModal({
    super.key,
    required this.habitTitle,
    required this.targetValue,
    required this.partialValue,
    required this.unit,
    required this.currentProgress,
    required this.onProgressChanged,
  });

  @override
  State<ProgressInputModal> createState() => _ProgressInputModalState();
}

class _ProgressInputModalState extends State<ProgressInputModal> {
  late double _currentValue;
  late TextEditingController _textController;
  bool _useEdit = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.currentProgress;
    _textController = TextEditingController(
        text: _currentValue.toStringAsFixed(
            _currentValue == _currentValue.roundToDouble() ? 0 : 1));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _updateValue(double value) {
    setState(() {
      _currentValue = value.clamp(
          0.0, widget.targetValue * 2); // Allow up to 200% completion
      _textController.text = _currentValue.toStringAsFixed(
          _currentValue == _currentValue.roundToDouble() ? 0 : 1);
    });
  }

  void _onTextChanged(String text) {
    final value = double.tryParse(text);
    if (value != null) {
      setState(() {
        _currentValue = value.clamp(0.0, widget.targetValue * 2);
      });
    }
  }

  double get _progressPercentage =>
      (_currentValue / widget.targetValue).clamp(0.0, 1.0);
  bool get _isCompleted => _currentValue >= widget.targetValue;
  bool get _isExceeded => _currentValue > widget.targetValue;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.habitTitle,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Progress visualization
            Center(
              child: SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Progress circle
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 10.0,
                        animationDuration: 200,
                        animation: true,
                        animateFromLastPercent: true,
                        percent: _progressPercentage,
                        backgroundColor: Colors.transparent,
                        progressColor: _isExceeded
                            ? Provider.of<SettingsManager>(context,
                                    listen: false)
                                .checkColor
                            : _isCompleted
                                ? Provider.of<SettingsManager>(context,
                                        listen: false)
                                    .checkColor
                                : Provider.of<SettingsManager>(context,
                                        listen: false)
                                    .progressColor,
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    ),
                    // Progress text
                    AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: animation,
                              child: child,
                            ),
                          );
                        },
                        child: _isCompleted
                            ? Icon(
                                Icons.check,
                                color: Provider.of<SettingsManager>(context,
                                        listen: false)
                                    .checkColor,
                                size: 50,
                              )
                            : Text(
                                '${(_progressPercentage * 100).round()}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: _isCompleted
                                          ? Provider.of<SettingsManager>(
                                                  context,
                                                  listen: false)
                                              .checkColor
                                          : Provider.of<SettingsManager>(
                                                  context,
                                                  listen: false)
                                              .progressColor,
                                    ),
                              )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Target info
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_currentValue.toStringAsFixed(_currentValue == _currentValue.roundToDouble() ? 0 : 1)} / ${widget.targetValue.toStringAsFixed(widget.targetValue == widget.targetValue.roundToDouble() ? 0 : 1)} ${widget.unit}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () {
                    setState(() {
                      _useEdit = !_useEdit;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            if (_useEdit) ...[
              Center(
                child: TextField(
                  controller: _textController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: S.of(context).enterAmount,
                    suffixText: widget.unit,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: _onTextChanged,
                ),
              ),
            ],
            // Input controls
            const SizedBox(height: 20),
            // Quick increment buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickButton(
                    '-${widget.partialValue.toStringAsFixed(widget.partialValue == widget.partialValue.roundToDouble() ? 0 : 1)}',
                    () => _updateValue(_currentValue - widget.partialValue),
                    context),
                _buildQuickButton(
                    '+${widget.partialValue.toStringAsFixed(widget.partialValue == widget.partialValue.roundToDouble() ? 0 : 1)}',
                    () => _updateValue(_currentValue + widget.partialValue),
                    context),
                _buildQuickButton(S.of(context).complete,
                    () => _updateValue(widget.targetValue), context),
              ],
            ),
            const SizedBox(height: 24),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor:
                        Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  child: Text(S.of(context).cancel),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    widget.onProgressChanged(_currentValue);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isCompleted
                        ? Provider.of<SettingsManager>(context, listen: false)
                            .checkColor
                        : Provider.of<SettingsManager>(context, listen: false)
                            .progressColor,
                  ),
                  child: Text(
                    _isCompleted
                        ? S.of(context).complete
                        : S.of(context).saveProgress,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickButton(
      String label, VoidCallback onPressed, BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shadowColor: Theme.of(context).shadowColor,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
