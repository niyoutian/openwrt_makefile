#!/usr/bin/perl -w
use Cwd;
use File::Basename;
use Data::Dumper;
use File::Find;
use strict;
use Getopt::Long;


my $root_dir = getcwd; 

my $P = $0;
$P =~ s@.*/@@g;
my $V = 'by niyoutian 2021-02-19';

my @target = ();

sub get_all_conffiles {
    my $tmp_dir = shift @_;
    opendir(TEMP_DIR, $tmp_dir) || die "open $tmp_dir fail...$!";
    my @tmp_files = readdir TEMP_DIR;
    closedir(TEMP_DIR);
    return sort @tmp_files;
}

#------------------------------------------------------------------------- 



sub help {
        my ($exitcode) = @_;

        print << "EOM";
Usage: $P [target]...
Version: $V

Options:
  --target testapp(,extcc...)   target various comma separated types
  -c, --continue             continue build
  -h, --help, --version      display this help and exit

for example:
  ./$P --target testapp
  ./$P --target u01
  ./$P --target extcc
  ./$P --target extccv3
  ./$P --target opmaintain
  ./$P --target opmaintainv3
  ./$P --target inter_connd
  ./$P --target inter_conndv3
  ./$P --target leakmonitor
  ./$P --target testapp,extcc,u01,inter_connd,opmaintain
EOM

        exit($exitcode);
}

my $help = 0;
my $continue = 0;
if ($#ARGV < 0) {
    help(1);
}
GetOptions(
        'target=s'      => \@target,
	'continue|c'      => \$continue,
        'help'        => \$help,
        'version'       => \$help
) or help(1);

help(0) if ($help);


@target = split(/,/, join(',',@target));

my $count = 0;

sub build_sdk3 {
    foreach my $word (@target) {
        next if ($word eq "extccv3");
        next if ($word eq "testapp");
        next if ($word eq "u01");
        next if ($word eq "inter_conndv3");
        next if ($word eq "opmaintainv3");
	next if ($word eq "leakmonitor");
        printf("$word is not the right target!\n");
        exit(1);
    }
    my $confs_dir = "$root_dir/confs";
    my @confs_files=get_all_conffiles($confs_dir);
    for my $filename (@confs_files) {
        next if ($filename eq '.' or $filename eq '..');
        next if (!($filename =~ m/^.+\.config$/));
        #next if ($filename eq 'hi5681.config');
        #    $count++;
        #    next if ($count < 25);
        next if ($filename eq 'zx279127.config');
        next if ($filename eq 'zx279128.config');
        #next if ($filename eq 'sd5117x.config');
        #next if ($filename eq 'zx279131.config');
        printf("compile $filename ...\n");
        system("rm -f .config") == 0 or die "[$filename] rm -f .config failed:$?";
        system("ln -sf confs/$filename .config") == 0 or die "[$filename] ln -sf confs/$filename .config failed:$?";
        foreach my $word (@target) {
            if ($continue eq 1) {
                my $temp = $filename =~ s/^(.*).config$/$1/r;
                my $tmp_dir = "$root_dir/bin/$temp/packages/base";
                my @file_list = glob "$tmp_dir/$word*$temp.ipk";
                next if (@file_list);
            }
            printf("make defconfig $filename $word\n");
            system("make defconfig") == 0 or die "[$filename:$word] make defconfig failed:$?";
			if ($word eq "testapp") {
				printf("$filename:$word\n");
				system("sed -i 's/# CONFIG_PACKAGE_testappv3 is not set/CONFIG_PACKAGE_testappv3=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";
			} elsif ($word eq "extccv3") {
				printf("$filename:$word\n");
				system("sed -i 's/# CONFIG_PACKAGE_extccv3 is not set/CONFIG_PACKAGE_extccv3=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";		
			} elsif ($word eq "u01") {
				printf("$filename:$word\n");
				system("sed -i 's/# CONFIG_PACKAGE_u01v3 is not set/CONFIG_PACKAGE_u01v3=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";
			} elsif ($word eq "inter_conndv3") {
				printf("$filename:$word\n");
				system("sed -i 's/# CONFIG_PACKAGE_inter_conndv3 is not set/CONFIG_PACKAGE_inter_conndv3=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";
			} elsif ($word eq "opmaintainv3") {
			    printf("$filename:$word\n");
			    system("sed -i 's/# CONFIG_PACKAGE_opmaintainv3 is not set/CONFIG_PACKAGE_opmaintainv3=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";
		    } elsif ($word eq "leakmonitor") {
                printf("$filename:$word\n");
                system("sed -i 's/# CONFIG_PACKAGE_leakmonitor is not set/CONFIG_PACKAGE_leakmonitor=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";
            }

			system("make prepare") == 0 or die "[$filename:$word] make prepare failed:$?";
			system("make package/upointech/$word/clean") == 0 or die "[$filename:$word] make package/upointech/$word/clean failed:$?";
			if ($word eq "opmaintain") {
				system("make package/network/utils/curl/clean") == 0 or die "[$filename:$word] make  package/network/utils/curl/clean failed:$?";
				system("make package/network/utils/curl/compile") == 0 or die "[$filename:$word] make  package/network/utils/curl/compile failed:$?";
			}
			system("make package/upointech/$word/compile") == 0 or die "[$filename:$word] make package/upointech/$word/compile failed:$?";
		}
    }
}

sub build_sdk2 {
    foreach my $word (@target) {
        next if ($word eq "extcc");
        next if ($word eq "testapp");
        next if ($word eq "u01");
        next if ($word eq "inter_connd");
        next if ($word eq "opmaintain");
        next if ($word eq "leakmonitor");
        printf("$word is not the right target!\n");
        exit(1);
    }
    my $confs_dir = "$root_dir";
    print "build_sdk2 \n";
    print "confs_dir=$confs_dir\n";
    my @confs_files=get_all_conffiles($confs_dir);
    for my $filename (@confs_files) {
        next if (!($filename =~ m/^.+\.config$/));
        next if ($filename eq 'zte-bcm6858.config');
        printf("compile $filename ...\n");
        system("rm -f .config") == 0 or die "[$filename] rm -f .config failed:$?";
        system("ln -sf $filename .config") == 0 or die "[$filename] ln -sf $filename .config failed:$?";
        foreach my $word (@target) {
            if ($continue eq 1) {
                my $temp = $filename =~ s/^.*-(.*).config$/$1/r;
                print "temp=$temp\n";
                $temp = "sd5116" if ($temp eq "5116");
                $temp = "sd5116v1" if ($temp eq "5116v1");
                $temp = "zx279100" if ($temp eq "279100");
                $temp = "zx279127" if ($temp eq "279127");
                $temp = "zx279128" if ($temp eq "279128");
                print "temp2=$temp\n";
                my $tmp_dir = "$root_dir/bin/$temp/packages/base";
                my @file_list = glob "$tmp_dir/$word*$temp.ipk";
                next if (@file_list);
            }
            printf("make defconfig $filename $word\n");
            system("make defconfig") == 0 or die "[$filename:$word] make defconfig failed:$?";
			if ($word eq "testapp") {
				printf("$filename:$word\n");
				system("sed -i 's/# CONFIG_PACKAGE_testapp is not set/CONFIG_PACKAGE_testapp=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";
			} elsif ($word eq "extcc") {
				printf("$filename:$word\n");
				system("sed -i 's/# CONFIG_PACKAGE_extcc is not set/CONFIG_PACKAGE_extcc=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";		
			} elsif ($word eq "u01") {
				printf("$filename:$word\n");
				system("sed -i 's/# CONFIG_PACKAGE_u01 is not set/CONFIG_PACKAGE_u01=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";
			} elsif ($word eq "inter_connd") {
				printf("$filename:$word\n");
				system("sed -i 's/# CONFIG_PACKAGE_inter_connd is not set/CONFIG_PACKAGE_inter_connd=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";
			} elsif ($word eq "opmaintain") {
                printf("$filename:$word\n");
                system("sed -i 's/# CONFIG_PACKAGE_curl is not set/CONFIG_PACKAGE_curl=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";
                system("sed -i 's/# CONFIG_PACKAGE_opmaintain is not set/CONFIG_PACKAGE_opmaintain=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";
            } elsif ($word eq "leakmonitor") {
                printf("$filename:$word\n");
                system("sed -i 's/# CONFIG_PACKAGE_leakmonitor is not set/CONFIG_PACKAGE_leakmonitor=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";
            }
			system("make prepare") == 0 or die "[$filename:$word] make prepare failed:$?";
			system("make package/upointech/$word/clean") == 0 or die "[$filename:$word] make package/upointech/$word/clean failed:$?";
            system("make package/upointech/$word/compile") == 0 or die "[$filename:$word] make package/upointech/$word/compile failed:$?";
        }
    }
}

my $sdk_ver = 0;
$sdk_ver = 2 if ($root_dir =~ /openwrt_cc/);
$sdk_ver = 3 if ($root_dir =~ /openwrt_cc_v3.0/);
print "sdk_ver = $sdk_ver\n";
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
printf("build start time %04d-%02d-%02d %02d:%02d:%02d\n", $year+1900, $mon, $mday, $hour, $min, $sec);
build_sdk2() if ($sdk_ver == 2);
build_sdk3() if ($sdk_ver == 3);
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
printf("build stop time %04d-%02d-%02d %02d:%02d:%02d\n", $year+1900, $mon, $mday, $hour, $min, $sec);
exit(0);
