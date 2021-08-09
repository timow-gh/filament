function(setupExportSetInstall proj_config_name export_set_name)
    include(GNUInstallDirs)
    include(CMakePackageConfigHelpers)

    set(${proj_config_name}_CONFIG_IN_FILE
            "${TNT_SOURCE_DIR}/build/cmake/Config.cmake.in"
            CACHE STRING "Path to the TNT Config*.cmake.in file.")

    if (NOT EXISTS "${${proj_config_name}_CONFIG_IN_FILE}")
        message(STATUS "Absolute Config.cmake.in path: ${${proj_config_name}_CONFIG_IN_FILE}")
        message(FATAL_ERROR "Missing file Config.cmake.in")
        return()
    endif ()

    write_basic_package_version_file(
            ${CMAKE_BINARY_DIR}/${proj_config_name}ConfigVersion.cmake
            VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}
            COMPATIBILITY SameMajorVersion)

    # Name of ${proj_config_name}'s targets file.
    set(projTargetsFileName "${proj_config_name}Targets")

    # The cmake module path for ${proj_config_name}.
    set(cmakeModulesDir "${CMAKE_INSTALL_LIBDIR}/cmake")

    # Installation path for ${proj_config_name} files.
    set(cmakeProjDir "${cmakeModulesDir}/${proj_config_name}")

    # Installation path and file name of ${proj_config_name}'s targets file.
    set(cmakeProjTargetsFilePath "${cmakeProjDir}/${projTargetsFileName}")

    configure_package_config_file(
            ${${proj_config_name}_CONFIG_IN_FILE}
            ${CMAKE_BINARY_DIR}/${proj_config_name}Config.cmake
            INSTALL_DESTINATION ${cmakeProjDir}
            PATH_VARS cmakeModulesDir cmakeProjTargetsFilePath
            NO_SET_AND_CHECK_MACRO
            NO_CHECK_REQUIRED_COMPONENTS_MACRO)

    install(EXPORT ${export_set_name}
            NAMESPACE ${proj_config_name}::
            FILE ${projTargetsFileName}.cmake
            DESTINATION "${cmakeProjDir}/")

    install(FILES
            "${CMAKE_BINARY_DIR}/${proj_config_name}Config.cmake"
            "${CMAKE_BINARY_DIR}/${proj_config_name}ConfigVersion.cmake"
            DESTINATION "${cmakeProjDir}/")
endfunction()
