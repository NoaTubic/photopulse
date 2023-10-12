# Changelog generator

## Prerequisite
Changelog generator depends on [Jinja2](https://jinja.palletsprojects.com) to 
generate destination changelog file so you need to install it before running the script.
```
pip3 install Jinja2
```

## Project setup
Configure config file with desired setup, copy entire **changelog_generator** folder 
to your project and then run
```
bash changelog_generator/generate_changelog.sh
```
config file has following variables that can be configured:
* COMMIT_TAG - default "ID", you can change if you project has specific tag name 
connected with project management platform
* ENVIRONMENT - default "staging", you can change to the desired environment tag
you need
* ISSUE_BASE_URL - default "https://teamwork.q.agency/app/tasks/", can be changed
to the desired project management platform, e.g. Jira which will be used as a 
link to the ticket mentioned in the git commit
* DESTINATION_TEMPLATE - default "release_notes_md_template.txt", which template
to use, currently along with md also html template is available 
("release_notes_html_template.txt")
* DESTINATION_FILE_NAME - default "../CHANGELOG-$ENVIRONMENT.md", path and name 
of the file that will be generated based on your projects git commit messages

## Post-commit hook
In your project, copy **post-commit** file to .git/hooks folder and it will execute 
**generate_changelog.sh** script each time you commit something into your git 
repository and add **DESTINATION_FILE_NAME** file to your commit if anything has changed
in your desired tag changelog
