echo ""
echo "Thank you for cleaning!"
echo "Always clean after bashing linux.sh or mac.sh."
echo ""
rm -f -r tester_linux
rm -f -r tester_mac
cd srcs_linux
make fclean
cd ../srcs_mac
make fclean
