# COLORS #
_RED        =    \e[31m
_GREEN        =    \e[32m
_YELLOW        =    \e[33m
_BLUE        =    \e[34m
_END        =    \e[0m

# COMPILATION #
CC_FLAGS    =  -Wall -Wextra -Werror

# DIRECTORIES #
DIR_HEADERS        =    ./includes/
DIR_SRCS        =    ./srcs/
DIR_OBJS        =    ./compiled_srcs/

# FILES #
SRCS            =     main.c 
DEBUG            =    debug.c


# COMPILED_SOURCES #
OBJS         =    $(SRCS:%.c=$(DIR_OBJS)%.o)
NAME         =    Cub3d

ifneq (,$(filter debug,$(MAKECMDGOALS)))
^ICC_FLAGS += -DDEBUG
^ISRCS += $(DEBUG)
endif

## RULES ##
all debug:        $(NAME)

# VARIABLES RULES #

$(NAME):        $(OBJS)
			 	^I^I@printf "\033[2K\r$(_BLUE) All files compiled into '$(DIR_OBJS)'. $(_END)✅\n"
				^I^I@gcc $(CC_FLAGS) -I $(DIR_HEADERS) $(OBJS) -o $(NAME)
				^I^I@printf "\033[2K\r$(_GREEN) Executable '$(NAME)' created. $(_END)✅\n"

# COMPILED_SOURCES RULES #
$(OBJS):        | $(DIR_OBJS)


$(DIR_OBJS)%.o: $(DIR_SRCS)%.c
				^I^I@printf "\033[2K\r $(_YELLOW)Compiling $< $(_END)⌛ "
				^I^I@gcc $(CC_FLAGS) -I $(DIR_HEADERS) -c $< -o $@

$(DIR_OBJS):
				^I^I@mkdir -p $(DIR_OBJS)

# MANDATORY PART #
clean:
				^I^I@rm -rf $(DIR_OBJS)
				^I^I@printf "\033[2K\r$(_RED) '"$(DIR_OBJS)"' has been deleted. $(_END)🗑️\n"

fclean:            clean
				^I^I@rm -rf $(NAME)
				^I^I@printf "\033[2K\r$(_RED) '"$(NAME)"' has been deleted. $(_END)🗑️\n"

re:                fclean all

# PHONY #

.PHONY:            all debug clean fclean re
