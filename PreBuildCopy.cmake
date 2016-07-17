include(CMakeParseArguments)

###################################################################################
# USING: pre_build_copy(TARGETS target1  target2 ... PATHS path1 path2 ...)       #
# This macro add custom command that copy resources to source dir of targets list #
###################################################################################

macro(pre_build_copy)
    cmake_parse_arguments(ARG "" "TARGET;DESTINATION" "COPY" ${ARGN})
    if(TARGET ${ARG_TARGET})
        foreach(path IN LISTS ARG_COPY)
            if(IS_DIRECTORY ${path})
                file(GLOB_RECURSE FILES "${path}/*")
                file(COPY ${FILES} DESTINATION ${ARG_DESTINATION})
                add_custom_command(TARGET ${ARG_TARGET} PRE_BUILD
                        COMMAND ${CMAKE_COMMAND} -E copy ${FILES} ${ARG_DESTINATION})
            elseif(EXISTS ${path})
                file(COPY ${path} DESTINATION ${ARG_DESTINATION})
                add_custom_command(TARGET ${ARG_TARGET} PRE_BUILD
                        COMMAND ${CMAKE_COMMAND} -E copy ${path} ${ARG_DESTINATION})
            else()
                message(FATAL_ERROR "Can't copy path: ${path}")
            endif()
        endforeach()
    else()
        message(FATAL_ERROR "The target don't exist: ${ARG_TARGET}.")
    endif()
endmacro()