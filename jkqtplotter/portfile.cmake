
vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" JKQtPlotter_BUILD_SHARED_LIBS)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static"  JKQtPlotter_BUILD_STATIC_LIBS)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jkriege2/JKQtPlotter
    REF 5fae11472c21a2ffbcd0adba3abadc18a82dc8c7 # d45083ee9bdd96de1a381ad0d63c4ba8ef547e5c
    SHA512 0d868090fd0c9fef00e45a8735be2f89db335f0b62f498c6999aa96eed41711f838ffb6dd999b5eb14d613b5d11d067d06afc6cf76cdffa67b94b3037a11f411 #78757737bf0baffcb6bb8df7b3b0944298e0861901f88ecfda46b0f4e59a8c5e0d6c455f59969aedf424e5fa84577f47b0d9bd3d82847e5b89a08ef307ad003d
    HEAD_REF master
    PATCHES
        remove_deployment.patch
        remove_std.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        --trace-expand
        -DJKQtPlotter_BUILD_SHARED_LIBS=${JKQtPlotter_BUILD_SHARED_LIBS}
        -DJKQtPlotter_BUILD_STATIC_LIBS=${JKQtPlotter_BUILD_STATIC_LIBS}
        -DJKQtPlotter_BUILD_EXAMPLES=ON
        -DQT_VERSION_MAJOR=6
)
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake)

vcpkg_copy_pdbs()

vcpkg_copy_tools(TOOL_NAMES 
                    jkqtplot_test
                    jkqtptest_advplotstyling
                    jkqtptest_barchart
                    jkqtptest_boxplot
                    jkqtptest_contourplot
                    jkqtptest_datastore
                    jkqtptest_datastore_groupedstat
                    jkqtptest_datastore_iterators
                    jkqtptest_datastore_regression
                    jkqtptest_datastore_statistics
                    jkqtptest_datastore_statistics_2d
                    jkqtptest_dateaxes
                    jkqtptest_distributionplot
                    jkqtptest_errorbarstyles
                    jkqtptest_evalcurve
                    jkqtptest_filledgraphs
                    jkqtptest_functionplot
                    jkqtptest_geometric
                    jkqtptest_geo_arrows
                    jkqtptest_geo_simple
                    jkqtptest_imageplot
                    jkqtptest_imageplot_cimg
                    jkqtptest_imageplot_modifier
                    jkqtptest_imageplot_nodatastore
                    jkqtptest_imageplot_userpal
                    jkqtptest_impulsesplot
                    jkqtptest_jkqtfastplotter_test
                    jkqtptest_jkqtmathtext_simpletest
                    jkqtptest_jkqtmathtext_test
                    jkqtptest_logaxes
                    jkqtptest_mandelbrot
                    jkqtptest_parametriccurve
                    jkqtptest_paramscatterplot
                    jkqtptest_paramscatterplot_image
                    jkqtptest_parsedfunctionplot
                    jkqtptest_rgbimageplot
                    jkqtptest_rgbimageplot_cimg
                    jkqtptest_rgbimageplot_qt
                    jkqtptest_simpletest
                    jkqtptest_speed
                    jkqtptest_stackedbars
                    jkqtptest_stepplots
                    jkqtptest_styledboxplot
                    jkqtptest_styling
                    jkqtptest_symbols_and_errors
                    jkqtptest_symbols_and_styles
                    jkqtptest_test_multiplot
                    jkqtptest_ui
                    jkqtptest_user_interaction
                    jkqtptest_violinplot
                    jkqtptest_wiggleplots
                AUTO_CLEAN)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)