#!/bin/bash
###begin documentation##########################################################
#
# Authors: George Ungureanu <ugeorge@kth.se>
#					 Rodolfo Jordao <jordao@kth.se>
# Date:    2021-12-14
# Purpose: Quartus 13.0sp1 Web (Free) edition.
# Comment: The Altera download links are quite resilient, so no worries there.
#          On the other hand, if that fails, go to http://dl.altera.com/?edition=web
#          select version 13.0sp1 and download the combined package. You need
#          to have a valid account on the Altera site, so you might have to 
#          subscribe to them...

# the permalink: https://download.altera.com/akdlm/software/acdsinst/13.0sp1/232/ib_installers/QuartusSetupWeb-13.0.1.232.run
#
###end documentation############################################################

# ARG_OPTIONAL_SINGLE([file-link],[l],[URL to download tar],[https://download.altera.com/akdlm/software/acdsinst/13.0sp1/232/ib_installers/QuartusSetupWeb-13.0.1.232.run])
# ARG_OPTIONAL_BOOLEAN([local],[],[boolean optional argument help msg])
# ARG_OPTIONAL_SINGLE([dest],[d],[Directory to install],[/opt/altera/13.0sp1])
# ARG_OPTIONAL_SINGLE([source],[s],[Directory of local source],[])
# ARG_HELP([Fetch or directly install quartus 13 suite])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.9.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info
# Generated online by https://argbash.io/generate


die()
{
	local _ret="${2:-1}"
	test "${_PRINT_HELP:-no}" = yes && print_help >&2
	echo "$1" >&2
	exit "${_ret}"
}


begins_with_short_option()
{
	local first_option all_short_options='ldsh'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_file_link="https://download.altera.com/akdlm/software/acdsinst/13.0sp1/232/ib_installers/QuartusSetupWeb-13.0.1.232.run"
_arg_local="off"
_arg_dest="/opt/altera/13.0sp1"
_arg_source=


print_help()
{
	printf '%s\n' "Fetch or directly install quartus 13 suite"
	printf 'Usage: %s [-l|--file-link <arg>] [--(no-)local] [-d|--dest <arg>] [-s|--source <arg>] [-h|--help]\n' "$0"
	printf '\t%s\n' "-l, --file-link: URL to download tar (default: 'https://download.altera.com/akdlm/software/acdsinst/13.0sp1/232/ib_installers/QuartusSetupWeb-13.0.1.232.run')"
	printf '\t%s\n' "--local, --no-local: boolean optional argument help msg (off by default)"
	printf '\t%s\n' "-d, --dest: Directory to install (default: '/opt/altera/13.0sp1')"
	printf '\t%s\n' "-s, --source: Directory of local source (no default)"
	printf '\t%s\n' "-h, --help: Prints help"
}


parse_commandline()
{
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			-l|--file-link)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_file_link="$2"
				shift
				;;
			--file-link=*)
				_arg_file_link="${_key##--file-link=}"
				;;
			-l*)
				_arg_file_link="${_key##-l}"
				;;
			--no-local|--local)
				_arg_local="on"
				test "${1:0:5}" = "--no-" && _arg_local="off"
				;;
			-d|--dest)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_dest="$2"
				shift
				;;
			--dest=*)
				_arg_dest="${_key##--dest=}"
				;;
			-d*)
				_arg_dest="${_key##-d}"
				;;
			-s|--source)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_source="$2"
				shift
				;;
			--source=*)
				_arg_source="${_key##--source=}"
				;;
			-s*)
				_arg_source="${_key##-s}"
				;;
			-h|--help)
				print_help
				exit 0
				;;
			-h*)
				print_help
				exit 0
				;;
			*)
				_PRINT_HELP=yes die "FATAL ERROR: Got an unexpected argument '$1'" 1
				;;
		esac
		shift
	done
}

parse_commandline "$@"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash

# make a temporary directory
mkdir -p /tmp/qinstall
# either download the file or use the one copied directly
# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if [ -z $_arg_local ]; then
    # this TAR_FILE is fed from the packer externally
    # make some space since the files are big
    tar xf $_arg_source -C /tmp/qinstall
else
    echo "Downloading quartus..."
    wget --quiet -P /tmp/qinstall $_arg_file_link
    # echo "Extracting quartus..."
    # tar xf /tmp/qinstall/quartus.tar --directory=/tmp/qinstall
    # rm /tmp/qinstall/quartus.tar
fi
# echo "Installing Quartus tools in /opt/altera/13.0sp1..."
# echo "Sit back, relax, grab a milkshake, watch a movie... seriously, it will take ages!"
echo "Installing quartus..."
find /tmp/qinstall -type f -name "QuartusSetupWeb*.run" -exec chmod +x {} \;
find /tmp/qinstall -type f -name "QuartusSetupWeb*.run" -exec {} --mode unattended --unattendedmodeui none --installdir $_arg_dest \;
echo "Finished installing quartus."
# echo "Uninstalling the nasty subscription edition of Modelsim..."
find $_arg_dest/uninstall -type f -name "modelsim_ae-*-uninstall.run" -exec chmod +x {} \;
# chmod +x $_arg_dest/uninstall/modelsim_ae-13.0.1.232-uninstall.run
#cd /opt/altera/13.0sp1
#./uninstall/modelsim_ae-13.0.1.232-uninstall.run --mode unattended
# make some space since the files are big
rm -rf /tmp/qinstall

mkdir -p /etc/profile.d
echo "export PATH=\"$PATH:$_arg_dest/quartus/bin\"" > /etc/profile.d/altera13.sh
echo "alias nios2shell13=\"bash $_arg_dest/nios2eds/nios2_command_shell.sh\"" >> /etc/profile.d/altera13.sh

# ] <-- needed because of Argbash
