# in case Test::More ain't there
# vim: syntax=perl et ts=4 sw=4 tw=72 ai
BEGIN {
    eval { require Test::More; };
    print "1..0\n" and exit if $@;
}

use strict;
use warnings;
use Test::More;
#use Data::Dumper;
use lib qw( ./lib ../lib );
use Solaris::Disk::VTOC;

my @vtocdisks = (
    # cdrom drive, should have all partitions set to 0
    'c0t0d0',

    # system disk
    'c1t0d0', 'c1t1d0',

    # Splitted D2 enclosure
    'c3t8d0', 'c3t9d0', 'c3t10d0', 'c3t11d0', 'c3t12d0', 'c3t13d0',
    'c4t8d0', 'c4t9d0', 'c4t10d0', 'c4t11d0', 'c4t12d0', 'c4t13d0',
);

plan tests => (
    0               # Number of disk in config matching number of prtvtoc dumps
    + @vtocdisks    # testing presence of disk in $vtoc hash ref
    + 16            # CDROM partitions data set to 0
    + 8             # system disks have the same partition scheme
);

my $vtoc = Solaris::Disk::VTOC->new(
    sourcedir => "t/data/",
    init      => 1,
);

my @vtocfiles = glob "t/data/c*t*d*.txt";
my @conf = sort keys %{$vtoc};
#print Dumper \@conf;

#is( @vtocfiles, @conf, "Number of disk in configuration" );

foreach (@vtocdisks) {
    ok( defined( $vtoc->{$_} ), "Disk in configuration" );
}

foreach (0..7) {
    is( $vtoc->{c0t0d0}->{"slice$_"}->{begin}, 0,
        "CDROM partition $_ start should be 0");
    is( $vtoc->{c0t0d0}->{"slice$_"}->{count}, 0,
        "CDROM partition $_ size should be 0");
}

# system disks happen to be mirrored, with same partition scheme
foreach (0..7) {
    is_deeply(
        $vtoc->{c1t0d0}->{"slice$_"},
        $vtoc->{c1t1d0}->{"slice$_"},
        "Identical partition $_ for system disks"
    );
}

#is_deeply($vtoc, bless( {
#                   'c0t6d0' => {
#                                 'source' => 't/vtoc.txt',
#                                 'slice3' => {
#                                               'count' => 3200,
#                                               'last' => '1094399',
#                                               'begin' => '1091200',
#                                               'flag' => '00',
#                                               'tag' => '0',
#                                               'size' => 1638400
#                                             },
#                                 'sectorspercyl' => '640',
#                                 'cylinders' => '2048',
#                                 'slice2' => {
#                                               'count' => 3200,
#                                               'last' => '1091199',
#                                               'begin' => '1088000',
#                                               'flag' => '00',
#                                               'tag' => '0',
#                                               'size' => 1638400
#                                             },
#                                 'slice6' => {
#                                               'count' => 0,
#                                               'last' => 0,
#                                               'begin' => 0,
#                                               'flag' => '00',
#                                               'tag' => 0,
#                                               'size' => 0
#                                             },
#                                 'slice7' => {
#                                               'count' => 0,
#                                               'last' => 0,
#                                               'begin' => 0,
#                                               'flag' => '00',
#                                               'tag' => 0,
#                                               'size' => 0
#                                             },
#                                 'slice0' => {
#                                               'count' => 984960,
#                                               'last' => '984959',
#                                               'begin' => '0',
#                                               'flag' => '10',
#                                               'tag' => '4',
#                                               'size' => 504299520
#                                             },
#                                 'slice5' => {
#                                               'count' => 3200,
#                                               'last' => '1100799',
#                                               'begin' => '1097600',
#                                               'flag' => '00',
#                                               'tag' => '0',
#                                               'size' => 1638400
#                                             },
#                                 'bytespersector' => 512,
#                                 'sectorspertrack' => '640',
#                                 'slice4' => {
#                                               'count' => 3200,
#                                               'last' => '1097599',
#                                               'begin' => '1094400',
#                                               'flag' => '00',
#                                               'tag' => '0',
#                                               'size' => 1638400
#                                             },
#                                 'slice1' => {
#                                               'count' => 103040,
#                                               'last' => '1087999',
#                                               'begin' => '984960',
#                                               'flag' => '10',
#                                               'tag' => '2',
#                                               'size' => 52756480
#                                             },
#                                 'accylinders' => '2048'
#                               }
#                 }, "Solaris::Disk::VTOC" )
#                , "Data structure");
