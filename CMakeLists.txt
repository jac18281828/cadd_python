cmake_minimum_required(VERSION 3.9)

project(${PROJECT_NAME} LANGUAGES C CXX VERSION 1.0.0)

include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/609281088cfefc76f9d0ce82e1ff6c30cc3591e5.zip
)
FetchContent_MakeAvailable(googletest)

enable_testing()

add_library(
        cadd SHARED
        src/add.c
)
target_link_libraries(
  cadd
  m
)

add_executable(
        cadd_test
        test/add_test.cpp
)

target_include_directories(cadd_test PRIVATE src)

target_link_libraries(
  cadd_test
  cadd
  gtest_main
  m
)

include(GoogleTest)
gtest_discover_tests(cadd_test)
