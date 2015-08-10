# I am not very good at Makefiles.

INCLUDE_DIRS = . #add all extent include path sparate by space
SOURCE_DIRS = . #sub #search the entir dir find source files,without end slash
SOURCES = #main.c sub/123.c #add special file but don't want to add whole dir

CC = gcc
CFLAGS = -Wall -Wextra -Werror -O3 $(addprefix -I,$(INCLUDE_DIRS))
LDFLAGS =
CPPFLAGS = $(CFLAGS)
TARGET = test


.PHONY:all
all: $(TARGET)

###################################
OBJ_DIR = obj
#$(info sources:$(SOURCES))
#$(info source dir: $(SOURCE_DIRS))
SEARCH_PATHS = $(SOURCE_DIRS)
#$(info vapth1:$(SEARCH_PATHS));
SEARCH_PATHS += $(patsubst %/,%,$(dir $(SOURCES)))
#$(info vapth2:$(SEARCH_PATHS));

empty :=
space := $(empty) $(empty)
VPATH = $(subst $(space),:,$(sort $(SEARCH_PATHS)))
#$(info vapth3:$(VPATH));


SOURCES += $(foreach dir,$(SOURCE_DIRS),$(wildcard $(dir)/*.c))

bin $(OBJ_DIR) lib:
	mkdir -p $@

OBJECTS = $(addprefix $(OBJ_DIR)/,$(patsubst %.c,%.o,$(notdir $(SOURCES))))

#$(info objects:$(OBJECTS))


$(OBJ_DIR)/%.o:%.c $(INCLUDES) $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET):$(OBJECTS)
	$(CC) $(LDFLAGS) $^ -o $@

.PHONY:clean
clean:
	@rm -rf $(OBJ_DIR) $(TARGET)
