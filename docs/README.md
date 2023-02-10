```bash
#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ciglesia <ciglesia@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/20 17:00:07 by ciglesia          #+#    #+#              #
#    Updated: 2021/06/12 01:39:46 by ciglesia         ###   ########.fr        #
#                                                                              #
#******************************************************************************#

NAME		=

#****************** INC *******************#
# General
INC			=	./include/

# Libft
SUB_MAKE	=	./libft/
INCFT		=	./libft/

INCLUDE		=	-O3 -I $(INCFT) -I $(INC)

INC_LIB		=	-L$(INCFT) -lft

DEPEND		=	# dependencies to install

#***************** SRC* *******************#

DIRSRC		=	./src/
DIRFOO		=	$(DIRSRC) #/foo/

SRC			=	# main.c
FOO			=

SRCS		=	$(SRC) $(FOO)

#***************** DEPS ******************#

DIROBJ		=	./depo/

OAUX		=	$(SRCS:%=$(DIROBJ)%)
DEPS		=	$(OAUX:.c=.d)
OBJS		=	$(OAUX:.c=.o)

ifdef FLAGS
	ifeq ($(FLAGS), no)
CFLAGS		=
	endif
	ifeq ($(FLAGS), debug)
CFLAGS		=	-Wall -Wextra -Werror -ansi -pedantic -g
	endif
else
CFLAGS		=	-Wall -Wextra -Werror
endif

ifdef VERB
	ifeq ($(VERB), on)
CFLAGS		+=	-DM_VERB
	endif
endif

CC			=	/usr/bin/clang
RM			=	/bin/rm -f
ECHO		=	/bin/echo -e
BOLD		=	"\e[1m"
BLINK		=	 "\e[5m"
RED			=	 "\e[38;2;255;0;0m"
GREEN		=	 "\e[92m"
BLUE		=	 "\e[34m"
YELLOW		=	 "\e[33m"
E0M			=	 "\e[0m"

#************************ DEPS COMPILATION *************************

%.o				:	../$(DIRSRC)/%.c
					@printf $(GREEN)"Generating project objects... %-33.33s\r" $@
					@$(CC) $(CFLAGS) $(INCLUDE) -MMD -o $@ -c $<

%.o				:	../$(DIRFOO)/%.c
					@printf $(GREEN)"Generating project objects... %-33.33s\r" $@
					@$(CC) $(CFLAGS) $(INCLUDE) -MMD -o $@ -c $<

#************************ MAIN COMPILATION *************************

$(NAME)			:	ftlib $(OBJS)
					@$(ECHO) $(BOLD)$(GREEN)'> Compiled'$(E0M)
					@for font in $(DEPEND); do \
						command -v $$font > /dev/null 2>&1 \
						|| echo >&2 "Could not find '$$font', you can install it with:\e[34m\e[1m Make dependencies\e[0m";  \
					done

clean			:
					@($(RM) $(OBJS))
					@($(RM) $(DEPS))
					@(cd $(SUB_MAKE) && $(MAKE) clean)
					@$(ECHO) $(RED)'> Directory cleaned'$(E0M)

all				:	$(NAME)

fclean			:	clean
					@$(RM) $(NAME)
					@(cd $(SUB_MAKE) && $(MAKE) fclean)
					@$(ECHO) $(RED)'> Executable removed'$(E0M)

re				:	fclean all

ftlib			:
					@(cd $(SUB_MAKE) && $(MAKE))

dependencies	:
					sudo apt install -y $(DEPEND)

.PHONY			:	all clean re fclean ftlib dependencies

-include $(DEPS)
```
