include_guard(GLOBAL)

# Looks like Rust doesn't have any mirrors
set(Z_VCPKG_ACQUIRE_RUST_MIRRORS
    "https://static.rust-lang.org/"
)

function(z_vcpkg_rust_acquire_download_package out_archive)
    cmake_parse_arguments(PARSE_ARGV 1 "arg" "" "URL;SHA512;FILENAME" "")
    if(DEFINED arg_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "internal error: z_vcpkg_rust_acquire_download_package passed extra args: ${arg_UNPARSED_ARGUMENTS}")
    endif()

    set(all_urls "${arg_URL}")

    foreach(mirror IN LISTS Z_VCPKG_ACQUIRE_RUST_MIRRORS)
        string(REPLACE "https://static.rust-lang.org/" "${mirror}" mirror_url "${arg_URL}")
        list(APPEND all_urls "${mirror_url}")
    endforeach()

    vcpkg_download_distfile(rust_archive
        URLS ${all_urls}
        SHA512 "${arg_SHA512}"
        FILENAME "rust-${arg_FILENAME}"
        QUIET
    )
    set("${out_archive}" "${rust_archive}" PARENT_SCOPE)
endfunction()

# writes to the following variables in parent scope:
#   - Z_VCPKG_RUST_ARCHIVES
#   - Z_VCPKG_RUST_TOTAL_HASH
#   - Z_VCPKG_RUST_PACKAGES
#   - Z_VCPKG_RUST_${arg_NAME}_ARCHIVE
#   - Z_VCPKG_RUST_${arg_NAME}_PATCHES
function(z_vcpkg_rust_acquire_declare_package)
    cmake_parse_arguments(PARSE_ARGV 0 arg "" "NAME;ARCH;PLATFORM;URL;SHA512;DIRECTORY" "DEPS")

    if(DEFINED arg_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "internal error: z_vcpkg_rust_acquire_declare_package passed extra args: ${arg_UNPARSED_ARGUMENTS}")
    endif()
    foreach(required_arg IN ITEMS URL SHA512)
        if(NOT DEFINED arg_${required_arg})
            message(FATAL_ERROR "internal error: z_vcpkg_rust_acquire_declare_package requires argument: ${required_arg}")
        endif()
    endforeach()

    if(NOT arg_URL MATCHES [[^https://static.rust-lang.org/dist/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/(([a-z_-]+)-([0-9]+\.[0-9]+\.[0-9])-(aarch64|arm|armv7|i686|mips|mips64|mips64el|mipsel|powerpc|powerpc64|powerpc64le|riscv64gc|s390x|x86_64)-([a-z0-9_-]+)\.tar\.xz)$]])
        message(FATAL_ERROR "internal error: regex does not match supplied URL to vcpkg_rust_acquire: ${arg_URL}")
    endif()

    set(filename "${CMAKE_MATCH_1}")
    if(NOT DEFINED arg_NAME)
        set(arg_NAME "${CMAKE_MATCH_2}")
    endif()

    if(NOT DEFINED arg_ARCH)
        if("${CMAKE_MATCH_4}" STREQUAL "x86_64")
            set(arg_ARCH "x64")
        elseif("${CMAKE_MATCH_4}" STREQUAL "i686")
            set(arg_ARCH "x86")
        else()
            message(FATAL_ERROR "internal error: Can't match architecture '${CMAKE_MATCH_4}' to vcpkg architecture")    
        endif()
    endif()

    if(NOT DEFINED arg_PLATFORM)
        if("${CMAKE_MATCH_5}" STREQUAL "pc-windows-msvc")
            set(arg_PLATFORM "windows")
		elseif("${CMAKE_MATCH_5}" STREQUAL "unknown-linux-gnu")
			set(arg_PLATFORM "linux")
        else()
            message(FATAL_ERROR "internal error: Can't match platform '${CMAKE_MATCH_5}' to vcpkg platform")
        endif()
    endif()

    message("DECLARING: ${filename}")
    # If the package doesn't match the host triplet, bail here
    if(arg_PLATFORM STREQUAL "windows" AND NOT (VCPKG_TARGET_IS_WINDOWS OR CMAKE_HOST_WIN32))
      return()
    elseif(NOT arg_ARCH STREQUAL "${VCPKG_TARGET_ARCHITECTURE}")
      return()
    endif()
    message("DECLARED: ${filename}")
    #if((NOT HOST_TRIPLET MATCHES "^${arg_ARCH}-${arg_PLATFORM}.*$") AND (arg_PLATFORM STREQUAL "windows" AND NOT VCPKG_TARGET_IS_WINDOWS AND NOT arg_ARCH STREQUAL "${VCPKG_TARGET_ARCHITECTURE}"))
    #    message("NOT USED: ${filename}")
    #    return()
    #endif()

    if("${arg_NAME}" IN_LIST Z_VCPKG_RUST_PACKAGES OR arg_Z_ALL_PACKAGES)
        list(REMOVE_ITEM Z_VCPKG_RUST_PACKAGES "${arg_NAME}")
        list(APPEND Z_VCPKG_RUST_PACKAGES ${arg_DEPS})
        set(Z_VCPKG_RUST_PACKAGES "${Z_VCPKG_RUST_PACKAGES}" PARENT_SCOPE)

        z_vcpkg_rust_acquire_download_package(archive
            URL "${arg_URL}"
            SHA512 "${arg_SHA512}"
            FILENAME "${filename}"
        )

        list(APPEND Z_VCPKG_RUST_ARCHIVES "${arg_NAME}")
        set(Z_VCPKG_RUST_ARCHIVES "${Z_VCPKG_RUST_ARCHIVES}" PARENT_SCOPE)
        set(Z_VCPKG_RUST_${arg_NAME}_ARCHIVE "${archive}" PARENT_SCOPE)
        set(Z_VCPKG_RUST_${arg_NAME}_PATCHES "${arg_PATCHES}" PARENT_SCOPE)
        string(APPEND Z_VCPKG_RUST_TOTAL_HASH "${arg_SHA512}")
        set(Z_VCPKG_RUST_TOTAL_HASH "${Z_VCPKG_RUST_TOTAL_HASH}" PARENT_SCOPE)
    endif()
endfunction()

function(z_vcpkg_rust_install_packages out_rust_root)
    cmake_parse_arguments(PARSE_ARGV 1 "arg"
        "NO_DEFAULT_PACKAGES;Z_ALL_PACKAGES"
        ""
        "PACKAGES"
    )

    if(DEFINED arg_UNPARSED_ARGUMENTS)
        message(WARNING "vcpkg_rust_acquire was passed extra arguments: ${arg_UNPARSED_ARGUMENTS}")
    endif()

    set(Z_VCPKG_RUST_TOTAL_HASH "")
    set(Z_VCPKG_RUST_ARCHIVES "")

    set(Z_VCPKG_RUST_PACKAGES "${arg_PACKAGES}")

    if(NOT arg_NO_DEFAULT_PACKAGES)
        list(APPEND Z_VCPKG_RUST_PACKAGES rustc rust-std cargo)
    endif()

    # i686-pc-windows-msvc
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-12-28/rustc-1.75.0-i686-pc-windows-msvc.tar.xz"
        SHA512 8f688515a0af5e35476986bbd97ccdf7d59d32e9b534d2dcee8cbb843a94f188e215519b8112ab7d73d4bc3fbe980b5147fa6f0a98f5e2dcc0654bef6113a725
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-12-28/rust-std-1.75.0-i686-pc-windows-msvc.tar.xz"
        SHA512 e963297de71848f03c9b5f3dd7819fe701af91aaeced13ae079a23c50a4f62703f1cda8cbdc8117fa874f20aad82c0ad637432872833aa2c1ebff653d5bb61d2
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-12-28/cargo-1.75.0-i686-pc-windows-msvc.tar.xz"
        SHA512 2c6ecf1115488c90041aa427098d7bbd8311aa2107539b3d63f4c35f8bab797decd09f986a7f9424344984c03998937fd9ed971534d3d106dc312afbf6140755
    )

    # x86_64-pc-windows-msvc
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-12-28/rustc-1.75.0-x86_64-pc-windows-msvc.tar.xz"
        SHA512 f611277b3901efffb12fdd49e06b5f566ad1884d0f1277136e499e1aceacf0443bd9b310787f89fa59381210fe86c33c8a5a8159ae775841b664006266110d25
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-12-28/rust-std-1.75.0-x86_64-pc-windows-msvc.tar.xz"
        SHA512 77aa97514bf6432878e52421c80731fce68177dc1c050b32cc65fc04901e74f80a45033aa47ce06e5343a40a1d9f426ff217a29bfbc1f4d1b6454503ffa0e9f5
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-12-28/cargo-1.75.0-x86_64-pc-windows-msvc.tar.xz"
        SHA512 142a387ed0e59fe135cd612f73bf6bb59b86bd0c758600de1a45a4bd86145f1c2d43ba0363d524b81335c3a3e35e47ae0a70b72f7462951aa67c9be3e1691869
    )

    # i686-unknown-linux-gnu
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-12-28/rustc-1.75.0-i686-unknown-linux-gnu.tar.xz"
        SHA512 e843cabbfb52fa7f5e938fa4d785d2bb5557c41537f0356a321e94f05e829202e81d3367d773aaa8f4e7ed764879f5aa0a0e18f7f2f90b5ffb8b51428ce86821
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-12-28/rust-std-1.75.0-i686-unknown-linux-gnu.tar.xz"
        SHA512 2c09182f316b9f83e858fe9819c08597712beb705ee4981de353fa91f5a887e553cc213376b093d34ceb9429520ffd3a6ca69df8462e82e32298c2aa85bf9727
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-12-28/cargo-1.75.0-i686-unknown-linux-gnu.tar.xz"
        SHA512 f3816686664e015a537d1933418b25b8b912e64934d548d3773c1b186b37ac51d9ae3c77506de5090fa3eb10d5fc5a66e2f9c90533c8ed671f0e50b7adc256bf
    )

    # x86_64-unknown-linux-gnu
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-12-28/rustc-1.75.0-x86_64-unknown-linux-gnu.tar.xz"
        SHA512 e95c96772242d00bd14018c4461eaf826b6ac301314343e00de07d54d889802e7e14be7187e0496f8a5cc64aed016dc67bfc24efac9948001eb040cee2a3b1b9
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-12-28/rust-std-1.75.0-x86_64-unknown-linux-gnu.tar.xz"
        SHA512 abf6129f6c4319f0ca1bf741302a8bfde8405f190dacdea72cf57b670b84200d0e67c4ba28a61e2ce23b43c1126fd5cda8716cc80a2ad889a224e7806e37833b
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-12-28/cargo-1.75.0-x86_64-unknown-linux-gnu.tar.xz"
        SHA512 bc36976aeab4396cff3214cccfad4445fde55289dbfa1aec3b60596bcb2aa6a44964022ef797013693c7cc07439aabae0fb6300ea2752589b44dc35abc4f3620
    )

    if(NOT Z_VCPKG_RUST_PACKAGES STREQUAL "")
        message(FATAL_ERROR "Unknown packages '${Z_VCPKG_RUST_PACKAGES}' were required for vcpkg_rust_acquire(${arg_PACKAGES}): ${packages}
This can be resolved by explicitly passing URL/SHA pairs to DIRECT_PACKAGES.")
    endif()

    string(SHA512 total_hash "${Z_VCPKG_RUST_TOTAL_HASH}")
    string(SUBSTRING "${total_hash}" 0 16 total_hash)
    set(path_to_root "${DOWNLOADS}/tools/rust/${total_hash}")
    if(NOT EXISTS "${path_to_root}")
        file(REMOVE_RECURSE "${path_to_root}.tmp")
        set(index 0)
        foreach(archive IN LISTS Z_VCPKG_RUST_ARCHIVES)
			file(MAKE_DIRECTORY "${path_to_root}.tmp/staging-${archive}")
            vcpkg_execute_required_process(
                ALLOW_IN_DOWNLOAD_MODE
                COMMAND "${CMAKE_COMMAND}" -E tar xzf "${Z_VCPKG_RUST_${archive}_ARCHIVE}"
                LOGNAME "rust-${TARGET_TRIPLET}-${index}-tar"
                WORKING_DIRECTORY "${path_to_root}.tmp/staging-${archive}"
            )
			
			if(Z_VCPKG_RUST_${archive}_ARCHIVE MATCHES [[^.*/rust-(([a-z_-]+)-[0-9]+\.[0-9]+\.[0-9]-([a-z0-9_]+-[a-z0-9_-]+))\.tar\.xz$]])
				if(${CMAKE_MATCH_2} STREQUAL "rust-std")
					set(directory "${CMAKE_MATCH_1}/${CMAKE_MATCH_2}-${CMAKE_MATCH_3}")
				else()
					set(directory "${CMAKE_MATCH_1}/${CMAKE_MATCH_2}")
				endif()
			
				vcpkg_execute_required_process(
					ALLOW_IN_DOWNLOAD_MODE
					COMMAND "${CMAKE_COMMAND}" -E copy_directory "${path_to_root}.tmp/staging-${archive}/${directory}" "${path_to_root}.tmp/"
					LOGNAME "rust-${TARGET_TRIPLET}-${index}-copy"
					WORKING_DIRECTORY "${path_to_root}.tmp"
				)
				vcpkg_execute_required_process(
					ALLOW_IN_DOWNLOAD_MODE
					COMMAND "${CMAKE_COMMAND}" -E rm -Rf "${path_to_root}.tmp/staging-${archive}"
					LOGNAME "rust-${TARGET_TRIPLET}-${index}-rm"
					WORKING_DIRECTORY "${path_to_root}.tmp"
				)
			else()
				MESSAGE(FATAL_ERROR "internal error: Regex for getting package path from archive name didn't match")
			endif()
			
            math(EXPR index "${index} + 1")
        endforeach()
        file(RENAME "${path_to_root}.tmp" "${path_to_root}")
    endif()
    message(STATUS "Using rust root at ${path_to_root}")
    set("${out_rust_root}" "${path_to_root}" PARENT_SCOPE)
endfunction()

function(vcpkg_rust_install)
	find_program(CARGO cargo HINTS ENV CARGO_HOME PATH_SUFFIXES "bin" PATHS ENV PATH)
	if(CARGO)
		message(STATUS "Using system rust cargo: ${CARGO}")
	else()
		message(STATUS "No system rust cargo found, installing.")
		z_vcpkg_rust_install_packages(path_to_root)
		vcpkg_add_to_path("${path_to_root}/bin")
	endif()
endfunction()
