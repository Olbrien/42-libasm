NAME =		libasm.a

SRC =		./ft_strlen.s \
			./ft_strcpy.s \
			./ft_strcmp.s #\
			#./ft_read.s \
			#./ft_strdup.s \
			#./ft_write.s

OBJ =		$(SRC:%.s=%.o)

%.o: %.s
	@nasm -f elf64 -g -F dwarf $<

all:		$(NAME)

$(NAME): $(OBJ)
	@ar -rc $(NAME) $(OBJ)
	@ranlib $(NAME)

clean:
	@rm -f $(OBJ)

fclean:	clean
	@rm -f $(NAME)

re:	fclean all
