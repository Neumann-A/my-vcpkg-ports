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
        URL "https://static.rust-lang.org/dist/2024-05-02/rustc-1.78.0-i686-pc-windows-msvc.tar.xz"
        SHA512 759e8524c93d0136fbe20e05a016754e09d410c7b60796cc4a90c349626f90e12bbc362458fa547266f3805cfad987c533d8b4ee0f40edc9c6e1f09b0257b08f
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2024-05-02/rust-std-1.78.0-i686-pc-windows-msvc.tar.xz"
        SHA512 1d72d2c3ee3fbd18d064e481a696318f0d43be67e06eda78d9268c2e70802f6e1692bfe6680858fb788b9750c6d0cca6848f4a1ead9c4203b596b3000930c06f
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2024-05-02/cargo-1.78.0-i686-pc-windows-msvc.tar.xz"
        SHA512 56c93eb802de9fd1894c814997eab33dda0f938ca0b8097db044b21dff581a98f88377e27ede3bf778a9d05198c0f1ce5e43b3a25a9c8627a4b905d2efecc31e
    )

    # x86_64-pc-windows-msvc
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2024-05-02/rustc-1.78.0-x86_64-pc-windows-msvc.tar.xz"
        SHA512 b76d9dd3ac3424b3a9f55ea4d64ccffe9940978f764842fedbcae89f49ddaeebaaa214b4b84765653d4050e72af0b068609acbb7a3b0e3434f75d8630fd4da0c
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2024-05-02/rust-std-1.78.0-x86_64-pc-windows-msvc.tar.xz"
        SHA512 45e8bc306c58866493e09750affe8eee78d3406341327171f80a7d003381c1646af7da26882975d9cb3951ae9ddcc1439ea13b1eef473281197c8ff6324b4017
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2024-05-02/cargo-1.78.0-x86_64-pc-windows-msvc.tar.xz"
        SHA512 ce933972ceb6e64fd44d3fd4a04b91d00631c8437854ad2d6cbf023aadc13f13c92ed0b33e0c85d9c995761965e8f64ab8893ca4b3c46dd037fff4c91a9a29f9
    )

    # i686-unknown-linux-gnu
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2024-05-02/rustc-1.78.0-i686-unknown-linux-gnu.tar.xz"
        SHA512 6579fb70add24cb7d92f0243819ea468448aa1671c3a84f9409477aa16eb0d7ac0510811b334cd71ba38be7bb2da3ff682314249f82e14cd157ee0efa3074214
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2024-05-02/rust-std-1.78.0-i686-unknown-linux-gnu.tar.xz"
        SHA512 82dafd9bc177ded63364882dae86701503b3dd2620aaaf99449c88e7e69f9e14f429c5c6a6b81bebc51e8d896a7ad2d792636a988c18f3923e18a975c206ad00
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2024-05-02/cargo-1.78.0-i686-unknown-linux-gnu.tar.xz"
        SHA512 3f68beb090ef9e4314cdd833aec62ed3b41a54af16ab49368060052b6c1b05265f0de19774181d8fa00a941206b907a7009c5b7f2b74ef8635214a9f574d5974
    )

    # x86_64-unknown-linux-gnu
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2024-05-02/rustc-1.78.0-x86_64-unknown-linux-gnu.tar.xz"
        SHA512 d3290a5764304d265713b0724d94f5d986aaa47c2a6407f6234daf7dd5d4eacfe4642559c72ce17e4d4395e55bbd40f19e88f0db6653963aa29cec8cf6c0f8e0
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2024-05-02/rust-std-1.78.0-x86_64-unknown-linux-gnu.tar.xz"
        SHA512 8d88664cc73b2937d9124f593b08ba61ef14c027cefdd97973954a66886658567ea9eb9f505441e985ba1053d1bee7dba0cfa8cdd65456a3abec6fe809c65b87
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2024-05-02/cargo-1.78.0-x86_64-unknown-linux-gnu.tar.xz"
        SHA512 feb72154e052d275cb9fe5c9bec6514ddfedf1872cd64c3f6665fec2e8f0e257a83b3273d8b11090f1ae810c71c204ebc7d1bec4352107b84c0e0e3babaf8859
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
