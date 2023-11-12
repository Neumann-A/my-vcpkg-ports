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

    # If the package doesn't match the host triplet, bail here
    if(NOT HOST_TRIPLET MATCHES "^${arg_ARCH}-${arg_PLATFORM}.*$")
        return()
    endif()

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
        URL "https://static.rust-lang.org/dist/2023-10-05/rustc-1.73.0-i686-pc-windows-msvc.tar.xz"
        SHA512 d276e1e716d0cb30834f208d17d29587f9ca8a591b13afdbd14a7a66db443a834c8cfbb00f5d26233f1f77f425aa338850ec365ab35b9289b960be252efe5ccf
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-10-05/rust-std-1.73.0-i686-pc-windows-msvc.tar.xz"
        SHA512 b053ffc0b8a589d399b4e58117bfff7933c06403460da11190bac99ac0a31c5d039f9bbde91d5feb9259a4cee9ebf99e20ecd5eeb863127ffc7315998a38a2d1
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-10-05/cargo-1.73.0-i686-pc-windows-msvc.tar.xz"
        SHA512 f7f9f56ceba087dfb2e9458d956127648981919c6231ca752906fed14ec8d03f17589139b92d62e48b7eb049fc4e5a54ab66aa44dfbfb1f26f7be763a91c9e08
    )

    # x86_64-pc-windows-msvc
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-10-05/rustc-1.73.0-x86_64-pc-windows-msvc.tar.xz"
        SHA512 8a35238e43984ee53b7182c1484bbf8a5d099914e27767a521f2295e3695f5a2d366459a9b0d65c1b13403dedce21af252fe57ff8c4edb3aaf5678cf7f0eb1fe
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-10-05/rust-std-1.73.0-x86_64-pc-windows-msvc.tar.xz"
        SHA512 99d47ef6ec2d8d2b7ea2f28f50b2331196e40765749051db16f098ef4bfbce87188582520b7f12212f2d9b907a948e231abffcecf6db2d330851a65402156ee6
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-10-05/cargo-1.73.0-x86_64-pc-windows-msvc.tar.xz"
        SHA512 7eb68720051f5ec3947adceb0fd57cb4d7c9fef5c8d81448d3d10462fef99493040a184fd7b560de355d243d35a14ca61879d5c8cd659f10f6e37d7f17d7a969
    )

    # i686-unknown-linux-gnu
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-10-05/rustc-1.73.0-i686-unknown-linux-gnu.tar.xz"
        SHA512 f50fec81798e677b1bc35f35e265029023874eb5ebd668dab075ff5da2225ab7d66cc728888c6d67928f5c598ea61bea2552d1152e91f0b87549000b22ca213b
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-10-05/rust-std-1.73.0-i686-unknown-linux-gnu.tar.xz"
        SHA512 5d6de30d225fdff61f3cbe34bd1c801ebb42ee2ec0e5f15b9fd699b2676e4aa2f7492ebd7b4f75cbb1a53385a5617ed6a6c5de498b170edd0e1b1256e2f3975d
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-10-05/cargo-1.73.0-i686-unknown-linux-gnu.tar.xz"
        SHA512 bb7b977136bcff6942482690d04732e27abd2b31465c478c57ab403e0875778a20c4360406cbb8609b793e5c9a5bcb446a3cb542453d74ac82d2c395a8e459d2
    )

    # x86_64-unknown-linux-gnu
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-10-05/rustc-1.73.0-x86_64-unknown-linux-gnu.tar.xz"
        SHA512 81b972f394dbec1f1a7d015f0aa92f4f40f3a6b4c85ef8cc5acbc8c4b2628963c88d6024a9d7cb7e7eff11bc24dd3d7c07d104799bb260520a20cc85fae7c897
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-10-05/rust-std-1.73.0-x86_64-unknown-linux-gnu.tar.xz"
        SHA512 7b41b8878b1e9d612939131c45a3e14e29d4ecaf0dc09379e98ce1f4278512eb67c39a012c35ae0ad97e252e35f08a70f6a7f5fc5083701e251e273ac979bd87
    )
    z_vcpkg_rust_acquire_declare_package(
        URL "https://static.rust-lang.org/dist/2023-10-05/cargo-1.73.0-x86_64-unknown-linux-gnu.tar.xz"
        SHA512 b2d1ff2c168f81dbcf71828f45f7cdb16e0e5fde6e7db29206744b5a99ca7dc61e3b59a9580fd69a1a61492ab3ae871352bca1deb14506e19b4dbbaa1c7658b0
    )

    if(NOT Z_VCPKG_RUST_PACKAGES STREQUAL "")
        message(FATAL_ERROR "Unknown packages were required for vcpkg_rust_acquire(${arg_PACKAGES}): ${packages}
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
