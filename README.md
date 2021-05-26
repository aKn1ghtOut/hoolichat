<p align="center"><img src="https://socialify.git.ci/aKn1ghtOut/hoolichat/image?description=1&language=1&owner=1&pattern=Circuit%20Board&theme=Dark" alt="hoolichat-" width="640" height="320" /></p>

![Maintaner](https://img.shields.io/badge/maintainer-AnantBhasin-blue)
[![Website shields.io](https://img.shields.io/website-up-down-green-red/http/shields.io.svg)](http://hooli.snu-labyrinth.tech/docs/)
[![GitHub issues](https://img.shields.io/github/issues/aKn1ghtOut/hoolichat.svg)](https://GitHub.com/aKn1ghtOut/hoolichat/issues/)
[![GitHub issues-closed](https://img.shields.io/github/issues-closed/aKn1ghtOut/hoolichat.svg)](https://GitHub.com/aKn1ghtOut/hoolichat/issues?q=is%3Aissue+is%3Aclosed)
[![Open Source? Yes!](https://badgen.net/badge/Open%20Source%20%3F/Yes%21/blue?icon=github)](https://github.com/aKn1ghtOut/hoolichat/)

[![GitHub last commit](https://img.shields.io/github/last-commit/aKn1ghtOut/hoolichat.svg?style=flat)]()

[![GitHub stars](https://img.shields.io/github/stars/aKn1ghtOut/hoolichat.svg?style=social&label=⭐Stars&style=plastic&color=green)]()

[![GitHub stars](https://img.shields.io/github/forks/aKn1ghtOut/hoolichat.svg?style=social&label=🍴Forks&style=plastic&color=green)]()

<h1 align="center">
   💻 HooliChat
</h1>

<p align="center">
<h4 align="center">
HooliChat is an open source frontend using [Flutter](https://flutter.dev/) that can be deployed and used on any major user platform.
</h4>
<ul align="center" listStyle="none">
<p align="center">📱 Android</p>
<p align="center">📱 iOS</p>
<p align="center">💻 Web</p>
<p align="center">🖥️ Windows</p>
<p align="center">🖥️ Linux</p>
<p align="center">🖥️ MacOS</p>
</ul>
</p>

<p align="center">
    <a href="https://forthebadge.com">
      <img alt="Developers" src="https://forthebadge.com/images/badges/built-by-developers.svg">
    </a>
    <br>
    <a href="https://forthebadge.com">
      <img alt="Flutter" src="https://forthebadge.com/images/badges/built-for-android.svg">
    </a>
    <br>
    <a href="https://github.com/aKn1ghtOut/hoolichat/actions?query=workflow%3Anode.js.yml+branch%3Amaster">
      <img alt="Build status" src="https://github.com/aKn1ghtOut/hoolichat/actions/workflows/node.js.yml/badge.svg">
    </a>
    <a href="https://flutter.dev/"><img alt="Flutter 2.x" src="https://img.shields.io/badge/flutter-2.x-blue.svg?logo=node.js&style=flat"></a>
</p>

-   [Introduction](#introduction)
-   [Technology Stack](#⚡technology-stack)
-   [Getting Started](#getting-started)
    -   [Running HooliChat ](#running-hoolichat-)
        -   [Compatibility](#compatibility)
            -   [Flutter](#flutter)
        -   [Locally](#locally)
    -   [Deploying HooliChat elsewhere](#deploying-hoolichat-elsewhere)
        -   [Sample Application](#sample-application)
-   [Configuration](#configuration)
-   [Contributing](#🤝contributing)
-   [Contributors](#👨‍💻contributors)

# Introduction 
Hoolichat is an open-source solution for small and medium businesses that brings together essential business features like team communication, task management, inventory management, invoicing, etc.
- Indians want simple streamlined solutions.
- Competing solutions are all closed-source, and create lock-in.
- Most SMBs just prefer using the limited functionality of Whatsapp to avoid technicalities.
- Better solutions are either too expensive or require technical prowess.

# ⚡Technology Stack

### [Flutter](https://flutter.dev/)
### [Socket.io](https://github.com/socketio/socket.io#readme)

# Getting Started
The fastest and easiest way to get started is to run HooliChat locally.

## Running HooliChat 

Before you start make sure you have installed:

-   [Flutter](https://flutter.dev/)
-   All the flutter modules as in described in `pub.dev` file, by running the command:
```bash
$ flutter pub get
```

### Compatibility

#### Flutter

HooliChat  is continuously tested with the most recent releases of Flutter to ensure compatibility. We follow the [Flutter Long Term Support plan for the Stable Channel](https://flutter.dev/docs/development/tools/sdk/releases) and only test against versions that are officially supported and have not reached their end-of-life date.

| Version   | Latest Version | Compatibility       |
| --------- | -------------- | ------------------- |
| Flutter - | 2.0.3        | ✅ Fully compatible |
| Flutter - | 2.0.6        | ✅ Fully compatible |
| Flutter - | 2.2.0        | ✅ Fully compatible |


## Deploying HooliChat Elsewhere

## Deployment Procedure
We are using the [official flutter guide](https://flutter.dev/docs/deployment/android) for building the application for different platforms and then serving them through the respective platform's application store.
For android we can run:
```bash
$ flutter build apk
```
For web we can run :
```bash
$ flutter build web
```


### Sample Application

We have provided a basic [Android application package](https://github.com/aKn1ghtOut/hoolichat/suites/2833809008/artifacts/63177986) that uses the [HooliChat API backend service](https://github.com/ishitb/hoolichat-api) and can be easily deployed to various infrastructure providers.

## Logging

HooliChat will, by default, log:
* to the console
* Debugging console (Android Studio and VS Code)

## Running

You need a proper editor for running flutter applications. Read this [guide](https://flutter.dev/docs/get-started/editor) to make sure you are prepared.

### Using the Editor
You can refer to this [guide](https://flutter.dev/docs/get-started/test-drive) to run the application through your preferred editor

### Using the CLI

#### Make sure you have a device connected to your development platform using the [guide]()

The easiest way to run the HooliChat is through the CLI:

```bash
$ flutter run
```


# 🤝Contributing

Thank you for your interest in contributing to HooliChat . Regardless of the size of the contribution you make, all contributions are welcome and are appreciated.

If you are new to contributing to open source, please read the Open Source Guides on [How to Contribute to Open Source](https://opensource.guide/how-to-contribute/).

## Ways to Contribute

If you are ready to start contributing code right away, we have a list of [good first issues](https://github.com/aKn1ghtOut/hoolichat/labels/good%20first%20issue) that contain issues with a limited scope.

### Our Development Process

We utilize GitHub issues and pull requests to keep track of issues and contributions from the community.

### Pull Request Guidelines

👍🎉 First off, thanks for taking the time to contribute! 🎉👍

In order to give everyone a chance to submit a pull request and contribute to the HooliChat project, we have put restrictions in place. This section outlines the guidelines that should be imposed upon pull requests in the HooliChat  project.

-   Pull requests must be based on [open issues](https://github.com/aKn1ghtOut/hoolichat/issues) available or you can create your own issues.
-   [Use this method to automatically close the issue when the PR is completed.](https://docs.github.com/en/github/managing-your-work-on-github/linking-a-pull-request-to-an-issue)
-   Each contributor may only create one pull request at a time. We have this rule in place due to our limited resources - if everyone was allowed to post multiple pull requests we will not be able to review them properly. It is also better for contributors because you can focus on creating one quality PR - so spend time making sure it is as good as it can be.
-   If the pull request's code quality is not up to our linting preferences, it would break the app. So please be careful when creating a PR.
-   All pull request must have test units. If for some reason it is not possible to add tests, please let us know and explain why. In that case, you'll need to tell us what steps you followed to manually test your changes.
-   Do not force push. If you make changes to your pull request, please simply add a new commit as that makes it easy for us to review your new changes. If you force push, we'll have to review everything from the beginning.
-   PR should be small, easy to review and should follow standard coding styles.
-   If PR has conflicts because of recently added changes to the same file, resolve issues, test new changes and submit PR again for review.
-   PRs should be atomic. That is, they should address one item (issue or feature)

### Branching Strategies

For HooliChat , we had employed the following branching strategy to simplify the development process and to ensure that only stable code is pushed to the `main` branch:

-   `develop`: For unstable code and bug fixing
-   `alpha-x.x.x`: For stability testing
-   `main`: Where the stable production ready code lies

### Contributing Code

Code contributions to HooliChat come in the form of pull requests. These are done by forking the repo and making changes locally.

Make sure you have read the [Documentation for Setting up the Project](#configuration)

The process of proposing a change to HooliChat  can be summarized as:

-   Fork the HooliChat  repository and branch off `main`.
-   The repository can be cloned locally using `git clone <forked repo url>`.
-   Make the desired changes to the HooliChat  source.
-   Run the app and test your changes.
-   If you've added code that should be tested, write tests.
-   After making changes you can add them to git locally using `git add <file_name>`(to add changes only in a particular file) or `git add .` (to add all changes).
-   After adding the changes you need to commit them using `git commit -m '<commit message>'`(look at the commit guidelines below for commit messages).
-   Once you have successfully commited your changes, you need to push the changes to the forked repo on github using: `git push origin <branch_name>`.
-   Here branch name must be of the format `<label>`/`<change-title>`. The `<label>` must be the label of the issue you are resolving, be it feature, bug, etc.
-   Now create a pull request to the HooliChat repository from your forked repo. Open an issue regarding the same and link your PR to it.
-   Ensure the test suite passes, either locally or on CI once a PR has been created.
-   Review and address comments on your pull request if requested.

# 👨‍💻Contributors

This project exists thanks to all the people who contribute... we'd love to see your face on this list!

<table>
  <tr>
    <td align="center"><a href="https://github.com/prkhrbhsn"><img src="https://avatars.githubusercontent.com/u/38764067?v=4" width="100px;" alt=""/><br /><sub><b>Anant Bhasin</b></sub></a><br /></td>
    <td align="center"><a href="https://github.com/ishitb"><img src="https://avatars.githubusercontent.com/u/53562523?v=4" width="100px;" alt=""/><br /><sub><b>Ishit Beswal</b></sub></a><br /></td>
    <td align="center"><a href="https://github.com/kirtiksingh"><img src="https://avatars.githubusercontent.com/u/58079155?v=4" width="100px;" alt=""/><br /><sub><b>Nakul Gupta</b></sub></a><br /></td> 
  </tr>
</table>
