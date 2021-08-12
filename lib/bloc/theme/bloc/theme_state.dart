part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.color, this.isNight = true});
  final Color color;
  final bool isNight;
  @override
  List<Object> get props => [isNight, color];
}
