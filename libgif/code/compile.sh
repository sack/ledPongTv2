rm -rf gifAnimation
javac -d . *.java -classpath /usr/local/processing-1.5.1/lib/core.jar
jar -cf gifAnimation.jar gifAnimation
