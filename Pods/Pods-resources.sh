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
      echo "cp -fpR ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      cp -fpR "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename $1 .xcdatamodeld`.momd"
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename $1 .xcdatamodeld`.momd"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
install_resource 'AviarySDK/3.1.1-master-basic/AviarySDK/Resources/AviarySDKResources.bundle'
install_resource 'Facebook-iOS-SDK/src/FacebookSDKResources.bundle'
install_resource 'Facebook-iOS-SDK/src/FBUserSettingsViewResources.bundle'
install_resource 'FontasticIcons/FontasticIcons/Sources/Resources/Fonts/Entypo-Social.otf'
install_resource 'FontasticIcons/FontasticIcons/Sources/Resources/Fonts/Entypo.otf'
install_resource 'FontasticIcons/FontasticIcons/Sources/Resources/Fonts/fontawesome.ttf'
install_resource 'FontasticIcons/FontasticIcons/Sources/Resources/Fonts/iconic.otf'
install_resource 'FontasticIcons/FontasticIcons/Sources/Resources/Strings/Entypo.strings'
install_resource 'FontasticIcons/FontasticIcons/Sources/Resources/Strings/EntypoSocial.strings'
install_resource 'FontasticIcons/FontasticIcons/Sources/Resources/Strings/FontAwesomeRegular+Deprecation.strings'
install_resource 'FontasticIcons/FontasticIcons/Sources/Resources/Strings/FontAwesomeRegular.strings'
install_resource 'FontasticIcons/FontasticIcons/Sources/Resources/Strings/IconicStroke.strings'
install_resource 'GKImagePicker/GKImages/PLCameraSheetButton.png'
install_resource 'GKImagePicker/GKImages/PLCameraSheetButton@2x.png'
install_resource 'GKImagePicker/GKImages/PLCameraSheetButtonPressed.png'
install_resource 'GKImagePicker/GKImages/PLCameraSheetButtonPressed@2x.png'
install_resource 'GKImagePicker/GKImages/PLCameraSheetDoneButton.png'
install_resource 'GKImagePicker/GKImages/PLCameraSheetDoneButton@2x.png'
install_resource 'GKImagePicker/GKImages/PLCameraSheetDoneButtonPressed.png'
install_resource 'GKImagePicker/GKImages/PLCameraSheetDoneButtonPressed@2x.png'
install_resource 'SIAlertView/SIAlertView/SIAlertView.bundle'

rsync -avr --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rm "$RESOURCES_TO_COPY"
