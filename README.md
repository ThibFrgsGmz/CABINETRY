<h1 align="center">CABINETRY - A CMake-Based Buildchain Template for Embedded Systems </h1>

This repository hosts a **CABINETRY** project, a CMake startup project for Embedded Systems.

## Development Setup
### Prerequisite

Before being able to work, the developer must have installed a certain number of prerequisites.

- Git >= 2.13
- An IDE - preferably Visual Studio Code
- CMake > 3.25
- Ninja > 1.10.2
- On Windows: LLVM's Clang > 13.0.0
- GNU's GCC on Linux

## Build

The `CMake` build chain takes advantage of `CMake Preset` to make it easier to set up workflows. All user settings are done with two files: [`CMakeUserPresets.json`](./CMakeUserPresets.json) and [`CMakePresets.json`](./CMakePresets.json).

If you are not aware of CMake Preset, checkout [this reference](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html).


Once the developer has cloned the repository, he should duplicate the file `CMakeUserPresets.TEMPLATE.json` and remove the word "TEMPLATE" from the newly created file.
This file, now named `CMakeUserPresets.json`, is intended to be dependent on the developer's local environment. It should contain paths depending on the developer's local (specific) configuration and other volatile configuration settings.

The developer is therefore encouraged to update this file, if necessary, with his specific configuration (path to tools, etc.).

If structural changes are made to the `CMakeUserPresets.json` file such as adding presets (configure, build, workflow,...), the developer will need to update the `CMakeUserPresets.TEMPLATE.json` file accordingly and push these changes to the main branch in order to share these new buildchain configurations.

### CMake Workflow presets

With the `presets`, you have a list of preconfigured workflows that you can access with the following command:

```sh
cmake cmake --workflow --list-presets
```

Choose one of them to generate the library. For example, to build the project as a static library on a Windows PC, write the command :

```sh
cmake --workflow --preset WINDOWS_AMD64_STATIC
```

### CMake Configure/Build presets

With the preset, you have a list of preconfigurations which you can access with the following command:

```sh
cmake --list-presets
```

Choose one of them to generate the cache of the build chain. For example, to build on a Windows PC, write the command :

```sh
cmake --preset WINDOWS_AMD64_STATIC
```

Once the cache has been generated, we can proceed with the build. Normally, we would write `cmake --build {presetName}`, i.e. `cmake --build WINDOWS_AMD64_STATIC` in our example above. If there is a bug in CMake when writing this procedure (see https://gitlab.kitware.com/cmake/cmake/-/issues/22276).

In the meantime, you should prefix the {presetName} of the `build` folder in which the various installation folders are located:

```
cmake --build build/{presetName}
```

In our example with `WINDOWS_AMD64_STATIC`, we will need to enter the following command to generate the library for this configuration:

```
cmake --build build/WINDOWS_AMD64_STATIC
```
