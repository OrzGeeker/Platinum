#!/usr/bin/env bash
# -*- conding: utf-8 -*-

# How to make xcframework: https://medium.com/@elmoezamira/build-your-first-xcframework-how-to-create-an-ios-framework-pt-1-d1a889fdb40d

archive_dir="./output"

if [ -d "${archive_dir}" ]; then
    rm -rf "${archive_dir}"
    echo remove dir: ${archive_dir}
fi

carthage_dir="${archive_dir}/Carthage"
carthage_build_dir="${carthage_dir}/Build"
carthage_build_dir_ios="${carthage_build_dir}/iOS"
carthage_build_dir_mac="${carthage_build_dir}/Mac"
mkdir -p "${carthage_build_dir_ios}"
mkdir -p "${carthage_build_dir_mac}"

scheme="Platinum"
for scheme_name in "${scheme}-iOS" "${scheme}-Mac"
do
    case "$scheme_name" in 
        "Platinum-iOS")
            for platform in "iOS" "iOS Simulator"
            do

                platform_framework_output_dir="${archive_dir}/${platform// /_}"

                xcodebuild archive \
                -scheme "${scheme_name}" \
                -destination "generic/platform=${platform}" \
                -archivePath "${platform_framework_output_dir}" \
                SKIP_INSTALL=NO \
                BUILD_LIBRARY_FOR_DISTRIBUTION=YES

                platform_framework_path="${platform_framework_output_dir}.xcarchive/Products/Library/Frameworks/${scheme}.framework"
                platform_framework_dSYM_path="${platform_framework_output_dir}.xcarchive/dSYMs/${scheme}.framework.dSYM"

                cp -r "${platform_framework_path}" "${carthage_build_dir_ios}" 
                cp -r "${platform_framework_dSYM_path}" "${carthage_build_dir_ios}"
            done
        ;;
        "Platinum-Mac")
            for platform in "macOS"
            do

                platform_framework_output_dir="${archive_dir}/${platform// /_}"

                xcodebuild archive \
                -scheme "${scheme_name}" \
                -destination "generic/platform=${platform}" \
                -archivePath "${platform_framework_output_dir}" \
                SKIP_INSTALL=NO \
                BUILD_LIBRARY_FOR_DISTRIBUTION=YES

                platform_framework_path="${platform_framework_output_dir}.xcarchive/Products/Library/Frameworks/${scheme}.framework"
                platform_framework_dSYM_path="${platform_framework_output_dir}.xcarchive/dSYMs/${scheme}.framework.dSYM"

                cp -r "${platform_framework_path}" "${carthage_build_dir_mac}" 
                cp -r "${platform_framework_dSYM_path}" "${carthage_build_dir_mac}" 
            done
        ;;
        *);;
    esac
done

cd $archive_dir && zip -r "${scheme}.framework.zip" Carthage
