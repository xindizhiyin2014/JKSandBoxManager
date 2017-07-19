SIMULATOR_NAME=$1
if [[ ! $SIMULATOR_NAME ]]; then
	SIMULATOR_NAME="iPhone 6"
fi

TEST_SIMULATOR_VERSION=$2
if [[ ! $TEST_SIMULATOR_VERSION ]]; then
	TEST_SIMULATOR_VERSION="10.0"
fi

CI_PROJECT_NAME=${PWD##*/}


cd Example/
pwd
time IS_SOURCE=1 pod install --verbose
time xcodebuild test -workspace $CI_PROJECT_NAME.xcworkspace -scheme $CI_PROJECT_NAME-Example -destination "platform=iOS Simulator,name=$SIMULATOR_NAME,OS=$TEST_SIMULATOR_VERSION" | xcpretty
cd ..