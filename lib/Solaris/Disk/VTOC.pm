package Solaris::Disk::VTOC;

use strict;
use Carp;

=head1 NAME

Solaris::Disk::VTOC - Read Solaris VTOC (aka. slices or partitions) from disks

=head1 SYNOPSIS

  use Solaris::Disk::VTOC;;

  $vtoc = Solaris::Disk::VTOC->new();
  $vtoc = Solaris::Disk::VTOC->new(
            sourcedir => "/path/containing/c0t0d0.txt/" );
  $vtoc = Solaris::Disk::VTOC->new(
            init => 1);

  # get c0t0d0 slices. All 3 are valid:
  $vtoc->readvtoc( device => "c0t0d0s0" );
  $vtoc->readvtoc( device => "c0t0d0s7" );
  $vtoc->readvtoc( device => "c0t0d0" );

  # from file
  $vtoc->readvtoc( device => "c0t0d0", source => "/tmp/c0t0d0.dump" );

  # read vtoc from file in a directory
  $vtoc->readvtocdir( "/tmp/" );

  $size = $vtoc->size("c0t0d0s1");    # slice 1
  $size = $vtoc->size("c0t0d0s3");    # slice 3
  $size = $vtoc->size("c0t0d0", 1);   # slice 1
  $size = $vtoc->size("c0t0d0s2", 3); # slice 3

  $vtoc->show("c0t0d0", ...);

  # when code is written:
  $vtoc->dump("c0t0d0");
  $vtoc->format("c0t0d0"); # or should it be `partition' or `slice'?
                           # or `label' 

=head1 DESCRIPTION

Solaris::Disk::VTOC aims to provide methods to read Solaris disks
partitions (aka slices).

=head1 GLOBALS

Two global hashes are defined for completeness. They are not this useful
if you are a used Solaris administrator.

=over

=item *
C<%VTOCSliceType>

Global hash to translate slice types ([0-9a]) to plain english.

=cut

our %VTOCSliceType = (
    0 => "UNASSIGNED",
    1 => "BOOT",
    2 => "ROOT",
    3 => "SWAP",
    4 => "USR",
    5 => "BACKUP",
    6 => "STAND",
    7 => "VAR",
    8 => "HOME",
    9 => "ALTSCTR",
    a => "CACHE",
);

=item *
C<%VTOCSliceFlag>

Global hash to translate partition flags (00, 01, 10, 11) to
format(1M) codes (wm, wu, rm, ru).

=cut

our %VTOCSliceFlag = (
    '00'   => 'wm',
    '01'   => 'wu',
    '10'   => 'rm',
    '11'   => 'ru',
    'long' => {
        '00' => 'read-write, mountable',
        '01' => 'read-write, unmountable',
        '10' => 'read-only, mountable',
        '11' => 'read-only, unmountable',
    }
);

require Exporter;
our %EXPORT_TAGS = ( 'all' => [ qw( VTOCSliceType VTOCSliceFlag ) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our $VERSION = '0.03';

=back

=head1 METHODS

=head2 C<new>

The C<new> method returns a C<Solaris::Disk::VTOC> object, which
will then be used to read partitions for disks, to access these data, or
to dump them in a human or computer readable manner.

=over 

=item *
Create the object, but not initialize:

  my $vtoc = Solaris::Disk::VTOC->new();	

=item *
Create the object, initialize from devices, with prtvtoc(1M) :

  my $vtoc = Solaris::Disk::VTOC->new(init => 1);	

=item *
Create the object, initialize from a directory containing prtvtoc(1M)
dumps (see the C<readvtocdir> method).

  my $vtoc = Solaris::Disk::VTOC->new( sourcedir => '/path/to/dir/' );	

=back

=cut

sub new
{
    my ($class, @args) = @_;

    my $self = {};
	bless $self, $class;

    my %parms;
    my $i = 0;
    my $re = join "|", qw( sourcedir init );
    $re = qr/^(?:$re)$/;
    while( $i < @args ) {
        if( $args[$i] =~ $re ) {
            my ($k, $v) = splice( @args, $i, 2 );
            $parms{$k}  = $v;
        } else {
            $i++
        };
    }
    # shouldn't be anything left in @args
    warn "Solaris::Disk::VTOC->new: Unknown parameter(s): @args" if @args;
	
    if (defined( $parms{sourcedir} ) ) {
        $self->readvtocdir($parms{sourcedir});
    }
    if (defined( $parms{init} ) && $parms{init} ) {
    	foreach my $device (glob "/dev/rdsk/c*t*d*s2") {
			my $devname = substr $device, 10;
			$self->readvtoc( device => $devname );
		}
    }

    return $self;
}


=head2 C<readvtoc>

  $vtoc->readvtoc( device => 'c0t0d0s0' [, source => 'c0t0d0s0.txt' ] );

readvtoc loads the vtoc and disk parameters (bytespersector,
sectorspertrack, sectorspercyl, cylinders and accylinders) in the object
referenced by $vtoc.

Only the controler+target+LUN part of the name is keeped, the slice
number is dropped (C<s2> is used internally).

The C<device> parameter is mandatory, even if it could be read from the
default source (C<prtvtoc /dev/rdsk/$device |>). This will allow further
testing at the expense of a little typing overhead.

The C<source> parameter allows one to specify a different data source
such as a file containing a dump from the C<prtvtoc> command for the
specified disk.

=cut

sub readvtoc( )
{
    my ($self, @args) = @_;
    my %parms;

    my $i = 0;
    my $re = join "|", qw( device source init );
    $re = qr/^(?:$re)$/;
    while( $i < @args ) {
        if( $args[$i] =~ $re ) {
            my ($k, $v) = splice( @args, $i, 2 );
            $parms{$k}  = $v;
        } else {
            $i++
        };
    }
    # shouldn't be anything left in @args
    warn "Solaris::Disk::VTOC->readvtoc: Unknown parameter(s): @args" if @args;

    my $disk;
    if (defined($parms{device}) && $parms{device} =~ m!(c\d+t\d+d\d+)(?:s\d)*!) {
	    $disk = $1; 
    } else {
	    warn "Device name not validated";
	    return;
    }

    # Do not re-read for now
    return if defined( $self->{$disk} );

	# Initialisation of disk parameters

    $self->{$disk}{bytespersector}  = $self->{$disk}{sectorspertrack} =
      $self->{$disk}{sectorspercyl} = $self->{$disk}{cylinders}       =
      $self->{$disk}{accylinders}   = 0;

    # Initialisation as not all slices are reported by prtvtoc(1M)
    foreach my $n ( 0 .. 7 ) {
        my $pn = 'slice' . $n;
        $self->{$disk}{$pn}{tag}   = 0;
        $self->{$disk}{$pn}{flag}  = '00';
        $self->{$disk}{$pn}{begin} = 0;
        $self->{$disk}{$pn}{count} = 0;
        $self->{$disk}{$pn}{last}  = 0;
        $self->{$disk}{$pn}{size}  = 0;
    }

    $self->{$disk}{source} = defined($parms{source})
                           ? $parms{source}
                           : "prtvtoc /dev/rdsk/" . $disk . "s2 |";

    if (!open VTOC, $self->{$disk}{source}) {
      warn "Solaris::Disk::VTOC->readvtoc: Cannot open source "
              . $self->{$disk}{source} . " for disk $disk";
      delete $self->{$disk};
      return;
    }

    while (<VTOC>) {
        $self->{$disk}{bytespersector}  = $1 if m!^\*\s+(\d+) bytes/sector!;
        $self->{$disk}{sectorspertrack} = $1 if m!^\*\s+(\d+) sectors/track!;
        $self->{$disk}{sectorspercyl}   = $1 if m!^\*\s+(\d+) sectors/cylinder!;
        $self->{$disk}{cylinders}       = $1 if m!^\*\s+(\d+) cylinders!;
        $self->{$disk}{accylinders} = $1 if m!^\*\s+(\d+) accessible cylinders!;
        next if ( $_ =~ /^\*.*$/ );

	my @l = split;
	next if 6 != scalar @l;
        my ( $n, $tag, $flag, $fsec, $secount, $lsector ) = @l;
        my $pn = 'slice' . $n;

        #    $self->{$disk}{$pn}{'num'}=$n;
        $self->{$disk}{$pn}{'tag'}   = $tag;
        $self->{$disk}{$pn}{'flag'}  = $flag;
        $self->{$disk}{$pn}{'begin'} = $fsec;
        $self->{$disk}{$pn}{'count'} = $secount;
        $self->{$disk}{$pn}{'last'}  = $lsector;
    }
    if (! close VTOC) {
      warn "Solaris::Disk::VTOC->readvtoc Disk $disk won't reveal its geometry (from "
              . $self->{$disk}{source} . ")";
      
    }

    foreach my $n ( 0 .. 7 ) {
        my $pn = 'slice' . $n;
        $self->{$disk}{$pn}{'size'} =
          $self->{$disk}{$pn}{'count'} * $self->{$disk}{'bytespersector'};
    }
}


=head2 C<readvtocdir>

C<readvtocdir> allows one to specify a directory containing 
prtvtoc(1M) dumps, with names in the form F<c\d+t\d+d\d+[s\d]\.txt>

    @disknames = $vtoc->readvtocdir('/path/to/dir/');

C<readvtocdir> return the list of the disk vtocs found in the given
directory.

=cut

sub readvtocdir($$)
{
    my ($self, $dir) = @_;
    my @disknames;
    
    foreach my $file (glob "$dir/*.txt") {
        if ($file =~ m/(c\d+t\d+d\d+)(?:s\d)*\.txt/ ) {
            $self->readvtoc( device => $1, source => $file );
            push @disknames, $1;
        }
    }

    @disknames;
}

=head2 C<size>

The C<size> method, taking one or two parameters, gives the size of a
slice.

    $vtoc->size( $diskwithslice )
    $vtoc->size( $disk, $slice )

    $vtoc->size( "c0t0d0s1" )           # get slice 1 size for c0t0d0
    $vtoc->size( "c0t0d0", 1 )          # same 
    $vtoc->size( "c0t0d0s0", 1 )        # same

The size() methods returns the block count in a partition specified as
C<cXtXdXsX>

If the disk does not currently exists in the current configuration, it tries to
load it from system.

Bug: no named parameters for now.

=cut

sub size($$)
{
    my ($ssize, $dev, $slice, $disk);
    my $self = shift;

    $dev = shift;

    if (! defined $dev) {
        warn "Solaris::Disk::VTOC->size: You must at least specify a device";
	    return undef;
    }
    $slice = shift;  # Can have no slice defined
    
    if ($dev =~ m!(c\d+t\d+d\d+)! ) {
        $disk = $1;
        if (defined $slice) {
            $slice = 'slice' . $slice;
        } elsif ($dev =~ m!${disk}s(\d+)!) {
            $slice = 'slice' . $1;
        } else {
            warn "Solaris::Disk::VTOC->size: No or invalid slice specified ($dev, $slice)";
            return undef;
        }
    } else {
        warn "Solaris::Disk::VTOC->size: Invalid disk specified ($dev)";
        return undef;
    }

    $self->readvtoc($disk) if not defined $self->{$disk};

    # slice defaults to all zero at disk init in readvtoc
    if (! defined ($ssize = $self->{$disk}{$slice}{count} ) ) {
        warn "Solaris::Disk::VTOC->size: Disk $disk does not exists"
    }

    return $ssize;
}

=head2 C<show>

The C<show> method prints on STDOUT the disk details and partitions for
the diskB<s> asked.

=cut

sub show(@)
{
    my $self = shift;
    my $dev;
    foreach $dev ( sort @_ ) {
        if (defined $self->{$dev}) {
            print "Disk description for $dev\:\n";
            print $self->{$dev}{'bytespersector'}  . " bytes/sector\n";
            print $self->{$dev}{'sectorspertrack'} . " sectors/track\n";
            print $self->{$dev}{'sectorspercyl'}   . " sectors/cylinder\n";
            print $self->{$dev}{'cylinders'}       . " cylinders\n";
            print $self->{$dev}{'accylinders'}     . " accessible cylinders\n";
            print "\n";
            print "Disk $dev VTOC:\n";
            print
" slice  | Usage      | Flag | Sec. Debut | Sec. Fin   | Taille (s) | Taille Mo\n";

            foreach my $slnumber ( 0 .. 7 ) {
                my $slice = $self->{$dev}{ 'slice' . $slnumber };

                #        tag   flag  begin   count last
                printf(
                    "%7s | %10s |   %2s | %10d | %10d | %10d | %5d Mo\n",
                    'slice' . $slnumber,
                    $VTOCSliceType{ $slice->{'tag'} },
                    $VTOCSliceFlag{ $slice->{'flag'} },
                    $slice->{'begin'},
                    $slice->{'count'},
                    $slice->{'last'},
                    $slice->{'count'} >> 11
                );
            }
        }
    }
}

=head2 C<dump>

The C<dump> method, when implemented, will dump in a prtvtoc(1M)
fashion, the information about the specified disk. Its output should be
suitable to feed the fmthard(1M) command.

=head1 BUGS

Not all methods take named parameters for now.

This module has only been tested on Solaris for Sparc. Please contact
the author for feedback about Solaris on Intel and/or AMD.

The dump method is not currently implemented.
Maybe a format method should be implemented as well (could be dangerous,
don't you think?)

=head1 AUTHOR

Jérôme Fenal <jfenal@free.fr>

=head1 VERSION

This is version 0.03 of the Solaris::Disk::VTOC module.

=head1 COPYRIGHT

Copyright (C) 2004 Jérôme Fenal. All Rights Reserved

This module is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SEE ALSO

=over

=item *
The prtvtoc(1M) command and man page.

=item *
The format(1M) command and man page.

=item *
The fmthard(1M) command and man page.


=back

=cut

1;
