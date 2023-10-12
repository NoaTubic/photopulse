# PhotoPulse

## Changelog generator

These steps are necessary after cloning git repository to have 
changelog generator executed automatically each time you commit something
to your repository. For more info check changelog_generator/README.md file.

Run the following commands to install Jinja2 package necessary for generating changelog file
and setup post-commit hook so changelog generator can be executed on each commit.
```
pip3 install Jinja2
mkdir -p .git/hooks/ && cp changelog_generator/post-commit .git/hooks/
```

## Reusable widget documentation generator for Flutter

To generate list of your project's reusable widgets run the following command 
in Terminal.
```dart
dart reusable_widgets_docs_generate.dart
```
For more information about reusable widget documentation generator visit
https://gitlab.qagency.io/flutter/reusable-widget-generator
