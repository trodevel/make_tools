
# based on http://stackoverflow.com/questions/714100/os-detecting-makefile

ifeq ($(OS),Windows_NT)
    MAKE_OS := WIN32
    ifeq ($(PROCESSOR_ARCHITEW6432),AMD64)
        MAKE_ARCHIT := AMD64
    else
        ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
            MAKE_ARCHIT := AMD64
        endif
        ifeq ($(PROCESSOR_ARCHITECTURE),x86)
            MAKE_ARCHIT := IA32
        endif
    endif
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        MAKE_OS := LINUX
    endif
    ifeq ($(UNAME_S),Darwin)
        MAKE_OS := OSX
    endif
    UNAME_P := $(shell uname -p)
    ifeq ($(UNAME_P),x86_64)
        MAKE_ARCHIT := AMD64
    endif
    ifneq ($(filter %86,$(UNAME_P)),)
        MAKE_ARCHIT := IA32
    endif
    ifneq ($(filter arm%,$(UNAME_P)),)
        MAKE_ARCHIT := ARM
    endif
endif
