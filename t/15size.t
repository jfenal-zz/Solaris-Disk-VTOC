# in case Test::More ain't there
BEGIN {
    eval { require Test::More; };
    print "1..0\n" and exit if $@;
}

use strict;
use Test::More;
use lib qw( ./lib ../lib );

plan tests => 7;

BEGIN { use_ok('Solaris::Disk::VTOC'); };
require_ok('Solaris::Disk::VTOC');

my $vtoc = new Solaris::Disk::VTOC;

$vtoc->readvtoc(
    device => 'c0t6d0s2',
    source => 't/vtoc.txt'
  );

is($vtoc->size('c0t6d0s2'), 3200, "Size");

is($vtoc->size('c0t6d0sd'), undef, "Size");

is($vtoc->size('c0t6d0', 2), 3200, "Size");

is($vtoc->size('c0t6d0', 16), undef, "Size");

is($vtoc->size(), undef, "Size without disk");

is($vtoc->size('no disk'), undef, "Size with false disk name");

