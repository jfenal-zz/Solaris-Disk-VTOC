# in case Test::More ain't there
BEGIN {
    eval { require Test::More; };
    print "1..0\n" and exit if $@;
}

use strict;
use Test::More;
use Data::Dumper;
use lib qw( ./lib ../lib );

plan tests => 3;

BEGIN { use_ok('Solaris::Disk::VTOC'); };
require_ok('Solaris::Disk::VTOC');

my $vtoc = Solaris::Disk::VTOC->new (
	sourcedir => 't/data',
  );

isa_ok($vtoc, 'Solaris::Disk::VTOC');

is_deeply($vtoc, 
bless( {
                   'c4t12d0' => {
                                  'source' => 't/data/c4t12d0s2.txt',
                                  'slice3' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspercyl' => '2889',
                                  'slice2' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'cylinders' => '24622',
                                  'slice6' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'slice7' => {
                                                'count' => 5778,
                                                'last' => '5777',
                                                'begin' => '0',
                                                'flag' => '01',
                                                'tag' => '0',
                                                'size' => 2958336
                                              },
                                  'slice0' => {
                                                'count' => 71121402,
                                                'last' => '71127179',
                                                'begin' => '5778',
                                                'flag' => '00',
                                                'tag' => '0',
                                                'size' => '36414157824'
                                              },
                                  'slice5' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'bytespersector' => 512,
                                  'slice4' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspertrack' => '107',
                                  'slice1' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'accylinders' => '24620'
                                },
                   'c4t10d0' => {
                                  'source' => 't/data/c4t10d0s2.txt',
                                  'slice3' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspercyl' => '2889',
                                  'slice2' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'cylinders' => '24622',
                                  'slice6' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'slice7' => {
                                                'count' => 5778,
                                                'last' => '5777',
                                                'begin' => '0',
                                                'flag' => '01',
                                                'tag' => '0',
                                                'size' => 2958336
                                              },
                                  'slice0' => {
                                                'count' => 71121402,
                                                'last' => '71127179',
                                                'begin' => '5778',
                                                'flag' => '00',
                                                'tag' => '0',
                                                'size' => '36414157824'
                                              },
                                  'slice5' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'bytespersector' => 512,
                                  'slice4' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspertrack' => '107',
                                  'slice1' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'accylinders' => '24620'
                                },
                   'c4t11d0' => {
                                  'source' => 't/data/c4t11d0s2.txt',
                                  'slice3' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspercyl' => '2889',
                                  'slice2' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'cylinders' => '24622',
                                  'slice6' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'slice7' => {
                                                'count' => 5778,
                                                'last' => '5777',
                                                'begin' => '0',
                                                'flag' => '01',
                                                'tag' => '0',
                                                'size' => 2958336
                                              },
                                  'slice0' => {
                                                'count' => 71121402,
                                                'last' => '71127179',
                                                'begin' => '5778',
                                                'flag' => '00',
                                                'tag' => '0',
                                                'size' => '36414157824'
                                              },
                                  'slice5' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'bytespersector' => 512,
                                  'slice4' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspertrack' => '107',
                                  'slice1' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'accylinders' => '24620'
                                },
                   'c3t13d0' => {
                                  'source' => 't/data/c3t13d0s2.txt',
                                  'slice3' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspercyl' => '2889',
                                  'slice2' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'cylinders' => '24622',
                                  'slice6' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'slice7' => {
                                                'count' => 5778,
                                                'last' => '5777',
                                                'begin' => '0',
                                                'flag' => '01',
                                                'tag' => '0',
                                                'size' => 2958336
                                              },
                                  'slice0' => {
                                                'count' => 71121402,
                                                'last' => '71127179',
                                                'begin' => '5778',
                                                'flag' => '00',
                                                'tag' => '0',
                                                'size' => '36414157824'
                                              },
                                  'slice5' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'bytespersector' => 512,
                                  'slice4' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspertrack' => '107',
                                  'slice1' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'accylinders' => '24620'
                                },
                   'c3t12d0' => {
                                  'source' => 't/data/c3t12d0s2.txt',
                                  'slice3' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspercyl' => '2889',
                                  'slice2' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'cylinders' => '24622',
                                  'slice6' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'slice7' => {
                                                'count' => 5778,
                                                'last' => '5777',
                                                'begin' => '0',
                                                'flag' => '01',
                                                'tag' => '0',
                                                'size' => 2958336
                                              },
                                  'slice0' => {
                                                'count' => 71121402,
                                                'last' => '71127179',
                                                'begin' => '5778',
                                                'flag' => '00',
                                                'tag' => '0',
                                                'size' => '36414157824'
                                              },
                                  'slice5' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'bytespersector' => 512,
                                  'slice4' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspertrack' => '107',
                                  'slice1' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'accylinders' => '24620'
                                },
                   'c1t1d0' => {
                                 'source' => 't/data/c1t1d0s2.txt',
                                 'slice3' => {
                                               'count' => 17334,
                                               'last' => '4746626',
                                               'begin' => '4729293',
                                               'flag' => '01',
                                               'tag' => '9',
                                               'size' => 8875008
                                             },
                                 'sectorspercyl' => '2889',
                                 'slice2' => {
                                               'count' => 71127180,
                                               'last' => '71127179',
                                               'begin' => '0',
                                               'flag' => '01',
                                               'tag' => '5',
                                               'size' => '36417116160'
                                             },
                                 'cylinders' => '24622',
                                 'slice6' => {
                                               'count' => 6298020,
                                               'last' => '15245252',
                                               'begin' => '8947233',
                                               'flag' => '00',
                                               'tag' => '4',
                                               'size' => 3224586240
                                             },
                                 'slice7' => {
                                               'count' => 55881927,
                                               'last' => '71127179',
                                               'begin' => '15245253',
                                               'flag' => '00',
                                               'tag' => '8',
                                               'size' => '28611546624'
                                             },
                                 'slice0' => {
                                               'count' => 528687,
                                               'last' => '528686',
                                               'begin' => '0',
                                               'flag' => '00',
                                               'tag' => '2',
                                               'size' => 270687744
                                             },
                                 'slice5' => {
                                               'count' => 4200606,
                                               'last' => '8947232',
                                               'begin' => '4746627',
                                               'flag' => '00',
                                               'tag' => '7',
                                               'size' => 2150710272
                                             },
                                 'bytespersector' => 512,
                                 'slice4' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'sectorspertrack' => '107',
                                 'slice1' => {
                                               'count' => 4200606,
                                               'last' => '4729292',
                                               'begin' => '528687',
                                               'flag' => '01',
                                               'tag' => '3',
                                               'size' => 2150710272
                                             },
                                 'accylinders' => '24620'
                               },
                   'c3t11d0' => {
                                  'source' => 't/data/c3t11d0s2.txt',
                                  'slice3' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspercyl' => '2889',
                                  'slice2' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'cylinders' => '24622',
                                  'slice6' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'slice7' => {
                                                'count' => 5778,
                                                'last' => '5777',
                                                'begin' => '0',
                                                'flag' => '01',
                                                'tag' => '0',
                                                'size' => 2958336
                                              },
                                  'slice0' => {
                                                'count' => 71121402,
                                                'last' => '71127179',
                                                'begin' => '5778',
                                                'flag' => '00',
                                                'tag' => '0',
                                                'size' => '36414157824'
                                              },
                                  'slice5' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'bytespersector' => 512,
                                  'slice4' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspertrack' => '107',
                                  'slice1' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'accylinders' => '24620'
                                },
                   'c3t10d0' => {
                                  'source' => 't/data/c3t10d0s2.txt',
                                  'slice3' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspercyl' => '2889',
                                  'slice2' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'cylinders' => '24622',
                                  'slice6' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'slice7' => {
                                                'count' => 5778,
                                                'last' => '5777',
                                                'begin' => '0',
                                                'flag' => '01',
                                                'tag' => '0',
                                                'size' => 2958336
                                              },
                                  'slice0' => {
                                                'count' => 71121402,
                                                'last' => '71127179',
                                                'begin' => '5778',
                                                'flag' => '00',
                                                'tag' => '0',
                                                'size' => '36414157824'
                                              },
                                  'slice5' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'bytespersector' => 512,
                                  'slice4' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspertrack' => '107',
                                  'slice1' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'accylinders' => '24620'
                                },
                   'c3t8d0' => {
                                 'source' => 't/data/c3t8d0s2.txt',
                                 'slice3' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'sectorspercyl' => '2889',
                                 'slice2' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'cylinders' => '24622',
                                 'slice6' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'slice7' => {
                                               'count' => 5778,
                                               'last' => '5777',
                                               'begin' => '0',
                                               'flag' => '01',
                                               'tag' => '0',
                                               'size' => 2958336
                                             },
                                 'slice0' => {
                                               'count' => 71121402,
                                               'last' => '71127179',
                                               'begin' => '5778',
                                               'flag' => '00',
                                               'tag' => '0',
                                               'size' => '36414157824'
                                             },
                                 'slice5' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'bytespersector' => 512,
                                 'slice4' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'sectorspertrack' => '107',
                                 'slice1' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'accylinders' => '24620'
                               },
                   'c0t0d0' => {
                                 'source' => 't/data/c0t0d0s2.txt',
                                 'slice3' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'sectorspercyl' => 0,
                                 'slice2' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'cylinders' => 0,
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
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'slice5' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'bytespersector' => 0,
                                 'slice4' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'sectorspertrack' => 0,
                                 'slice1' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'accylinders' => 0
                               },
                   'c1t0d0' => {
                                 'source' => 't/data/c1t0d0s2.txt',
                                 'slice3' => {
                                               'count' => 17334,
                                               'last' => '4746626',
                                               'begin' => '4729293',
                                               'flag' => '01',
                                               'tag' => '9',
                                               'size' => 8875008
                                             },
                                 'sectorspercyl' => '2889',
                                 'slice2' => {
                                               'count' => 71127180,
                                               'last' => '71127179',
                                               'begin' => '0',
                                               'flag' => '01',
                                               'tag' => '5',
                                               'size' => '36417116160'
                                             },
                                 'cylinders' => '24622',
                                 'slice6' => {
                                               'count' => 6298020,
                                               'last' => '15245252',
                                               'begin' => '8947233',
                                               'flag' => '00',
                                               'tag' => '4',
                                               'size' => 3224586240
                                             },
                                 'slice7' => {
                                               'count' => 55881927,
                                               'last' => '71127179',
                                               'begin' => '15245253',
                                               'flag' => '00',
                                               'tag' => '8',
                                               'size' => '28611546624'
                                             },
                                 'slice0' => {
                                               'count' => 528687,
                                               'last' => '528686',
                                               'begin' => '0',
                                               'flag' => '00',
                                               'tag' => '2',
                                               'size' => 270687744
                                             },
                                 'slice5' => {
                                               'count' => 4200606,
                                               'last' => '8947232',
                                               'begin' => '4746627',
                                               'flag' => '00',
                                               'tag' => '7',
                                               'size' => 2150710272
                                             },
                                 'bytespersector' => 512,
                                 'slice4' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'sectorspertrack' => '107',
                                 'slice1' => {
                                               'count' => 4200606,
                                               'last' => '4729292',
                                               'begin' => '528687',
                                               'flag' => '01',
                                               'tag' => '3',
                                               'size' => 2150710272
                                             },
                                 'accylinders' => '24620'
                               },
                   'c4t13d0' => {
                                  'source' => 't/data/c4t13d0s2.txt',
                                  'slice3' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspercyl' => '2889',
                                  'slice2' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'cylinders' => '24622',
                                  'slice6' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'slice7' => {
                                                'count' => 5778,
                                                'last' => '5777',
                                                'begin' => '0',
                                                'flag' => '01',
                                                'tag' => '0',
                                                'size' => 2958336
                                              },
                                  'slice0' => {
                                                'count' => 71121402,
                                                'last' => '71127179',
                                                'begin' => '5778',
                                                'flag' => '00',
                                                'tag' => '0',
                                                'size' => '36414157824'
                                              },
                                  'slice5' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'bytespersector' => 512,
                                  'slice4' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspertrack' => '107',
                                  'slice1' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'accylinders' => '24620'
                                },
                   'c4t9d0' => {
                                 'source' => 't/data/c4t9d0s2.txt',
                                 'slice3' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'sectorspercyl' => '2889',
                                 'slice2' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'cylinders' => '24622',
                                 'slice6' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'slice7' => {
                                               'count' => 5778,
                                               'last' => '5777',
                                               'begin' => '0',
                                               'flag' => '01',
                                               'tag' => '0',
                                               'size' => 2958336
                                             },
                                 'slice0' => {
                                               'count' => 71121402,
                                               'last' => '71127179',
                                               'begin' => '5778',
                                               'flag' => '00',
                                               'tag' => '0',
                                               'size' => '36414157824'
                                             },
                                 'slice5' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'bytespersector' => 512,
                                 'slice4' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'sectorspertrack' => '107',
                                 'slice1' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'accylinders' => '24620'
                               },
                   'c3t9d0' => {
                                 'source' => 't/data/c3t9d0s2.txt',
                                 'slice3' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'sectorspercyl' => '2889',
                                 'slice2' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'cylinders' => '24622',
                                 'slice6' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'slice7' => {
                                               'count' => 5778,
                                               'last' => '5777',
                                               'begin' => '0',
                                               'flag' => '01',
                                               'tag' => '0',
                                               'size' => 2958336
                                             },
                                 'slice0' => {
                                               'count' => 71121402,
                                               'last' => '71127179',
                                               'begin' => '5778',
                                               'flag' => '00',
                                               'tag' => '0',
                                               'size' => '36414157824'
                                             },
                                 'slice5' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'bytespersector' => 512,
                                 'slice4' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'sectorspertrack' => '107',
                                 'slice1' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'accylinders' => '24620'
                               },
                   'c4t8d0' => {
                                 'source' => 't/data/c4t8d0s2.txt',
                                 'slice3' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'sectorspercyl' => '2889',
                                 'slice2' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'cylinders' => '24622',
                                 'slice6' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'slice7' => {
                                               'count' => 5778,
                                               'last' => '5777',
                                               'begin' => '0',
                                               'flag' => '01',
                                               'tag' => '0',
                                               'size' => 2958336
                                             },
                                 'slice0' => {
                                               'count' => 71121402,
                                               'last' => '71127179',
                                               'begin' => '5778',
                                               'flag' => '00',
                                               'tag' => '0',
                                               'size' => '36414157824'
                                             },
                                 'slice5' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'bytespersector' => 512,
                                 'slice4' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'sectorspertrack' => '107',
                                 'slice1' => {
                                               'count' => 0,
                                               'last' => 0,
                                               'begin' => 0,
                                               'flag' => '00',
                                               'tag' => 0,
                                               'size' => 0
                                             },
                                 'accylinders' => '24620'
                               },
                   'c4t99d0' => {
                                  'source' => 't/data/c4t99d0s2.txt',
                                  'slice3' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspercyl' => '2889',
                                  'slice2' => {
                                                'count' => 5778,
                                                'last' => '0',
                                                'begin' => '0',
                                                'flag' => '01',
                                                'tag' => '0',
                                                'size' => 2958336
                                              },
                                  'cylinders' => '24622',
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
                                                'count' => 71121402,
                                                'last' => '71127179',
                                                'begin' => '5778',
                                                'flag' => '00',
                                                'tag' => '0',
                                                'size' => '36414157824'
                                              },
                                  'slice5' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'bytespersector' => 512,
                                  'slice4' => {
                                                'count' => 0,
                                                'last' => 0,
                                                'begin' => 0,
                                                'flag' => '00',
                                                'tag' => 0,
                                                'size' => 0
                                              },
                                  'sectorspertrack' => '107',
                                  'slice1' => {
                                                'count' => 5778,
                                                'last' => '5777',
                                                'begin' => '0',
                                                'flag' => '01',
                                                'tag' => '0',
                                                'size' => 2958336
                                              },
                                  'accylinders' => '24620'
                                }
                 }, 'Solaris::Disk::VTOC' )
                , "Data structure");
