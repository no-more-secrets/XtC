NEW_C_SRCS := $(CWD)/strextra.c $(CWD)/xtc.c
NEW_DEPS   := $(NEW_C_SRCS:.c=.d)

C_SRCS    := $(C_SRCS) $(NEW_C_SRCS)
OBJS      := $(OBJS) $(NEW_C_SRCS:.c=.o)
DEPS      := $(DEPS) $(NEW_DEPS)
BINARIES  := $(BINARIES) $(LIB_NAME)
LIBRARIES := $(LIBRARIES) $(LIB_NAME)

-include $(NEW_DEPS)

$(CWD)/%.o: HERE := $(CWD)
$(CWD)/%.o: $(CWD)/%.c
	$(CC) -I$(LIB_INTERFACE) -I$(HERE) -I$(LIBXML2_INCLUDE) $(CFLAGS_LIB) $(CFLAGS) -c $< -o $@

$(LIB_NAME): $(CWD)/xtc.o $(CWD)/strextra.o
	$(LD) $(LDFLAGS_LIB) $(LDFLAGS) $(LIBXML2_LIB) $^ -o $@
