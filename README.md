# Android Helpful Scripts and Notes

This repository contains a collection of scripts, notes, and patches to aid in Android development, custom ROM building, and kernel compilation.

## Directory Structure

- **setup/**: Scripts for setting up the Android development environment and Android Studio.
  - `install_android_setup.sh`: Installs Android Studio and its dependencies.
  - `environment.sh`: Sets up the build environment for ROM compilation.
- **device_specific_setup/**: Scripts and notes for setting up specific Android devices.
  - `ginkgo.sh`: Setup script for Xiaomi Ginkgo.
  - `op6t.sh`: Setup script for OnePlus 6T.
  - `realme5.txt`: Notes for Realme 5 setup.
- **kernel_building/**: Scripts related to kernel building and packaging.
  - `kernel.sh`: Script for building an Android kernel.
  - `zip.sh`: Script for packaging the compiled kernel into a flashable zip.
- **git_helpers/**: Helper scripts and notes for Git operations.
  - `force-push_helper.sh`: Assists with force-pushing to multiple git repositories.
  - `gitpush.txt`: Notes on specific git commands, like filtering branch history.
- **troubleshooting/**: Files with error logs, common issues, and their fixes.
  - `android-s.txt`: Log of build errors related to "module already defined".
  - `errors.txt`: A list of common problems encountered during ROM compilation and their potential solutions.
  - `filesandfixes.txt`: Notes on fixing common bugs related to signals, sensors, camera, fingerprint, and WiFi by replacing specific system files.
- **patches/**: Contains patch files for fixing specific issues.
  - `patch-aosp.patch`: A patch to fix screen flicker when unlocking.
- **misc/**: Miscellaneous helpful files.
  - `mega_help.txt`: Instructions for using `rmega` to upload files.
  - `Research links.txt`: Contains a link to Android source code.

## General Usage

1.  **Environment Setup**:
    Start by running the scripts in the `setup/` directory to prepare your development environment.
    For example, to set up the general build environment:
    ```bash
    bash <(curl -s https://raw.githubusercontent.com/hpnightowl/helpful/master/setup/environment.sh)
    ```
    To install Android Studio:
    ```bash
    bash setup/install_android_setup.sh
    ```

2.  **Device Specific Setup**:
    If you are working on a specific device covered in `device_specific_setup/`, run the corresponding script or follow the notes. For example, for `ginkgo`:
    ```bash
    bash device_specific_setup/ginkgo.sh
    ```

3.  **Kernel Building**:
    Use the scripts in `kernel_building/` for compiling and packaging kernels.
    ```bash
    bash kernel_building/kernel.sh
    bash kernel_building/zip.sh
    ```

4.  **Git Helpers**:
    The scripts in `git_helpers/` can simplify common Git tasks.

5.  **Troubleshooting**:
    Refer to the files in `troubleshooting/` if you encounter build errors or bugs.

6.  **Applying Patches**:
    Use `git apply` to apply any relevant patches from the `patches/` directory. For example:
    ```bash
    git apply patches/patch-aosp.patch
    ```

## Contributing

Feel free to contribute by adding more scripts, notes, or fixes. Please try to maintain the existing directory structure and provide clear commit messages.
