import 'dart:io';

void main() async {
  final exitCode = await runCommands([
    'dart format .',
    'flutter analyze',
    'flutter test',
  ]);

  if (exitCode != 0) {
    //print('Pre-commit checks failed. Please fix the issues before committing.');
    exit(exitCode);
  } else {
    //print('Pre-commit checks passed successfully.');
  }
}

Future<int> runCommands(List<String> commands) async {
  for (final command in commands) {
    final process = await Process.start(
        command.split(' ').first, command.split(' ').sublist(1));
    await stdout.addStream(process.stdout);
    await stderr.addStream(process.stderr);
    final exitCode = await process.exitCode;
    if (exitCode != 0) {
      return exitCode;
    }
  }
  return 0;
}
