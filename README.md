# TimeTracker

## Demo
- Try it: [time-tracker](https://lukasmetzner.github.io/time-tracker/)
1. Add all your projects using the **Add Project** button and the input field -> A button for every project should appear
2. Press a button to start working on a project
3. Hit another button and the previous project with the according time should show up in the table

## Overview

- The time table and projects list is stored in localStorage
- You can clear the localStorage for the time table with **Clear Table** button
- You can remove a project from the list and localStorage using the **Remove Project** button and the provided name
- **End Current Project** will store the previously started project and not start a new one

## TODOs
- [ ] Clean up code
- [ ] Make actual components out of HelloWorld.vue

### Subtree stuff
```
git subtree push --prefix dist origin gh-pages
```
