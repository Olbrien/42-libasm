INDEX=$1

if [[ "$INDEX" == "normal" ]];
then
	echo ""
	echo "Normal Mode!"
	echo ""
	echo "Step 1: Making sure you didn't leave a mess... I told you to clean."
	rm -f -r tester_linux
	rm -f -r tester_mac
	cd srcs_linux
	make fclean
	cd ../srcs_mac
	make fclean
	cd ..
	echo "Step 2: 'make' on ./srcs_mac/Makefile"
	cd srcs_mac
	make re
	echo "Step 3: Make a new directory ./tester_mac/ to put the tester files for easy accessibility."
	cd ..
	mkdir tester_mac
	cd tester_mac
	echo "Step 4: Copy libasm.a, main.c and libasm.h from ./srcs_mac/ and ./main/ to ./tester_mac/"
	cp ../srcs_mac/libasm.a .
	cp ../main/main.c .
	cp ../main/libasm.h .
	cp ../main/texto1.txt .
	cp ../main/texto2.txt .
	echo "Step 5: Compiling main.c with libasm.a to form an executable file."
	gcc -Wall -Wextra -Werror main.c libasm.a -o mac_normal -no-pie
	echo "Step 6: Running the executable file called mac_normal."
	./mac_normal
elif [[ "$INDEX" == "debugger" ]];
then
	echo ""
	echo "Debugger Mode!"
	echo ""
	echo "Step 1: Making sure you didn't leave a mess... I told you to clean."
	rm -f -r tester_linux
	rm -f -r tester_mac
	cd srcs_linux
	make fclean
	cd ../srcs_mac
	make fclean
	cd ..
	echo "Step 2: 'make' on ./srcs_linux/Makefile"
	cd srcs_mac
	make re
	echo "Step 3: Make a new directory ./tester_mac/ to put the tester files for easy accessibility."
	cd ..
	mkdir tester_mac
	cd tester_mac
	echo "Step 4: Copy libasm.a, main.c, libasm.h and .s files from ./srcs_mac/ and ./main/ to ./tester_mac/"
	cp ../srcs_mac/libasm.a .
	cp ../main/main.c .
	cp ../main/libasm.h .
	cp ../main/texto1.txt .
	cp ../main/texto2.txt .
	cp ../srcs_mac/ft_strlen.s .
	cp ../srcs_mac/ft_strcpy.s .
	cp ../srcs_mac/ft_strcmp.s .
	cp ../srcs_mac/ft_write.s .
	cp ../srcs_mac/ft_read.s .
	cp ../srcs_mac/ft_strdup.s .
	echo "Step 5: Compiling main.c with libasm.a to form an executable file."
	gcc -Wall -Wextra -Werror main.c libasm.a -o mac_debugger -no-pie
	echo "Step 6: Running the executable file called mac_debugger."
	ddd ./mac_debugger
else
	echo ""
	echo "Please type:"
	echo ""
	echo "bash mac.sh normal   - for normal compile."
	echo "bash mac.sh debugger - for debugger mode with ddd."
	echo ""
fi
