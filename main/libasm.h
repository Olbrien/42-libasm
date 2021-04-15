#ifndef LIBASM_H
# define LIBASM_H

# include <stdio.h>
# include <unistd.h>
# include <string.h>
# include <stdlib.h>

/* Menu Functions */

void 	announcement(char *texto);
void 	ft_test_strlen();
void 	ft_test_strcpy();
void	ft_test_strcmp();

/* Assembly Functions */

size_t	ft_strlen(const char *s);
char	*ft_strcpy(char *dest, const char *src);
//int 	ft_strcmp(const char *s1, const char *s2);










#endif
