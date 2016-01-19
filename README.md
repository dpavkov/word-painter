# word-painter
Micro-service which accepts a word and forwards it to the next micro service, picking a color for it along the way. Can be used with https://github.com/dpavkov/reading-helper and https://github.com/dpavkov/word-painter-socket-caller to form a nice application for fast reading of the content.
# setup
To set up the application, after cloning the repository, first run _bundle install_ to download all dependencies.

Set SOCKET_CALLER_URL environment variable

run _ruby lib/word-painter.rb_
# testing the application

Run _rake_ to run tests.