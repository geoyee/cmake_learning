#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the sqrt-2.0.1-Linux subdirectory
  --exclude-subdir  exclude the sqrt-2.0.1-Linux subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "sqrt Installer Version: 2.0.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
LICENSE
=======

This is an installer created using CPack (https://cmake.org). No license provided.


____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the sqrt will be installed in:"
    echo "  \"${toplevel}/sqrt-2.0.1-Linux\""
    echo "Do you want to include the subdirectory sqrt-2.0.1-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/sqrt-2.0.1-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +155 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the sqrt-2.0.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� ��Gd �\}pǕ�YI @��F1�&���K���	{��b(�pd'd펤����XJ,�8�����C\N�8q].N�t�������N%\����ꎋ��\GL>�;{�=ݳ=��;�|�S�޼_���M�N�t��6��d!��W������&�І� �m�C���І�p�!,C� ���dP�
yS��P��̘���.UN���"d��ߝ�ܭ���Lz����u��hnl_�P����x�r�=�B@�����>d�u��g��h{�zG��7�s��նug��/,������BoT�����O)aJ�Qu��-N :�=�}����f�t�q�Ȥ�W��6��?�}�!|������jP"SL�rj,�'g��Ëo��-�Fޫ%W��ݨ�4h����w��nD����w�	]��1�������K���73�ͨ�6y��U�|H��Gn��^vR��8���aZ�=#$��K���z�to�`��l �~�諁�!�!L=����$;J	�$��K���j��kW�_�2qR�JV&�g��e�3HcH��oZ���Q�F9�	1\�L<����^T&��D�@��4����Z�Σ�`I���/0u�'��O��?/���+��m��u�B�u[�N��=�L���`��b���r��Zy�ܟ�e}4+k鄜�;�����������B�,ȭ��@�>T�R�p8l\m�D�~����ڲ�� �FX)_B��'z�4�n��[=	�\��{ѿ�"��}����P�*�)�r�w��#�׳�ݸXH����[Y��7�����u�p���qe�?>(�K�.�2��'� ?�0qR��ux�� ?$�_��.��I��Z�^�7�m����� g:���kn�f=��c�u���
q�*jQU#c�$6�T���WbhI�z��>R�e��a u����۶C� Sݝff����x�`Ք��z�P�M�fN3�|,��g3�0��a��^�R�x��mR�Z�����h��׶y{T����D2�<��2}6#���d>���ӛ�U� u���f��ɫ�To���oE�UM�3�<����a)�G5U3�Q،���ˀ� �88_�h�}����3�F���S��|�,b��_��ap?��\<��a�3�G�
�ѿ�����_����y�9�%�<㿎���]"�h�!3���)��?������R�6����=��I- ��		��@`0��h�p)��T-���@ �I��4TNgL= ��F��5��Ӆ@6���9s��#�PNK��u�$�6���=~�����`�}�çH�?B[�L���-� N���TV�:�Sd���r��#,�"��8����m�K�ݒ�~5�[�{�-�K8�Q�������Ϗ H�k8\�x/(oD^f���W�B���a�(s8�����ub?z	��������"��[ ��ϭn7�3]�y.��=����sƷ�b��(��!\��8��?z���u�>����}f����������#�
2�޽ؒ#��X�����D�J���lO���>'�=M�[J�	��73���}�fQv������bd�/�rr��'��>'g�P۴�[r�&'������b7����\N۳�|ZH���K��v#D����i���4料nb��l�<��~�i}�v���lD/o�Sp^�99���I�����D}�HF�G[���L lǅB͌��Y2�����r��D�х���6�j������s�oy���t�"@��'y�Az�N�'+o����k���JAe������N��1��c�Uw�k��7>�S5�5�����ޘ����������X^w��}���X#�Z%w��-�_��� �&�D�
����]�~$�~���:��#�}x��z��8�5��E�Q�� Sqt��U�����20�ى?�[�2��͒������/��	�_c��O;I<1rr��o	N�+���'���T��D�� UNe�h�&g�*Pc}]jB���F��s}]��LZ����*s/!�"	���}'Y\�I��k�H�����h�ƞzB�;h�ǚ�2�hR��
{�8i��f�ɔ;�5�f"�v-�皑����֑����	]%��Z����0UE*VMP?���|� [��6���@��:P�6�P:�8�����]����X	s�A�9��I�tOztꭏ�#h	�b��՟�Fu��.����l��ؾ'Xa�1��o}�<�Ϲ��G8��ܧ
�����N;����Kdn=3��1gGW��}��`p�G��a�3����1x-���=/o`p�� ����?�ǎ$fp�=p���y��ξ?a��ugG�S>���a�>���Gy���������U?_KM���1e�������M[!|���m�ծ���ג�o�G�X�Ĳ��Wlه壶\�忳�J,Ŗ��|Ȗ�`�[���=�\�e��0�]�u>P~����ɏp�AN~���9���)N�Y9����+W&~����3�}��t�e����녚�
Ԯ�no����!�zά���9`]�y��+�!���1�ߴ����3����]9z�B�^T^�h.������!�G��ۤ�azam��ӷ�@Y�8i�(6�f�x�X�I��~�jԓvA[�����B6�bb��2Q8�zb!�5����9����,��BK�Q e�Q���ۙ��?~�g����/ó�YC��'�T��r�A�ϱ=��:ۣ�g�W��o�lZay]��}���F��D�쟮�u�p�_ �}���>NB����Ȩ�s�ݫ5Vt#��9�g�T���_S�'�A�tyY&�P�܊�[���}�erq�U󿝇��,Y&�<�נ�Gs�u֧�ۙ���ȳk��9�[���|J(�����������L�Ku�y|���3�R=>���Ͽ}�3�����y�Gy�Gy�џ/�yn������'�~��O&+<7�  ��ڰ��t!5���GK���|?���������\&cʙ!�m�e����P�n��������쐷���;
�� ?9ʜ:��B�u�X���!G�m�B��ߙ~S,�9	r��%�TG8�1���oRs������QO�,�E��EK��.��z�}��57�H���G����p�T�%�B	��Y�yև���C�mG�(�T>[,�2�?]��-3����NX.ʼ���>1��u����y�Gy�Gy��H4��������Csnvq+v����ع54��$)���yF4����XF8��y������ħH2͑�"I147�O�jh�i�m����:�h���{��E�	��Csm�#��|'��s�MWќZ�
��{�h��D��D>N�D�q�!�R��D._������)H�w��n�w�%|ᓄ!|�u9�;'�O��I�{�VJ�\���
��u���br��	>���kc��e ���|�>���t?�����u�}H	��v��X�P);���gϫ��g��d�b�R�p����`�%��-�7'���%�zo"����Wt�n���% 蒬��%Y�h�?��������R
ǳ���c��ly��s]��� ����K�~���y���sϏ~J��� ��ZA���y��}�||�� ���=_[�yR�?/��������=o�w>����}���s+��]+��*���w	���O
�	���pϻ?*�z�93� U��Ԇ�fah(�Dx�L�q��G��u8�Ԓj����V�L*��M=h	���+��q�ZЭ�i37�
m5QH�Ơ	#����D���À��� f٦AU;{ں�jtGZ<�n�ѯF*=�����j�q玶�X;���j�ܷkpϑw��G�,�w�� ��З��G���df8��޳y�e����	�@�u�B�������df[E X���DgY0��f�m�\jB���,2!�=ʢrY+�Йm#�ɺn�`C�#��7j��G.��# �K�*,n欒�z.o1�����P�e�&�;= tΐ��d|��[CЍԑD�$�n��Ǥ���c�	����Mh�Į��;�įL�	8w�{���f�����-o�����1Ξ�G���"{�3���X���� �t�%��k���]+��)@1J�|g8�4��'姹����rԞ��(o���q�>`���i��gA)�
P~��զԞ�W)��U��������:��������+��ل[�̮����?���~'?���˥�����;9?���8�c~'g+u��.gO�O)?�m;���=��Gί������]Cv�9}����^��YT������۹���$p��b��&룗r���.ok]�����z��x��j{jo�o'�~��`��u|
8w֡�����K�?G�v�t���S���;���b��m�q�`�侳�_��w��%B�d�������]��f�'�B�����H�ŗ]����#�<�菃�ł,� f  