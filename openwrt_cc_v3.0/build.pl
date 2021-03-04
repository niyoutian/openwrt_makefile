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
    printf("tmp_dir=$tmp_dir\n");
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
  -h, --help, --version      display this help and exit

for example:
  $P --target testapp
  $P --target testapp,extcc3.0
EOM

        exit($exitcode);
}

my $help = 0;
printf("args=$#ARGV\n");
if ($#ARGV < 0) {
    help(1);
}
GetOptions(
        'target=s'      => \@target,
        'help'        => \$help,
        'version'       => \$help
) or help(1);

help(0) if ($help);


@target = split(/,/, join(',',@target));

my $count = 0;

printf("hello $root_dir\n $confs_dir\n");
print("@target\n");

foreach my $word (@target) {
        next if ($word =~ m/extcc/);
        next if ($word =~ m/testapp/);
	printf("$word is not the right target!\n");
        exit(1);
}

my @confs_files=get_all_conffiles($confs_dir);
for my $filename (@confs_files) {
    next if ($filename eq '.' or $filename eq '..');
    next if (!($filename =~ m/^.+\.config$/));
#    next if ($filename eq 'sd5117x.config');
#    $count++;
#    next if ($count < 25);
#    next if ($filename eq 'zx279127.config');
#    next if ($filename eq 'zx279128.config');
    printf("compile $filename ...\n");
    system("rm -f .config") == 0 or die "[$filename] rm -f .config failed:$?";
    system("ln -sf confs/$filename .config") == 0 or die "[$filename] ln -sf confs/$filename .config failed:$?";
    foreach my $word (@target) {
        printf("make defconfig $filename $word\n");
        system("make defconfig") == 0 or die "[$filename:$word] make defconfig failed:$?";
        if ($word eq "testapp") {
            printf("$filename:$word\n");
            system("sed -i 's/# CONFIG_PACKAGE_testappv3 is not set/CONFIG_PACKAGE_testappv3=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";
        } elsif ($word eq "extcc3.0") {
            printf("$filename:$word\n");
            system("sed -i 's/# CONFIG_PACKAGE_extccv3 is not set/CONFIG_PACKAGE_extccv3=y/g' .config") == 0 or die "[$filename:$word] modify .config failed:$?";		
        }
        system("make prepare") == 0 or die "[$filename:$word] make prepare failed:$?";
        system("make package/upointech/$word/clean") == 0 or die "[$filename:$word] make package/upointech/$word/clean failed:$?";
        system("make package/upointech/$word/compile") == 0 or die "[$filename:$word] make package/upointech/$word/compile failed:$?";;
    }
#    if($count == 38) {
#    exit(0);
#    }
     
}
