# in case Test::More ain't there
BEGIN {
    eval { require Test::More; };
    print "1..0\n" and exit if $@;
}

use strict;
use Test::More;
use Data::Dumper;
use lib qw( ./lib ../lib );

BEGIN { plan tests => 4; }

BEGIN { use_ok('Solaris::Disk::VTOC'); };
require_ok('Solaris::Disk::VTOC');

my $vtoc = new Solaris::Disk::VTOC(init => 0);

$vtoc->readvtoc(
    device => 'c0t6d0s2',
    source => 't/vtoc.txt',
    some   => 'garbage',
  );


is_deeply($vtoc, bless( {
                   'c0t6d0' => {
                                 'source' => 't/vtoc.txt',
                                 'slice3' => {
                                               'count' => 3200,
                                               'last' => '1094399',
                                               'begin' => '1091200',
                                               'flag' => '00',
                                               'tag' => '0',
                                               'size' => 1638400
                                             },
                                 'sectorspercyl' => '640',
                                 'cylinders' => '2048',
                                 'slice2' => {
                                               'count' => 3200,
                                               'last' => '1091199',
                                               'begin' => '1088000',
                                               'flag' => '00',
                                               'tag' => '0',
                                               'size' => 1638400
                                             },
                                 'slice6' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'slice7' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'slice0' => {
                                               'count' => 984960,
                                               'last' => '984959',
                                               'begin' => '0',
                                               'flag' => '10',
                                               'tag' => '4',
                                               'size' => 504299520
                                             },
                                 'slice5' => {
                                               'count' => 3200,
                                               'last' => '1100799',
                                               'begin' => '1097600',
                                               'flag' => '00',
                                               'tag' => '0',
                                               'size' => 1638400
                                             },
                                 'bytespersector' => 512,
                                 'sectorspertrack' => '640',
                                 'slice4' => {
                                               'count' => 3200,
                                               'last' => '1097599',
                                               'begin' => '1094400',
                                               'flag' => '00',
                                               'tag' => '0',
                                               'size' => 1638400
                                             },
                                 'slice1' => {
                                               'count' => 103040,
                                               'last' => '1087999',
                                               'begin' => '984960',
                                               'flag' => '10',
                                               'tag' => '2',
                                               'size' => 52756480
                                             },
                                 'accylinders' => '2048'
                               }
                 }, "Solaris::Disk::VTOC" )
                , "Data structure");

$vtoc->readvtoc(
    device => 'cdtdddsd',
    source => 't/data/cdtdddsd.txt',
    init => 1,
  );

ok(!defined $vtoc->{cdtdddsd}, "Badly named device not read");
