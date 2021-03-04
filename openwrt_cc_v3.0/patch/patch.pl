#!/usr/bin/perl -w
use Cwd;




my $root_dir = getcwd;

$root_dir =~ s/\/patch//g;
printf("root_dir=$root_dir\n");

system("patch -p0 $root_dir/confs/zx279131.config  zx279131_R4320.patch") == 0 or die "patch confs/zx279131.config failed:$?";
system("patch -p0 $root_dir/toolchain/Config.in  Config_R4320.patch") == 0 or die "patch toolchain/Config.in failed:$?";

#*********************testapp patch*********************
system("patch -p0 $root_dir/package/upointech/testapp/src/testapp2.c  testapp_R4320.patch") == 0 or die "patch package/upointech/testapp/src/testapp2.c failed:$?";

#*********************extcc3.0 patch*********************
#**************for sd5117x*************************
system("patch -p0 $root_dir/package/upointech/extcc3.0/Makefile  extcc3.0_Makefile.patch") == 0 or die "patch package/upointech/extcc3.0/Makefile failed:$?";
