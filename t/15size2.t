# in case Test::More ain't there
BEGIN {
    eval { require Test::More; };
    print "1..0\n" and exit if $@;
}

use strict;
use Test::More;
use lib qw( ./lib ../lib );

plan tests => 2;

BEGIN { use_ok('Solaris::Disk::VTOC'); };
require_ok('Solaris::Disk::VTOC');

my $vtoc = new Solaris::Disk::VTOC;

is($vtoc->size('c99t99d99s16'), undef, "Size of inexistant disk");


