#!/usr/bin/perl -w
use Cwd;
use File::Basename;
use Data::Dumper;
use File::Find;
use strict;
use Getopt::Long;


my $root_dir = getcwd;
my $confs_dir = "$root_dir/confs"; 

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
  --target testapp(,extcc3.0...)   target various comma separated types
  -c, --continue             continue build
  -h, --help, --version      display this help and exit

for example:
  $P --target testapp
  $P --target testapp,extcc3.0,u01,inter_connd
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

foreach my $word (@target) {
        next if ($word =~ m/extcc/);
        next if ($word =~ m/testapp/);
        next if ($word =~ m/u01/);
	next if ($word =~ m/inter_connd/);
	printf("$word is not the right target!\n");
        exit(1);
}

my @confs_files=get_all_conffiles($confs_dir);
for my $filename (@confs_files) {
    next if ($filename eq '.' or $filename eq '..');
    next if (!($filename =~ m/^.+\.config$/));
    next if ($filename eq 'hi5663.config');
#    $count++;
#    next if ($count < 25);
    next if ($filename eq 'zx279127.config');
    next if ($filename eq 'zx279128.config');
    next if ($filename eq 'sd5117x.config');
    next if ($filename eq 'zx279131.config');
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
        } elsif ($word eq "extcc3.0") {
            printf("$filename:$word\n");
            system("sed -i 's/# CONFIG_PACKAGE_extccv3 is not set/CONFIG_PACKAGE_extccv3=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";		
        } elsif ($word eq "u01") {
            printf("$filename:$word\n");
            system("sed -i 's/# CONFIG_PACKAGE_u01v3 is not set/CONFIG_PACKAGE_u01v3=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";
        } elsif ($word eq "inter_connd") {
            printf("$filename:$word\n");
            system("sed -i 's/# CONFIG_PACKAGE_inter_conndv3 is not set/CONFIG_PACKAGE_inter_conndv3=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";
        }
        system("make prepare") == 0 or die "[$filename:$word] make prepare failed:$?";
        system("make package/upointech/$word/clean") == 0 or die "[$filename:$word] make package/upointech/$word/clean failed:$?";
        system("make package/upointech/$word/compile") == 0 or die "[$filename:$word] make package/upointech/$word/compile failed:$?";;
    }
}
