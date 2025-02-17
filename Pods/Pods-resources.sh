#!/bin/sh
set -e

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1"`.mom\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd"
      ;;
    /*)
      echo "$1"
      echo "$1" >> "$RESOURCES_TO_COPY"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
install_resource "Facebook-iOS-SDK/src/FacebookSDKResources.bundle"
install_resource "Facebook-iOS-SDK/src/FBUserSettingsViewResources.bundle"
install_resource "FontasticIcons/FontasticIcons/Sources/Resources/Fonts/Entypo-Social.otf"
install_resource "FontasticIcons/FontasticIcons/Sources/Resources/Fonts/Entypo.otf"
install_resource "FontasticIcons/FontasticIcons/Sources/Resources/Fonts/fontawesome.ttf"
install_resource "FontasticIcons/FontasticIcons/Sources/Resources/Fonts/iconic.otf"
install_resource "FontasticIcons/FontasticIcons/Sources/Resources/Strings/Entypo.strings"
install_resource "FontasticIcons/FontasticIcons/Sources/Resources/Strings/EntypoSocial.strings"
install_resource "FontasticIcons/FontasticIcons/Sources/Resources/Strings/FontAwesomeRegular+Deprecation.strings"
install_resource "FontasticIcons/FontasticIcons/Sources/Resources/Strings/FontAwesomeRegular.strings"
install_resource "FontasticIcons/FontasticIcons/Sources/Resources/Strings/IconicStroke.strings"
install_resource "MHPrettyDate/MHPrettyDate/en.lproj"
install_resource "MHPrettyDate/MHPrettyDate/nl.lproj"
install_resource "R1PhotoEffectsSDK/R1PhotoEffectsResources.bundle"
install_resource "SIAlertView/SIAlertView/SIAlertView.bundle"
install_resource "TSMiniWebBrowser/TSMiniWebBrowser/images/back_icon.png"
install_resource "TSMiniWebBrowser/TSMiniWebBrowser/images/back_icon@2x.png"
install_resource "TSMiniWebBrowser/TSMiniWebBrowser/images/forward_icon.png"
install_resource "TSMiniWebBrowser/TSMiniWebBrowser/images/forward_icon@2x.png"
install_resource "TSMiniWebBrowser/TSMiniWebBrowser/images/reload_icon.png"
install_resource "TSMiniWebBrowser/TSMiniWebBrowser/images/reload_icon@2x.png"
install_resource "TSMiniWebBrowser/TSMiniWebBrowser/TSMiniWebBrowser.xib"

rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]]; then
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"
