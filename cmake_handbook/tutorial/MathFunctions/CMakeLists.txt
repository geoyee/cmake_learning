ADD_LIBRARY(MathFunctions mysqrt.cpp)

INSTALL(TARGETS MathFunctions DESTINATION bin)
INSTALL(FILES MathFunctions.h DESTINATION include)
