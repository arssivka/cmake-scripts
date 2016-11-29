# - Try to find OAuth
# Once done, this will define
#
#  OAuth_FOUND - system has Glib
#  OAuth_INCLUDE_DIRS - the Glib include directories
#  OAuth_LIBRARIES - link these to use Glib

find_package(PkgConfig)
pkg_check_modules(PC_OAUTH oauth)

FIND_PATH(OAuth_INCLUDE_DIR oauth.h
        HINTS
        ${PC_OAUTH_INCLUDE_DIRS}
        /usr/include
        /usr/local/include
        /opt/local/include
        PATH_SUFFIXES oauth
        )

FIND_LIBRARY(OAuth_LIBRARY
        NAMES ${OAuth_NAMES} liboauth.so liboauth.dylib
        HINTS ${PC_OAUTH_LIBRARY_DIRS}
        /usr/lib /usr/local/lib /opt/local/lib
        )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OAuth DEFAULT_MSG OAuth_LIBRARY OAuth_INCLUDE_DIR)

IF(OAuth_FOUND)
    SET(OAuth_LIBRARIES ${OAuth_LIBRARY})
    SET(OAuth_INCLUDE_DIRS ${OAuth_INCLUDE_DIR})
ENDIF(OAuth_FOUND)