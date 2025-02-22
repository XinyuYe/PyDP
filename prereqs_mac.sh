#!/bin/bash

# homebrew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Downloading and installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    brew update
fi

# python 3
echo "Checking for python3 installation"
if command -v python3 &>/dev/null; then
    echo "Python 3 already installed"
else
    echo "Downloading and installing Python3 using homebrew"
    brew install python3
fi

# bazel
if command -v bazel &>/dev/null; then
    echo "Bazel already installed"
else
    echo "Downloading and installing Bazel using homebrew"
    brew tap bazelbuild/tap
    brew install bazelbuild/tap/bazel
fi

# clang-format
if command -v clang-format &>/dev/null; then
    echo "clang-format already installed"
else
    echo "installing clang-format"
    brew install clang-format
fi

# poetry
echo "Checking for poetry"
if python3 -c "import poetry" &> /dev/null; then
    echo "poetry is already installed"
else
    echo "installing poetry"
    pip3 install poetry
fi

# Downloading the Google DP library
git submodule update --init --recursive

# checkout out to particular commit
cd third_party/differential-privacy && git checkout e224a8635728026fb3aa9409ab3a98b9a3f5566a && \
cd -
# renaming workspace.bazel to workspace
mv third_party/differential-privacy/cc/WORKSPACE.bazel third_party/differential-privacy/cc/WORKSPACE

# Removing the java part
rm -rf third_party/differential-privacy/java third_party/differential-privacy/examples/java

# Removing the Go part
rm -rf third_party/differential-privacy/go third_party/differential-privacy/examples/go

# Removing the Privacy on Beam part
rm -rf third_party/differential-privacy/privacy-on-beam