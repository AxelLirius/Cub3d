# COLORS #
_RED        =    \e[31m
_GREEN        =    \e[32m
_YELLOW        =    \e[33m
_BLUE        =    \e[34m
_END        =    \e[0m

# COMPILATION #
CC_FLAGS    =  -Wall -Wextra -Werror

# DIRECTORIES #
DIR_HEADERS        =    includes/
DIR_SRCS        =    src/
DIR_OBJS        =    compiled_srcs/

# FILES #
SRCS            =     main.c 
DEBUG            =    debug.c


# COMPILED_SOURCES #
OBJS         =    $(SRCS:%.c=$(DIR_OBJS)%.o)
NAME         =    main

ifneq (,$(filter debug,$(MAKECMDGOALS)))
^ICC_FLAGS += -DDEBUG
^ISRCS += $(DEBUG)
endif

## RULES ##
all debug:        $(NAME)

# VARIABLES RULES #

$(NAME):        $(OBJS)
			 	@echo "\033[2K\r$(_BLUE) All files compiled into '$(DIR_OBJS)'. $(_END)✅\n"
				gcc $(CC_FLAGS) $(OBJS) -o $(NAME)
				@echo "\033[2K\r$(_GREEN) Executable '$(NAME)' created. $(_END)✅\n"

# COMPILED_SOURCES RULES #
$(OBJS):        | $(DIR_OBJS)


$(DIR_OBJS)%.o: $(DIR_SRCS)%.c
				@echo "\033[2K\r $(_YELLOW)Compiling $< $(_END)⌛ "
				@gcc $(CC_FLAGS) -I $(DIR_HEADERS) -c $< -o $@

$(DIR_OBJS):
				@mkdir -p $(DIR_OBJS)

# MANDATORY PART #
clean:
				@rm -rf $(DIR_OBJS)
				@echo "\033[2K\r$(_RED) '"$(DIR_OBJS)"' has been deleted. $(_END)🗑️\n"

fclean:            clean
				@rm -rf $(NAME)
				@echo "\033[2K\r$(_RED) '"$(NAME)"' has been deleted. $(_END)🗑️\n"

re:                fclean all

# PHONY #

.PHONY:            all debug clean fclean re
